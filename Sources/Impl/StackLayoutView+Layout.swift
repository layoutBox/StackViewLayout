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
    
    var mainAxisLength: CGFloat? {
        get {
            return direction == .column ? height : width
        }
        set {
            if direction == .column {
                height = newValue
            } else {
                width = newValue
            }
        }
    }
    
    var mainAxisMaxLength: CGFloat? {
        return direction == .column ? maxHeight : maxWidth
    }

    var crossAxisLength: CGFloat {
        assert(width != nil || height != nil)
        return direction == .column ? width! : height!
    }
    
    var mainAxisStartMargin: CGFloat?
    var mainAxisEndMargin: CGFloat?
    
    private let direction: SDirection
    
    init(_ stackItem: StackItemImpl, container: Container) {
        self.stackItem = stackItem
        self.view = stackItem.view
        self.direction = container.direction
        
        if let stackItem = view.item as? StackItemImpl {
            self.width = stackItem.width?.resolveWidth(container: container)
            self.minWidth = stackItem.minWidth?.resolveWidth(container: container)
            self.maxWidth = stackItem.maxWidth?.resolveWidth(container: container)
            
            self.height = stackItem.height?.resolveHeight(container: container)
            self.minHeight = stackItem.minHeight?.resolveHeight(container: container)
            self.maxHeight = stackItem.maxHeight?.resolveHeight(container: container)
        }
    }
    
    func growFactor() -> CGFloat {
        guard let mainAxisLength = mainAxisLength else { return 0 }
        
        if let mainAxisMaxLength = mainAxisMaxLength, mainAxisLength >= mainAxisMaxLength {
            return 0
        } else if let growFactor = stackItem.grow {
            return growFactor
        } else {
            return 0
        }
    }
}
    
