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

enum LayoutMode {
    case layouting
    case measuring
}

extension StackView {
    @discardableResult
    internal func layoutItems(container: Container, mode: LayoutMode) -> CGSize {
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength

        guard containerMainAxisLength != nil || containerCrossAxisLength != nil else { return .zero }
        guard (containerMainAxisLength ?? 0) > 0 || (containerCrossAxisLength ?? 0) > 0 else { return .zero }

        // Measures stack's items and add them in the Container.items array.
        measuresItemsAndMargins(container: container, mode: mode)

        // Adjust items to match the container, applying shrink and grow factors.
        adjustItemsSizeToContainer(container: container)

        return layoutItemsIn(container: container, mode: mode)
    }
    
    private func measuresItemsAndMargins(container: Container, mode: LayoutMode) {
        subviews.forEach { (view) in
            guard let stackItem = view.item as? StackItemImpl else { return }
            guard !view.isHidden else { return }
            guard stackItem.isIncludedInLayout else { return }

            let item = ItemInfo(stackItem, container: container, mode: mode)
            
            // Compute width & height
            item.measureItem(initialMeasure: true)
            
            container.items.append(item)
        }
        
        container.updateMainAxisTotalLength()
    }
    
    private func adjustItemsSizeToContainer(container: Container) {
        guard let mainAxisInnerLength = container.mainAxisInnerLength else { return }

        var previousLength: CGFloat?
        var lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
        let delta = Coordinates.onePixelLength + 0.001
        var nbIterations = 0

        if lengthDiff > delta {
            // Grow
            var growFactorTotal: CGFloat = 0

            repeat {
                assert(nbIterations <= 2)

                let growableItems = container.growableItems()
                growFactorTotal = growableItems.reduce(0, { $0 + $1.growFactor() })

                if growFactorTotal > 0 {
                    let factorLength = lengthDiff / growFactorTotal

                    growableItems.forEach { (item) in
                        guard let itemMainAxisLength = item.mainAxisLength else { return }
                        let growFactor = item.growFactor()

                        if growFactor > 0 {
                            item.grow(mainAxisLength: itemMainAxisLength + growFactor * factorLength)
                        }
                    }

                    container.updateMainAxisTotalLength()

                    previousLength = lengthDiff
                    lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
                }

                nbIterations += 1
            } while (growFactorTotal > 0) && (lengthDiff > delta) && (previousLength != lengthDiff)
            
        } else if lengthDiff < -delta {
            // Shrink
            var shrinkFactorTotal: CGFloat = 0

            repeat {
                assert(nbIterations <= 2)

                let shrinkableItems = container.shrinkableItems()
                shrinkFactorTotal = shrinkableItems.reduce(0, { $0 + $1.shrinkFactor() })

                if shrinkFactorTotal > 0 {
                    let factorLength = lengthDiff / shrinkFactorTotal

                    shrinkableItems.forEach { (item) in
                        guard let itemMainAxisLength = item.mainAxisLength else { return }
                        let shrinkFactor = item.shrinkFactor()

                        if shrinkFactor > 0 {
                            item.shrink(mainAxisLength: itemMainAxisLength + shrinkFactor * factorLength)
                        }
                    }

                    container.updateMainAxisTotalLength()

                    previousLength = lengthDiff
                    lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
                }

                nbIterations += 1
            } while (shrinkFactorTotal > 0) && (lengthDiff < -delta) && (previousLength != lengthDiff)
        }
    }

