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
    
extension StackView {
    // TODO: Tests StackView using autolayout
//    public override var intrinsicContentSize: CGSize {
//        return sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude))
//    }

    // TODO: Tests StackView using autolayout
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return super.systemLayoutSizeFitting(targetSize)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container(stackView: self)
        container.width = bounds.size.width
        container.height = bounds.size.height
        layoutItems(container: container)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container(stackView: self)
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
            var itemMainAxisLength = item.mainAxisLength ?? 0
            var itemCrossAxisLength = item.crossAxisLength
            var crossAxisPos = stackItem.crossAxisStartMargin(container: container)
            let crossAxisEndMargin = stackItem.crossAxisEndMargin(container: container)
            
            if let containerCrossAxisLength = containerCrossAxisLength {
                switch stackItem.resolveStackItemAlign(stackAlignItems: alignItems) {
                case .stretch:
//                    if item.isCrossAxisFlexible {
////                        item.stretchItemCrossAxisLength(to: containerCrossAxisLength)
//                        itemCrossAxisLength = stackItem.applyMargins(toCrossAxisLength: containerCrossAxisLength, container: container)
////                        itemCrossAxisLength = item.applyMinMax(toCrossAxisLength: itemCrossAxisLength)
//
//                        if let aspectRatio = stackItem._aspectRatio {
//                            if direction == .column {
//                                itemMainAxisLength = item.applyMinMax(toMainAxisLength: itemCrossAxisLength / aspectRatio)
//                            } else {
////                                assert(false)
//                                itemMainAxisLength = item.applyMinMax(toMainAxisLength: itemCrossAxisLength * aspectRatio)
//                            }
//                        }
//                    }
                    break
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

            itemCrossAxisLength = item.applyMinMax(toCrossAxisLength: itemCrossAxisLength)
            itemMainAxisLength = item.applyMinMax(toMainAxisLength: itemMainAxisLength)

            let viewFrame  = direction == .column ? CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: itemMainAxisLength) :
                                                    CGRect(x: mainAxisOffset, y: crossAxisPos, width: itemMainAxisLength, height: itemCrossAxisLength)
            
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
        subviews.forEach { (view) in
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let item = ItemInfo(stackItem, container: container)
            
            // Compute width & height
            item.measureItem(initialMeasure: true)
            
            // Compute item main-axis margins.
            item.mainAxisStartMargin = stackItem.mainAxisStartMargin(container: container)
            item.mainAxisEndMargin = stackItem.mainAxisEndMargin(container: container)

            container.items.append(item)
        }
        
        container.updateMainAxisTotalLength()
    }
    
    private func adjustItemsSizeToContainer(container: Container) {
        guard let containerMainAxisLength = container.mainAxisLength else { return }

        var previousLength: CGFloat?
        var lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
        let delta = Coordinates.onePixelLength + 0.001

        if lengthDiff > delta {
            // Grow
            var growFactorTotal: CGFloat = 0
            repeat {
                let itemsGrowFactors = container.itemsGrowFactors()
                growFactorTotal = itemsGrowFactors.reduce(0, +)

                if growFactorTotal > 0 {
                    let factorLength = lengthDiff / growFactorTotal

                    for (index, item) in container.items.enumerated() {
                        guard let itemMainAxisLength = item.mainAxisLength else { continue }
                        let growFactor = itemsGrowFactors[index]
                        
                        if growFactor > 0 {
                            item.grow(mainAxisLength: itemMainAxisLength + growFactor * factorLength)
                        }
                    }
                    
                    container.updateMainAxisTotalLength()

                    previousLength = lengthDiff
                    lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
                }
            } while (growFactorTotal > 0) && (lengthDiff > delta) && (previousLength != lengthDiff)
            
        } else if lengthDiff < -delta {
            // Shrink
            var shrinkFactorTotal: CGFloat = 0

            repeat {
                let itemsShrinkFactors = container.itemsShrinkFactors()
                shrinkFactorTotal = itemsShrinkFactors.reduce(0, +)

                if shrinkFactorTotal > 0 {
                    let factorLength = lengthDiff / shrinkFactorTotal

                    for (index, item) in container.items.enumerated() {
                        guard let itemMainAxisLength = item.mainAxisLength else { continue }
                        let shrinkFactor = itemsShrinkFactors[index]
                        
                        if shrinkFactor > 0 {
                            item.shrink(mainAxisLength: itemMainAxisLength + shrinkFactor * factorLength)
                        }
                    }
                    container.updateMainAxisTotalLength()

                    previousLength = lengthDiff
                    lengthDiff = containerMainAxisLength - container.mainAxisTotalItemsLength
                }
            } while (shrinkFactorTotal > 0) && (lengthDiff < -delta) && (previousLength != lengthDiff)
        }
    }
}

#endif
