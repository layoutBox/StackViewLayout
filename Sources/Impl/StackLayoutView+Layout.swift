//  Copyright (c) 2017 Luc Dion
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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
    
    
class Container {
    var width: CGFloat?
    var height: CGFloat?
    var items: [ItemInfo] = []
}
    
//class ParentInfo {
//    var width: CGFloat
//    var height: CGFloat
//}
    
class ItemInfo {
    var view: UIView
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?

    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
//    var parent: ParentInfo?
    
    init(_ view: UIView, container: Container) {
        self.view = view
//        self.parent = parent
        
        if let stackItem = view.item as? StackItemImpl {
            self.width = resolveWidthValue(stackItem.width, container: container)
            self.minWidth = resolveWidthValue(stackItem.minWidth, container: container)
            self.maxWidth = resolveWidthValue(stackItem.maxWidth, container: container)
            
            self.height = resolveHeightValue(stackItem.height, container: container)
            self.minHeight = resolveHeightValue(stackItem.minHeight, container: container)
            self.maxHeight = resolveHeightValue(stackItem.maxHeight, container: container)
        }
    }
}
    
    
extension StackLayoutView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container()
        container.width = frame.size.width
        container.height = frame.size.height
        layoutItems(container: container, measure: false)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container()
        container.width = size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width
        container.height = size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height
        let size = layoutItems(container: container, measure: true)
        return size
    }
    
    @discardableResult
    private func layoutItems(container: Container, measure: Bool) -> CGSize {
        
        measuresItems(container: container)
        
        let totalHeight = container.items.reduce(0, { (result, itemInfo) -> CGFloat in
            return result + (itemInfo.height != nil ? itemInfo.height! : 0)
        })
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        
        switch justifyContent {
        case .start:
            yOffset = 0
        case .center:
            if let containerHeight = container.height {
                yOffset = (containerHeight - totalHeight) / 2
            }
        case .end:
            if let containerHeight = container.height {
                yOffset = containerHeight - totalHeight
            }
        case .spaceBetween:
            assert(false)
        case .spaceAround:
            assert(false)
        }
        
        container.items.forEach({ (itemInfo) in
            var x = xOffset
            var width = itemInfo.width!
            
            if let containerWidth = container.width {
                switch alignItems {
                case .stretch: width = containerWidth
                case .start:   break
                case .center:  x = (containerWidth - itemInfo.width!) / 2
                case .end:     x = containerWidth - itemInfo.width!
                }
            }
            itemInfo.view.frame = CGRect(x: x, y: yOffset, width: width, height: itemInfo.height!)
            
            if itemInfo.view.frame.maxX > maxX {
                maxX = itemInfo.view.frame.maxX
            }
            if itemInfo.view.frame.maxY > maxY {
                maxY = itemInfo.view.frame.maxY
            }
            
            yOffset = itemInfo.view.frame.maxY
        })
        
        return CGSize(width: maxX, height: maxY)
    }
    
    private func measuresItems(container: Container) {
        subviews.forEach{ (view) in
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let itemInfo = ItemInfo(view, container: container)
            
            if self.direction == .column {
                if let containerWidth = container.width {
                    if itemInfo.width ==  nil {
                        itemInfo.width = containerWidth
                    }
                }
                
                if container.height != nil {
                    if let itemHeight = stackItem.height?.value {
                        itemInfo.height = itemHeight
                    }
                }
                
                // Measure the view
                if itemInfo.width != nil && itemInfo.height == nil {
                    let newSize = view.sizeThatFits(CGSize(width: itemInfo.width!, height: .greatestFiniteMagnitude))
                    itemInfo.width = newSize.width
                    itemInfo.height = newSize.height
                } else if itemInfo.width == nil && itemInfo.height != nil {
                    let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: itemInfo.height!))
                    itemInfo.width = newSize.width
                    itemInfo.height = newSize.height
                }
                
                if alignItems == .stretch, let containerWidth = container.width {
                    itemInfo.width = containerWidth
                }
                
                itemInfo.width = applyWidthMinMax(itemInfo)
                itemInfo.height = applyHeightMinMax(itemInfo)
                
                container.items.append(itemInfo)
            }
        }
    }
}
    
private func resolveWidthValue(_ value: Value?, container: Container) -> CGFloat? {
    guard let value = value else { return nil }
    switch value.unit {
    case .point:   return value.value
    case .percent: return container.width != nil ? (container.width! * value.value / 100) : nil
    }
}

private func resolveHeightValue(_ value: Value?, container: Container) -> CGFloat? {
    guard let value = value else { return nil }
    switch value.unit {
    case .point:   return value.value
    case .percent: return container.height != nil ? (container.height! * value.value / 100) : nil
    }
}
    
private func applyWidthMinMax(_ itemInfo: ItemInfo) -> CGFloat? {
    var result = itemInfo.width
    //        var stackItem = itemInfo.view.item
    
    // Handle minWidth
    if let minWidth = itemInfo.minWidth, minWidth > (result ?? 0) {
        result = minWidth
    }
    
    // Handle maxWidth
    if let maxWidth = itemInfo.maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxWidth
    }
    
    return result
}
    
private func applyHeightMinMax(_ itemInfo: ItemInfo) -> CGFloat? {
    var result = itemInfo.height
    //        var stackItem = itemInfo.view.item
    // Handle minHeight
    if let minHeight = itemInfo.minHeight, minHeight > (result ?? 0) {
        result = minHeight
    }
    
    // Handle maxHeight
    if let maxHeight = itemInfo.maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxHeight
    }
    
    return result
}

#endif