extension StackLayoutView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container(direction: direction)
        container.width = frame.size.width
        container.height = frame.size.height
        layoutItems(container: container)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container(direction: direction)
        container.width = size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width
        container.height = size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height
        let size = layoutItems(container: container)
        return size
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
            var crossAxisPos: CGFloat = 0
            var itemCrossAxisLength = item.crossAxisLength
            
            if let containerCrossAxisLength = containerCrossAxisLength {
                switch stackItem.resolveStackItemAlign(stackAlignItems: alignItems) {
                case .stretch:
                    crossAxisPos = stackItem.crossAxisStartMargin(container: container)
                    itemCrossAxisLength = stackItem.applyMargins(toCrossAxisLength: containerCrossAxisLength, container: container)
                case .start:
                    crossAxisPos = stackItem.crossAxisStartMargin(container: container)
                case .center:
                    // Takes margins into account when centering items (compatible with flexbox).
                    let itemCrossAxisForCentering = itemCrossAxisLength -
                                                    stackItem.crossAxisStartMargin(container: container) +
                                                    stackItem.crossAxisEndMargin(container: container)
                    crossAxisPos = (containerCrossAxisLength - itemCrossAxisForCentering) / 2
                case .end:
                    let crossAxisEndMargin = stackItem.crossAxisEndMargin(container: container)
                    crossAxisPos = containerCrossAxisLength - itemCrossAxisLength - crossAxisEndMargin
                }
                
                let crossAxisStartMargin = stackItem.crossAxisStartMargin(container: container)
                if crossAxisPos < crossAxisStartMargin {
                    crossAxisPos = crossAxisStartMargin
                }
            }
            
            let viewFrame  = direction == .column ? CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: item.height!) :
                                                    CGRect(x: mainAxisOffset, y: crossAxisPos, width: item.width!, height: itemCrossAxisLength)
            item.view.frame = viewFrame.adjustToDisplayScale()
            
            mainAxisOffset = direction == .column ? item.view.frame.maxY :  item.view.frame.maxX
            mainAxisOffset += (item.mainAxisEndMargin ?? 0)
            
            if direction == .column {
                maxX = max(item.view.frame.maxX, maxX)
                maxY = mainAxisOffset
            } else {
                maxX = mainAxisOffset
                maxY = max(item.view.frame.maxY, maxY)
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
            
            //
            // Compute width & height
            var fitWidth: CGFloat?
            var fitHeight: CGFloat?

            if direction == .column {
                if let itemWidth = item.width {
                    fitWidth = itemWidth
                } else if let itemHeight = item.height {
                    fitHeight = itemHeight
                } else if let containerWidth = container.width {
                    fitWidth = containerWidth
                } else if let containerHeight = container.height {
                    fitHeight = containerHeight
                }
            } else {
                if let itemHeight = item.height {
                    fitHeight = itemHeight
                } else if let itemWidth = item.width {
                    fitWidth = itemWidth
                } else if let containerHeight = container.height {
                    fitHeight = containerHeight
                } else if let containerWidth = container.width {
                    fitWidth = containerWidth
                } 
            }

            // Measure the view using sizeThatFits(:CGSize)
            if let fitWidth = fitWidth, item.height == nil {
                let adjustedFitWidth = stackItem.applyMargins(toWidth: fitWidth)
                let newSize = view.sizeThatFits(CGSize(width: adjustedFitWidth, height: .greatestFiniteMagnitude))
                item.height = minValue(newSize.height, container.height)

                if item.width == nil {
                    item.width = min(newSize.width, adjustedFitWidth)
                }
            } else if let fitHeight = fitHeight, item.width == nil {
                let adjustedFitHeight = stackItem.applyMargins(toHeight: fitHeight)
                let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: adjustedFitHeight))
                item.width = minValue(newSize.width, container.width)
                
                if item.height == nil {
                    item.height = min(newSize.height, adjustedFitHeight)
                }
            }
            assert(item.height != nil && item.width != nil, "should not occurred")
            
            item.width = applyWidthMinMax(item)
            item.height = applyHeightMinMax(item)
            
            //
            // Compute item main-axis margins.
            item.mainAxisStartMargin = stackItem.mainAxisStartMargin(container: container)
            item.mainAxisEndMargin = stackItem.mainAxisEndMargin(container: container)
            
            container.items.append(item)
        }
        
        container.updateMainAxisTotalLength()
    }
    
    private func adjustItemsSizeToContainer(container: Container) {
        guard let containerMainAxisLength = container.mainAxisLength else { return }
        
        if container.mainAxisTotalItemsLength < containerMainAxisLength {
            // Grow
            var growFactorTotal: CGFloat = 0
            var lenghtToDistribute = containerMainAxisLength - container.mainAxisTotalItemsLength
            
            repeat {
                growFactorTotal = container.items.reduce(0, { (result, itemInfo) -> CGFloat in
                    return result + itemInfo.growFactor()
                })
                
                print("growFactorTotal: \(growFactorTotal)")
                if growFactorTotal > 0 {
                    let factorLength = lenghtToDistribute / growFactorTotal
                    
                    for item in container.items {
                        guard let itemMainAxisLength = item.mainAxisLength else { continue }
                        let growFactor = item.growFactor()
                        if growFactor > 0 {
                            let addLength = growFactor * factorLength
                            item.mainAxisLength = itemMainAxisLength + addLength
                        }
                    }
                }
                
                container.updateMainAxisTotalLength()
                
            } while growFactorTotal > 0 && container.mainAxisTotalItemsLength < containerMainAxisLength
            
        } else if container.mainAxisTotalItemsLength > containerMainAxisLength {
            // Shrink
//            var shrinkFactorTotal = container.items.reduce(0, { (result, itemInfo) -> CGFloat in
//                return result + (itemInfo.stackItem.shrink ?? 0)
//            })
//            print("shrinkFactorTotal: \(shrinkFactorTotal)")
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
    
private func minValue(_ value1: CGFloat, _ value2: CGFloat?) -> CGFloat {
    return min(value1, value2 ?? .greatestFiniteMagnitude)
}

#endif
