
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

#if os(iOS) || os(tvOS)
import UIKit

class ItemInfo {
    var view: UIView
    var stackItem: StackItemImpl
    var container: Container
    
    var width: CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?

    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
    var mainAxisLength: CGFloat? {
        get {
            return direction == .column ? height! : width!
        }
        set {
            let value = newValue != nil ? max(0, newValue!) : nil
            if direction == .column {
                height = applyHeightMinMax(value)
            } else {
                width = applyWidthMinMax(value)
            }
        }
    }
    
    var mainAxisMaxLength: CGFloat? {
        assert(width != nil || height != nil)
        return direction == .column ? maxHeight : maxWidth
    }
    
    var mainAxisMinLength: CGFloat? {
        return direction == .column ? minHeight : minWidth
    }
    
    var crossAxisLength: CGFloat {
        get {
            assert(width != nil || height != nil)
            return direction == .column ? width! : height!
        }
        set {
            let value = max(0, newValue)
            if direction == .column {
                width = applyWidthMinMax(value)
            } else {
                height = applyHeightMinMax(value)
            }
        }
    }
    
    var mainAxisStartMargin: CGFloat = 0
    var mainAxisEndMargin: CGFloat = 0
    
    var basis: CGFloat {
        return mainAxisLength ?? 1
    }
    
    private var direction: SDirection {
        return container.direction
    }

    enum MeasureType {
        case sizeThatFits
        case aspectRatio
    }
    var measureType: MeasureType?
    
    init(_ stackItem: StackItemImpl, container: Container) {
        self.stackItem = stackItem
        self.view = stackItem.view
        self.container = container

        self.minWidth = stackItem.minWidth?.resolveWidth(container: container)
        self.maxWidth = stackItem.maxWidth?.resolveWidth(container: container)

        self.minHeight = stackItem.minHeight?.resolveHeight(container: container)
        self.maxHeight = stackItem.maxHeight?.resolveHeight(container: container)

        resetToStackItemProperties()
    }

    func isWidthDefined() -> Bool {
        return stackItem.width != nil || minWidth != nil
    }

    func isHeightDefined() -> Bool {
        return stackItem.height != nil || minHeight != nil
    }

    func isCrossAxisFlexible() -> Bool {
        if direction == .column {
            return stackItem.width == nil
        } else {
            return stackItem.height == nil
        }
    }

    func limitCrossAxisToContainer() -> Bool {
        return isCrossAxisFlexible() && measureType != .aspectRatio
    }

    func resetToStackItemProperties() {
        self.width = stackItem.width?.resolveWidth(container: container)
        if let minWidth = minWidth, let width = width, width < minWidth {
            self.width = minWidth
        }

        self.height = stackItem.height?.resolveHeight(container: container)
        if let minHeight = minHeight, let height = height, height < minHeight {
            self.height = minHeight
        }
    }
    
    func measureItem(initialMeasure: Bool) {
        let stretchedCrossAxisLength = resolveStretchedCrossAxisLength()
        var isMeasured = false

        if initialMeasure && stackItem._aspectRatio != nil {
            // AspectRatio has a high priority, apply it first if the with or the height is defined
            if stackItem.width != nil {
                applyAspectRatioIfNeeded(.adjustHeight)
                measureType = .aspectRatio
                isMeasured = true
            } else if stackItem.height != nil {
                applyAspectRatioIfNeeded(.adjustWidth)
                measureType = .aspectRatio
                isMeasured = true
            } else if let stretchedCrossAxisLength = stretchedCrossAxisLength {
                crossAxisLength = stretchedCrossAxisLength
                applyAspectRatioIfNeeded(.adjustMainAxis)
                measureType = .aspectRatio
                isMeasured = true
            }
        }

        if !isMeasured && (width == nil || height == nil) {
            var applyMargins = initialMeasure
            var fitWidth: CGFloat?
            var fitHeight: CGFloat?

            if let itemWidth = width {
                fitWidth = itemWidth
                applyMargins = false
            } else if let itemHeight = height {
                fitHeight = itemHeight
                applyMargins = false
            } else if let containerInnerWidth = container.innerWidth {
                fitWidth = containerInnerWidth
            } else if let containerHeight = container.innerHeight {
                fitHeight = containerHeight
            }

            // Measure the view using sizeThatFits(:CGSize)
            if let fitWidth = fitWidth, height == nil {
                if fitWidth > 0 {
                    var adjustedFitWidth = applyMargins ? stackItem.applyMargins(toWidth: fitWidth) : fitWidth
                    adjustedFitWidth = adjustWidthToAspectRatioAndContainer(width: adjustedFitWidth)
                    adjustedFitWidth = applyWidthMin(adjustedFitWidth)

                    let newSize = view.sizeThatFits(CGSize(width: adjustedFitWidth, height: .greatestFiniteMagnitude))
                    height = minValueOptional(newSize.height, container.innerHeight)

                    if width == nil {
                        width = min(newSize.width, adjustedFitWidth)
                    }
                } else if height == nil {
                    height = 0
                }
            } else if let fitHeight = fitHeight, width == nil {
                if fitHeight > 0 {
                    var adjustedFitHeight = applyMargins ? stackItem.applyMargins(toHeight: fitHeight) : fitHeight
                    adjustedFitHeight = adjustHeightToAspectRatioAndContainer(height: adjustedFitHeight)
                    adjustedFitHeight = applyHeightMin(adjustedFitHeight)

                    let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: adjustedFitHeight))
                    width = minValueOptional(newSize.width, container.innerWidth)

                    if height == nil {
                        height = min(newSize.height, adjustedFitHeight)
                    }
                } else if width == nil {
                    width = 0
                }
            }

