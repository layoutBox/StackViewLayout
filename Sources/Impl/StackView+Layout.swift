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
    public override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude))
    }

    // TODO: Tests StackView using autolayout
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return super.systemLayoutSizeFitting(targetSize)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container(stackView: self)
        layoutItems(container: container)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container(stackView: self, size: size)
        return layoutItems(container: container)
    }
    
    @discardableResult
    internal func layoutItems(container: Container) -> CGSize {
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength

        guard containerMainAxisLength != nil || containerCrossAxisLength != nil else { return .zero }
        guard (containerMainAxisLength ?? 0) > 0 || (containerCrossAxisLength ?? 0) > 0 else { return .zero }

        // Measures stack's items and add them in the Container.items array.
        measuresItemsAndMargins(container: container)
        
        adjustItemsSizeToContainer(container: container)

        return layoutItemsIn(container: container)
    }
    
    private func measuresItemsAndMargins(container: Container) {
        subviews.forEach { (view) in
            guard let stackItem = view.item as? StackItemImpl else { return }
            guard !view.isHidden else { return }
            guard stackItem.isIncludedInLayout else { return }

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
        guard let mainAxisInnerLength = container.mainAxisInnerLength else { return }

        var previousLength: CGFloat?
        var lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
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
                    lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
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
                    lengthDiff = mainAxisInnerLength - container.mainAxisTotalItemsLength
                }
            } while (shrinkFactorTotal > 0) && (lengthDiff < -delta) && (previousLength != lengthDiff)
        }
    }

    fileprivate func layoutItemsIn(container: Container) -> CGSize {
        var mainAxisOffset = container.mainAxisStartPadding
        let containerMainAxisLength = container.mainAxisLength
        let containerCrossAxisLength = container.crossAxisLength

//        guard containerMainAxisLength != nil || containerCrossAxisLength != nil else { return .zero }
//        guard (containerMainAxisLength ?? 0) > 0 || (containerCrossAxisLength ?? 0) > 0 else { return .zero }

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

            let viewFrame  = direction == .column ? CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: itemMainAxisLength) :
                CGRect(x: mainAxisOffset, y: crossAxisPos, width: itemMainAxisLength, height: itemCrossAxisLength)

            let itemViewRect = Coordinates.adjustRectToDisplayScale(viewFrame)
            Coordinates.setUntransformedViewRect(item.view, toRect: itemViewRect)

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
}

#endif