    fileprivate func layoutItemsIn(container: Container, mode: LayoutMode) -> CGSize {
        var mainAxisOffset = container.mainAxisStartPadding
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength

        var startEndSpacing: CGFloat = 0
        var betweenSpacing: CGFloat = 0

        var maxX: CGFloat = 0
        var maxY: CGFloat = 0

        let mainAxisTotalItemsLength = container.mainAxisTotalItemsLength

        if let mainAxisLength = containerMainAxisLength,
            let containerMainAxisInnner = container.mainAxisInnerLength {
            switch justifyContent {
            case .start:
                break // nop
            case .center:
                mainAxisOffset = container.mainAxisStartPadding + (containerMainAxisInnner - mainAxisTotalItemsLength) / 2
            case .end:
                mainAxisOffset = mainAxisLength - mainAxisTotalItemsLength - container.mainAxisEndPadding
            case .spaceBetween:
                betweenSpacing = (containerMainAxisInnner - mainAxisTotalItemsLength) / CGFloat(container.items.count - 1)
            case .spaceAround:
                betweenSpacing = (containerMainAxisInnner - mainAxisTotalItemsLength) / CGFloat(container.items.count)
                startEndSpacing = betweenSpacing / 2
            case .spaceEvenly:
                betweenSpacing = (containerMainAxisInnner - mainAxisTotalItemsLength) / CGFloat(container.items.count + 1)
                startEndSpacing = betweenSpacing
            }
        }

        for (index, item) in container.items.enumerated() {
            let stackItem = item.stackItem
            //
            // Handle main-axis position
            if index == 0 {
                mainAxisOffset += item.mainAxisStartMargin + startEndSpacing
            } else {
                mainAxisOffset += item.mainAxisStartMargin + betweenSpacing
            }

            //
            // Handle cross-axis position
            var itemMainAxisLength = item.mainAxisLength ?? 0
            var itemCrossAxisLength = item.crossAxisLength
            let crossAxisStartMargin = stackItem.crossAxisStartMargin(container: container)
            let crossAxisEndMargin = stackItem.crossAxisEndMargin(container: container)
            var crossAxisPos = container.crossAxisStartPadding + crossAxisStartMargin

            if let containerCrossAxisLength = containerCrossAxisLength,
                let containerCrossAxisInnerLength = container.crossAxisInnerLength {
                switch stackItem.resolveStackItemAlign(stackAlignItems: alignItems) {
                case .center:
                    // Takes margins into account when centering items (compatible with flexbox).
                    crossAxisPos = container.crossAxisStartPadding + crossAxisStartMargin +
                        ((containerCrossAxisInnerLength - itemCrossAxisLength - crossAxisStartMargin - crossAxisEndMargin) / 2)
                case .end:
                    crossAxisPos = containerCrossAxisLength - container.crossAxisEndPadding - crossAxisEndMargin - itemCrossAxisLength
                default:
                    break
                }

                // Check if we must reduce the item's cross axis length to respect its cross axis margins
                if item.limitCrossAxisToContainer() && (crossAxisPos + itemCrossAxisLength + crossAxisEndMargin > containerCrossAxisLength) {
                    itemCrossAxisLength = max(0, containerCrossAxisLength - crossAxisPos - crossAxisEndMargin)
                }
            }

            itemCrossAxisLength = item.applyMinMax(toCrossAxisLength: itemCrossAxisLength)
            itemMainAxisLength = item.applyMinMax(toMainAxisLength: itemMainAxisLength)

            let viewFrame = direction == .column ? CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: itemMainAxisLength) :
                CGRect(x: mainAxisOffset, y: crossAxisPos, width: itemMainAxisLength, height: itemCrossAxisLength)

            let itemViewRect = Coordinates.adjustRectToDisplayScale(viewFrame)

            if mode == .layouting {
                Coordinates.setUntransformedViewRect(item.view, toRect: itemViewRect)
            }

            mainAxisOffset = direction == .column ? itemViewRect.maxY :  itemViewRect.maxX
            mainAxisOffset += item.mainAxisEndMargin

            if direction == .column {
                maxX = max(itemViewRect.maxX + crossAxisEndMargin, maxX)
                maxY = mainAxisOffset
            } else {
                maxX = mainAxisOffset
                maxY = max(itemViewRect.maxY + crossAxisEndMargin, maxY)
            }
        }

        maxX += container.paddingRight
        maxY += container.paddingBottom

        return CGSize(width: maxX, height: maxY)
    }

    func display(type: String, itemInfo: ItemInfo) {
        //container.items.forEach({ (itemInfo) in
        print("   \(type):")
        print("        mainAxisLength:  \(String(describing: itemInfo.mainAxisLength))")
        print("        crossAxisLength: \(itemInfo.crossAxisLength)")
        print("        measureType:     \(String(describing: itemInfo.measureType))")
        print("        width:           \(String(describing: itemInfo.width))")
        print("        height:          \(String(describing: itemInfo.height))")
    }
}

#endif