            assert(height != nil && width != nil, "should not occurred")
            
            applySizeMinMax()
            applyAspectRatioIfNeeded(.adjustCrossAxis)

            if let stretchedCrossAxisLength = stretchedCrossAxisLength {
                if stretchedCrossAxisLength > self.crossAxisLength {
                    self.crossAxisLength = stretchedCrossAxisLength
                }
            }
        }

        applySizeMinMax()
    }

    private func resolveStretchedCrossAxisLength() -> CGFloat? {
        if stackItem.resolveStackItemAlign(stackAlignItems: container.alignItems) == .stretch, let containerCrossAxisInnerLength = container.crossAxisInnerLength {
            if isCrossAxisFlexible() {
                var crossAxisLength = stackItem.applyMargins(toCrossAxisLength: containerCrossAxisInnerLength, container: container)
                crossAxisLength = applyMinMax(toCrossAxisLength: crossAxisLength)
                return crossAxisLength
            }
        }

        return nil
    }

    private func measureAterGrowShrink() {
        if stackItem._aspectRatio != nil {
            applyAspectRatioIfNeeded(.adjustCrossAxis)
            applySizeMinMax()
        } else {
            measureItem(initialMeasure: false)
        }
    }

    enum AdjustType {
        case adjustMainAxis
        case adjustCrossAxis
        case adjustWidth
        case adjustHeight
    }

    private func applyAspectRatioIfNeeded(_ adjustType: AdjustType) {
        if let aspectRatio = stackItem._aspectRatio {
            let adjustWidth: Bool

            switch adjustType {
            case .adjustCrossAxis:
                adjustWidth = direction == .column
            case .adjustMainAxis:
                adjustWidth = direction == .row
            case .adjustWidth:
                adjustWidth = true
            case .adjustHeight:
                adjustWidth = false
            }

            applyAspectRatio(aspectRatio, adjustWidth: adjustWidth)

            // Check if the new width/height respect maxWidth/maxHeight and the containe size,
            // if not reapply the aspect ratio
            if let width = width, adjustWidth {
                if let maxWidth = maxWidth, width > maxWidth {
                    self.width = applyWidthMinMax(width)
                    applyAspectRatioIfNeeded(.adjustHeight)
                } else if let availableWidth = container.innerWidth, direction == .column && width > availableWidth {
                    // direction is column, so the width must not be greater than the container's width
                    self.width = availableWidth
                    applyAspectRatioIfNeeded(.adjustHeight)
                }
            } else if let height = height, !adjustWidth {
                if let maxHeight = maxHeight, height > maxHeight {
                    self.height = applyHeightMinMax(height)
                    applyAspectRatioIfNeeded(.adjustWidth)
                } else if let availableHeight = container.innerHeight, direction == .row && height > availableHeight {
                    // direction is row, so the width must not be greater than the container's height
                    self.height = availableHeight
                    applyAspectRatioIfNeeded(.adjustWidth)
                }
            }
        }
    }

    private func hasReachedMaxAspectRatio() -> Bool {
        guard stackItem._aspectRatio != nil else { return false }

        if direction == .column {
            if var availableWidth = container.innerWidth {
                availableWidth = stackItem.applyMargins(toWidth: availableWidth)
                if let width = width, width >= availableWidth {
                    return true
                }
            }
        } else {
            if var availableHeight = container.innerHeight {
                availableHeight = stackItem.applyMargins(toHeight: availableHeight)
                if let height = height, height >= availableHeight {
                    return true
                }
            }
        }

        return false
    }

    private func applyAspectRatio(_ aspectRatio: CGFloat, adjustWidth: Bool) {
        if adjustWidth {
            width = height! * aspectRatio
        } else {
            height = width! / aspectRatio
        }
    }

    private func adjustWidthToAspectRatioAndContainer(width: CGFloat) -> CGFloat {
        guard direction == .row else { return width }
        guard let aspectRatio = stackItem._aspectRatio else { return width }
        guard let availableHeight = container.innerHeight else { return width }

        // aspectRatio and container's height are set => limit the specified width to the maximum width
        // respecting the aspectRatio.
        let maxWidth = availableHeight * aspectRatio
        if width > maxWidth {
            return maxWidth
        } else {
            return width
        }
    }

    private func adjustHeightToAspectRatioAndContainer(height: CGFloat) -> CGFloat {
        guard direction == .column else { return height }
        guard let aspectRatio = stackItem._aspectRatio else { return height }
        guard let availableWidth = container.innerWidth else { return height }

        // aspectRatio and container's width are set => limit the specified height to the maximum height
        // respecting the aspectRatio.
        let maxHeight = availableWidth / aspectRatio
        if height > maxHeight {
            return maxHeight
        } else {
            return height
        }
    }

    func growFactor() -> CGFloat {
        guard let mainAxisLength = mainAxisLength, mainAxisLength != 0 else { return 0 }

        if let mainAxisMaxLength = mainAxisMaxLength, mainAxisLength >= mainAxisMaxLength {
            return 0
        } else if hasReachedMaxAspectRatio() {
            return 0
        } else if let growFactor = stackItem.grow {
            return growFactor
        } else {
            return 0
        }
    }

    func grow(mainAxisLength: CGFloat) {
        resetToStackItemProperties()
        self.mainAxisLength = mainAxisLength
        measureAterGrowShrink()
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

    func shrink(mainAxisLength: CGFloat) {
        resetToStackItemProperties()
        self.mainAxisLength = mainAxisLength
        measureAterGrowShrink()
    }

    private func applySizeMinMax() {
        width = applyWidthMinMax(width)
        height = applyHeightMinMax(height)
    }

    private func applySizeMin() {
        width = applyWidthMin(width)
        height = applyHeightMin(height)
    }

    func applyMinMax(toMainAxisLength mainAxisLength: CGFloat) -> CGFloat {
        if direction == .column {
            return applyHeightMinMax(mainAxisLength)!
        } else {
            return applyWidthMinMax(mainAxisLength)!
        }
    }

    func applyMinMax(toCrossAxisLength crossAxisLength: CGFloat) -> CGFloat {
        if direction == .column {
            return applyWidthMinMax(crossAxisLength)!
        } else {
            return applyHeightMinMax(crossAxisLength)!
        }
    }

    func applyWidthMinMax(_ width: CGFloat?) -> CGFloat? {
        let result = applyWidthMin(width)
        return applyWidthMax(result)
    }

    func applyWidthMin(_ width: CGFloat?) -> CGFloat? {
        guard let width = width else { return minWidth }
        return applyWidthMin(width)
    }

    func applyWidthMin(_ width: CGFloat) -> CGFloat {
        if let minWidth = minWidth, width < minWidth  {
            return minWidth
        } else {
            return width
        }
    }

    func applyWidthMax(_ width: CGFloat?) -> CGFloat? {
        if let maxWidth = maxWidth, maxWidth < (width ?? CGFloat.greatestFiniteMagnitude) {
            return maxWidth
        } else {
            return width
        }
    }

    func applyHeightMinMax(_ height: CGFloat?) -> CGFloat? {
        let result = applyHeightMin(height)
        return applyHeightMax(result)
    }

    func applyHeightMin(_ height: CGFloat?) -> CGFloat? {
        guard let height = height else { return minHeight }
        return applyHeightMin(height)
    }

    func applyHeightMin(_ height: CGFloat) -> CGFloat {
        if let minHeight = minHeight, height < minHeight {
            return minHeight
        } else {
            return height
        }
    }

    func applyHeightMax(_ height: CGFloat?) -> CGFloat? {
        if let maxHeight = maxHeight, maxHeight < (height ?? CGFloat.greatestFiniteMagnitude) {
            return maxHeight
        } else {
            return height
        }
    }
}

#endif
