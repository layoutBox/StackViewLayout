
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class ItemInfo {
    var view: UIView
    var stackItem: StackItemImpl
    
    private var _width: CGFloat?
    var width: CGFloat? {
        get {
            return _width
        }
        set {
            _width = newValue?.roundUsingDisplayScale()
            
            if let minWidth = minWidth, minWidth > (width ?? 0) {
                _width = minWidth
            }
            
            if let maxWidth = maxWidth, maxWidth < (width ?? CGFloat.greatestFiniteMagnitude) {
                _width = maxWidth
            }
        }
    }
    
    var minWidth: CGFloat?
    var maxWidth: CGFloat?
    
    private var _height: CGFloat?
    var height: CGFloat? {
        get {
            return _height
        }
        set {
            _height = newValue?.roundUsingDisplayScale()
            if let minHeight = minHeight, minHeight > (_height ?? 0) {
                _height = minHeight
            }
            
            if let maxHeight = maxHeight, maxHeight < (_height ?? CGFloat.greatestFiniteMagnitude) {
                _height = maxHeight
            }
        }
    }
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
    var mainAxisLength: CGFloat? {
        get {
            return direction == .column ? height : width
        }
        set {
            let value = newValue != nil ? max(0, newValue!)/*.roundUsingDisplayScale()*/ : nil
            if direction == .column {
                height = value
            } else {
                width = value
            }
        }
    }
    
    var mainAxisMaxLength: CGFloat? {
        return direction == .column ? maxHeight : maxWidth
    }
    
    var mainAxisMinLength: CGFloat? {
        return direction == .column ? minHeight : minWidth
    }
    
    var crossAxisLength: CGFloat {
        assert(width != nil || height != nil)
        return direction == .column ? width! : height!
    }
    
    private(set) var isCrossAxisFlexible: Bool = true
    
    var mainAxisStartMargin: CGFloat?
    var mainAxisEndMargin: CGFloat?
    
    var basis: CGFloat {
        return mainAxisLength ?? 1
    }
    
    private let direction: SDirection
    
    init(_ stackItem: StackItemImpl, container: Container) {
        self.stackItem = stackItem
        self.view = stackItem.view
        self.direction = container.direction
        
        resetToStackItemProperties(container: container)
    }
    
    func resetToStackItemProperties(container: Container) {
        if let stackItem = view.item as? StackItemImpl {
            self.width = stackItem.width?.resolveWidth(container: container)
            self.minWidth = stackItem.minWidth?.resolveWidth(container: container)
            self.maxWidth = stackItem.maxWidth?.resolveWidth(container: container)
            
            self.height = stackItem.height?.resolveHeight(container: container)
            self.minHeight = stackItem.minHeight?.resolveHeight(container: container)
            self.maxHeight = stackItem.maxHeight?.resolveHeight(container: container)
            
            self.isCrossAxisFlexible = direction == .column ? (width == nil) : (height == nil)
        }
    }
    
    func measureItem(container: Container, applyMargins: Bool) {
        guard width == nil || height == nil else { return }
        var applyMargins = applyMargins
        var fitWidth: CGFloat?
        var fitHeight: CGFloat?
        
        if let itemWidth = width {
            fitWidth = itemWidth
            applyMargins = false
        } else if let itemHeight = height {
            fitHeight = itemHeight
            applyMargins = false
        } else if let containerWidth = container.width {
            fitWidth = containerWidth
        } else if let containerHeight = container.height {
            fitHeight = containerHeight
        }
        
        //        if direction == .column {
        //            if let itemWidth = width {
        //                fitWidth = itemWidth
        //            } else if let itemHeight = height {
        //                fitHeight = itemHeight
        //            } else if let containerWidth = container.width {
        //                fitWidth = containerWidth
        //            } else if let containerHeight = container.height {
        //                fitHeight = containerHeight
        //            }
        //        } else {
        //            if let itemHeight = height {
        //                fitHeight = itemHeight
        //            } else if let itemWidth = width {
        //                fitWidth = itemWidth
        //            } else if let containerWidth = container.width {
        //                fitWidth = containerWidth
        //            } else if let containerHeight = container.height {
        //                fitHeight = containerHeight
        //            }
        //        }

        // Measure the view using sizeThatFits(:CGSize)
        if let fitWidth = fitWidth, height == nil {
            if let aspectRatio = stackItem._aspectRatio {
                width = fitWidth
                height = fitWidth / aspectRatio
            } else {
                let adjustedFitWidth = applyMargins ? stackItem.applyMargins(toWidth: fitWidth) : fitWidth
                let newSize = view.sizeThatFits(CGSize(width: adjustedFitWidth, height: .greatestFiniteMagnitude))
                height = minValueOptional(newSize.height, container.height)

                if width == nil {
                    width = min(newSize.width, adjustedFitWidth)
                }
            }
        } else if let fitHeight = fitHeight, width == nil {
            if let aspectRatio = stackItem._aspectRatio {
                width = fitHeight * aspectRatio
                height = fitWidth
            } else {
                let adjustedFitHeight = applyMargins ? stackItem.applyMargins(toHeight: fitHeight) : fitHeight
                let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: adjustedFitHeight))
                width = minValueOptional(newSize.width, container.width)
                
                if height == nil {
                    height = min(newSize.height, adjustedFitHeight)
                }
            }
        }
        assert(height != nil && width != nil, "should not occurred")
    }
    
    func growFactor() -> CGFloat {
        guard let mainAxisLength = mainAxisLength, mainAxisLength != 0 else { return 0 }
        
        if let mainAxisMaxLength = mainAxisMaxLength, mainAxisLength >= mainAxisMaxLength {
            return 0
        } else if let growFactor = stackItem.grow {
            return growFactor
        } else {
            return 0
        }
    }
    
    func shrinkFactor() -> CGFloat {
        guard let mainAxisLength = mainAxisLength, mainAxisLength != 0 else { return 0 }
        
        if let mainAxisMinLength = mainAxisMinLength, mainAxisLength <= mainAxisMinLength {
            return 0
        } else if let shrink = stackItem.shrink {
            return shrink * basis
        } else {
            return 0
        }
    }
}

