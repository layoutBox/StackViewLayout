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
    let direction: SDirection
    var width: CGFloat?
    var height: CGFloat?
    var items: [ItemInfo] = []
    
    var mainAxisLength: CGFloat? {
        return direction == .column ? height : width
    }
    
    var crossAxisLength: CGFloat? {
        return direction == .column ? width : height
    }
    
    var mainAxisTotalItemsLength: CGFloat = 0
    
    init(direction: SDirection) {
        self.direction = direction
    }
    
    func updateMainAxisTotalLength() {
        mainAxisTotalItemsLength = 0
        
        items.forEach({ (item) in
            mainAxisTotalItemsLength += item.mainAxisStartMargin ?? 0
            
            if direction == .column {
                mainAxisTotalItemsLength += (item.height != nil ? item.height! : 0)
            } else {
                mainAxisTotalItemsLength += (item.width != nil ? item.width! : 0)
            }
            
            mainAxisTotalItemsLength += item.mainAxisEndMargin ?? 0
        })
    }
    
    func growFactorTotal() -> CGFloat {
        return items.reduce(0, { (result, itemInfo) -> CGFloat in
            return result + itemInfo.growFactor()
        })
    }
    
    func shrinkFactorTotal() -> CGFloat {
        return items.reduce(0, { (result, itemInfo) -> CGFloat in
            return result + itemInfo.shrinkFactor()
        })
    }
}
    
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
            let adjustedFitWidth = applyMargins ? stackItem.applyMargins(toWidth: fitWidth) : fitWidth
            let newSize = view.sizeThatFits(CGSize(width: adjustedFitWidth, height: .greatestFiniteMagnitude))
            height = minValueOptional(newSize.height, container.height)
            
            if width == nil {
                width = min(newSize.width, adjustedFitWidth)
            }
        } else if let fitHeight = fitHeight, width == nil {
            let adjustedFitHeight = applyMargins ? stackItem.applyMargins(toHeight: fitHeight) : fitHeight
            let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: adjustedFitHeight))
            width = minValueOptional(newSize.width, container.width)
            
            if height == nil {
                height = min(newSize.height, adjustedFitHeight)
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
    
extension StackView {
    // TODO: Tests StackView using autolayout
    public override var intrinsicContentSize: CGSize {
        let container = Container(direction: direction)
        container.width = nil
        container.height = nil
        return layoutItems(container: container)
    }
    
    // TODO: Tests StackView using autolayout
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return super.systemLayoutSizeFitting(targetSize)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container(direction: direction)
        container.width = bounds.size.width
        container.height = bounds.size.height
        layoutItems(container: container)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container(direction: direction)
        container.width = size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width
        container.height = size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height
        return layoutItems(container: container)
    }
    
    @discardableResult
    internal func layoutItems(container: Container) -> CGSize {
        var mainAxisOffset: CGFloat = 0
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength
        
        var startEndSpacing: CGFloat = 0
        var betweenSpacing: CGFloat = 0
        
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0

        // Measures stack's items and add them in the Container.items array.
        measuresItemsAndMargins(container: container)
        
        adjustItemsSizeToContainer(container: container)
        
        let mainAxisTotalItemsLength = container.mainAxisTotalItemsLength
        
        if let mainAxisLength = containerMainAxisLength {
            switch justifyContent {
            case .start:
                mainAxisOffset = 0
            case .center:
                mainAxisOffset = (mainAxisLength - mainAxisTotalItemsLength) / 2
            case .end:
                mainAxisOffset = mainAxisLength - mainAxisTotalItemsLength
            case .spaceBetween:
                betweenSpacing = (mainAxisLength - mainAxisTotalItemsLength) / CGFloat(container.items.count - 1)
            case .spaceAround:
                betweenSpacing = (mainAxisLength - mainAxisTotalItemsLength) / CGFloat(container.items.count)
                startEndSpacing = betweenSpacing / 2
            case .spaceEvenly:
                betweenSpacing = (mainAxisLength - mainAxisTotalItemsLength) / CGFloat(container.items.count + 1)
                startEndSpacing = betweenSpacing
            }
        }
        
        for (index, item) in container.items.enumerated() {
            let stackItem = item.stackItem
            //
            // Handle main-axis position
            if index == 0 {
                mainAxisOffset += max(item.mainAxisStartMargin ?? 0, startEndSpacing)
            } else {
                mainAxisOffset += max(item.mainAxisStartMargin ?? 0, betweenSpacing)
            }
            
            //
            // Handle cross-axis position
            var itemCrossAxisLength = item.crossAxisLength
            var crossAxisPos = stackItem.crossAxisStartMargin(container: container)
            let crossAxisEndMargin = stackItem.crossAxisEndMargin(container: container)
            
            if let containerCrossAxisLength = containerCrossAxisLength {
                switch stackItem.resolveStackItemAlign(stackAlignItems: alignItems) {
                case .stretch:
                    if item.isCrossAxisFlexible {
                        itemCrossAxisLength = stackItem.applyMargins(toCrossAxisLength: containerCrossAxisLength, container: container)
                    }
                case .start:
                    // nop
                    break
                case .center:
                    // Takes margins into account when centering items (compatible with flexbox).
                    let itemCrossAxisForCentering = itemCrossAxisLength -
                                                    stackItem.crossAxisStartMargin(container: container) +
                                                    crossAxisEndMargin
                    crossAxisPos = (containerCrossAxisLength - itemCrossAxisForCentering) / 2
                case .end:
                    crossAxisPos = containerCrossAxisLength - itemCrossAxisLength - crossAxisEndMargin
                }

                let crossAxisStartMargin = stackItem.crossAxisStartMargin(container: container)
                crossAxisPos = max(crossAxisPos, crossAxisStartMargin)
                
                // Check if we must reduce the item's cross axis length to respect its cross axis margins
                if item.isCrossAxisFlexible && (crossAxisPos + itemCrossAxisLength + crossAxisEndMargin > containerCrossAxisLength) {
                    itemCrossAxisLength = max(0, containerCrossAxisLength - crossAxisPos - crossAxisEndMargin)
                }
            }
            
            let viewFrame  = direction == .column ? CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: item.height!) :
                                                    CGRect(x: mainAxisOffset, y: crossAxisPos, width: item.width!, height: itemCrossAxisLength)
            
            let itemViewRect = Coordinates.adjustRectToDisplayScale(viewFrame)
            Coordinates.setUntransformedViewRect(item.view, toRect: itemViewRect)
            
            mainAxisOffset = direction == .column ? itemViewRect.maxY :  itemViewRect.maxX
            mainAxisOffset += (item.mainAxisEndMargin ?? 0)
            
            if direction == .column {
                maxX = max(itemViewRect.maxX + crossAxisEndMargin, maxX)
                maxY = mainAxisOffset
            } else {
                maxX = mainAxisOffset
                maxY = max(itemViewRect.maxY + crossAxisEndMargin, maxY)
            }
        }

        return CGSize(width: maxX, height: maxY)
    }
    
    private func measuresItemsAndMargins(container: Container) {
        stackItems.forEach{ (stackItem) in
            let view = stackItem.view
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let item = ItemInfo(stackItem, container: container)
            
            // Compute width & height
            item.measureItem(container: container, applyMargins: true)
            
            // Compute item main-axis margins.
            item.mainAxisStartMargin = stackItem.mainAxisStartMargin(container: container)
            item.mainAxisEndMargin = stackItem.mainAxisEndMargin(container: container)

            container.items.append(item)
        }
        
        container.updateMainAxisTotalLength()
    }
    
    private func adjustItemsSizeToContainer(container: Container) {
        guard let containerMainAxisLength = container.mainAxisLength else { return }
        var lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
        let delta = Coordinates.onePixelLength + 0.001

        if lengthDiff > delta {
            // Grow
            var growFactorTotal: CGFloat = 0
            repeat {
                growFactorTotal = container.growFactorTotal()
                
                if growFactorTotal > 0 {
                    let factorLength = lengthDiff / growFactorTotal
                    
                    for item in container.items {
                        guard let itemMainAxisLength = item.mainAxisLength else { continue }
                        let growFactor = item.growFactor()
                        
                        if growFactor > 0 {
                            item.resetToStackItemProperties(container: container)
                            item.mainAxisLength = itemMainAxisLength + growFactor * factorLength
                            item.measureItem(container: container, applyMargins: false)
                        }
                    }
                    
                    container.updateMainAxisTotalLength()
                    lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
                }
            } while growFactorTotal > 0 && lengthDiff > delta
            
        } else if lengthDiff < -delta {
            // Shrink
            var shrinkFactorTotal: CGFloat = 0
            
            repeat {
                shrinkFactorTotal = container.shrinkFactorTotal()
                
                if shrinkFactorTotal > 0 {
                    let factorLength = lengthDiff / shrinkFactorTotal
                    
                    for item in container.items {
                        guard let itemMainAxisLength = item.mainAxisLength else { continue }
                        let shrinkFactor = item.shrinkFactor()
                        
                        if shrinkFactor > 0 {
                            item.resetToStackItemProperties(container: container)
                            item.mainAxisLength = itemMainAxisLength + shrinkFactor * factorLength
                            item.measureItem(container: container, applyMargins: false)
                        }
                    }
                    container.updateMainAxisTotalLength()
                    lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
                }
            } while shrinkFactorTotal > 0 && lengthDiff < -delta
        }
    }
}

#endif
