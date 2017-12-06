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
    
    var mainAxisTotalItemsLength: CGFloat {
        let itemCount = items.count
        var length: CGFloat = 0
        
        for (index, item) in items.enumerated() {
            // Add item's size
            if direction == .column {
                length += (item.height != nil ? item.height! : 0)
            } else {
                length += (item.width != nil ? item.width! : 0)
            }
            
            // Add item's margins
            if index == 0 {
                length += item.mainAxisStartMargin ?? 0
            } else if index == itemCount - 1 {
                length += item.mainAxisEndMargin ?? 0
            } else {
                length += item.mainAxisStartMargin ?? 0
            }
        }
        return length
    }
    
    init(direction: SDirection) {
        self.direction = direction
    }
}
    
class ItemInfo {
    var view: UIView
    var stackItem: StackItemImpl
    
    var width: CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?

    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
    var mainAxisStartMargin: CGFloat?
    var mainAxisEndMargin: CGFloat?
    
    init(_ stackItem: StackItemImpl, container: Container) {
        self.stackItem = stackItem
        self.view = stackItem.view
        
        if let stackItem = view.item as? StackItemImpl {
            self.width = stackItem.width?.resolveWidth(container: container)
            self.minWidth = stackItem.minWidth?.resolveWidth(container: container)
            self.maxWidth = stackItem.maxWidth?.resolveWidth(container: container)
            
            self.height = stackItem.height?.resolveHeight(container: container)
            self.minHeight = stackItem.minHeight?.resolveHeight(container: container)
            self.maxHeight = stackItem.maxHeight?.resolveHeight(container: container)
        }
    }
}
    
extension StackLayoutView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container(direction: direction)
        container.width = frame.size.width
        container.height = frame.size.height
        layoutItems(container: container, measure: false)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container(direction: direction)
        container.width = size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width
        container.height = size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height
        let size = layoutItems(container: container, measure: true)
        return size
    }
    
    @discardableResult
    private func layoutItems(container: Container, measure: Bool) -> CGSize {
        var mainAxisOffset: CGFloat = 0
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength
        
        var startEndSpacing: CGFloat = 0
        var betweenSpacing: CGFloat = 0
        
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0

        // Measures stack's items and add them in the Container.items array.
        measuresItemsAndMargins(container: container)
    
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
            var crossAxisPos: CGFloat = 0
            var itemCrossAxisLength = direction == .column ? item.width! : item.height!
            
            if let crossAxisLength = containerCrossAxisLength {
                switch stackItem.resolveStackItemAlign(stackAlignItems: alignItems) {
                case .stretch:
                    itemCrossAxisLength = stackItem.adjustContainerWidth(crossAxisLength)
                    crossAxisPos = stackItem.resolveMarginLeft(container: container)
                case .start:
                    crossAxisPos = stackItem.resolveMarginLeft(container: container)
                case .center:
                    crossAxisPos = (crossAxisLength - itemCrossAxisLength) / 2
                case .end:
                    crossAxisPos = crossAxisLength - itemCrossAxisLength
                }
                
                let leftMargin = stackItem.resolveMarginLeft(container: container)
                if crossAxisPos < leftMargin {
                    crossAxisPos = leftMargin
                }
                
                let rightMargin = stackItem.resolveMarginRight(container: container)
                if crossAxisLength - crossAxisPos - itemCrossAxisLength < rightMargin {
                    crossAxisPos = crossAxisLength - rightMargin - itemCrossAxisLength
                }
            }
            
            if direction == .column {
                item.view.frame = CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: item.height!)
            } else {
                item.view.frame = CGRect(x: mainAxisOffset, y: crossAxisPos, width: item.width!, height: itemCrossAxisLength)
            }
            
            mainAxisOffset = direction == .column ? item.view.frame.maxY :  item.view.frame.maxX
            
            maxX = max(item.view.frame.maxX, maxX)
            maxY = max(item.view.frame.maxY, maxY)
        }

        // Apply the last item end margin OR the startEndSpacing to maxX/maxY.
        if let lastItem = container.items.last {
            let lastItemEndMargin = max(lastItem.mainAxisEndMargin ?? 0, startEndSpacing)
            if direction == .column {
                maxY += lastItemEndMargin
            } else {
                maxX += lastItemEndMargin
            }
        }

        return CGSize(width: maxX, height: maxY)
    }
    
    private func measuresItemsAndMargins(container: Container) {
        var prevItemInfo: ItemInfo?
        
        stackItems.forEach{ (stackItem) in
            let view = stackItem.view
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let item = ItemInfo(stackItem, container: container)
            
            //
            // Compute width & height
            var fitWidth: CGFloat?
            var fitHeight: CGFloat?

            if let containerHeight = container.height, item.height ==  nil {
                fitHeight = containerHeight
            }
            
            if let containerWidth = container.width, item.width ==  nil {
                fitWidth = containerWidth
            }
            
            // Measure the view using sizeThatFits(:CGSize)
            if let fitWidth = fitWidth, item.width == nil {
                let adjustedFitWidth = stackItem.adjustContainerWidth(fitWidth)
                let newSize = view.sizeThatFits(CGSize(width: adjustedFitWidth, height: .greatestFiniteMagnitude))
                item.width = newSize.width
                item.height = newSize.height
            } else if let fitHeight = fitHeight, item.height != nil {
                let adjustedFitHeight = stackItem.adjustContainerHeight(fitHeight)
                let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: adjustedFitHeight))
                item.width = newSize.width
                item.height = newSize.height
            }
            
            item.width = applyWidthMinMax(item)
            item.height = applyHeightMinMax(item)
            
            //
            // Compute item main-axis margins
            let prevItemEndMargin = prevItemInfo?.mainAxisEndMargin ?? 0
            let itemStartMargin  = stackItem.resolveStartMargin(container: container)
            item.mainAxisStartMargin = max(prevItemEndMargin, itemStartMargin)
            item.mainAxisEndMargin = stackItem.resolveEndMargin(container: container)
            
            container.items.append(item)
            prevItemInfo = item
        }
    }
}
    
private func applyWidthMinMax(_ item: ItemInfo) -> CGFloat? {
    var result = item.width
    
    // Handle minWidth
    if let minWidth = item.minWidth, minWidth > (result ?? 0) {
        result = minWidth
    }
    
    // Handle maxWidth
    if let maxWidth = item.maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxWidth
    }
    
    return result
}
    
private func applyHeightMinMax(_ item: ItemInfo) -> CGFloat? {
    var result = item.height

    // Handle minHeight
    if let minHeight = item.minHeight, minHeight > (result ?? 0) {
        result = minHeight
    }
    
    // Handle maxHeight
    if let maxHeight = item.maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxHeight
    }
    
    return result
}

#endif
