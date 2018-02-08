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

class StackItemImpl: NSObject, StackItem {
    internal let view: UIView

    internal var width: Value?
    internal var minWidth: Value?
    internal var maxWidth: Value?

    internal var height: Value?
    internal var minHeight: Value?
    internal var maxHeight: Value?

    internal var _aspectRatio: CGFloat?

    internal var marginTop: Value?
    internal var marginLeft: Value?
    internal var marginStart: Value?
    internal var marginBottom: Value?
    internal var marginRight: Value?
    internal var marginEnd: Value?
    
    internal var grow: CGFloat?
    internal var shrink: CGFloat?
    
    var alignSelf: SAlignSelf?
    var isHidden = false
    
    init(view: UIView) {
        self.view = view
    }
    
    //
    // MARK: grow / shrink
    //
    @discardableResult
    public func grow(_ value: CGFloat) -> StackItem {
        grow = value
        return self
    }
    
    @discardableResult
    public func shrink(_ value: CGFloat) -> StackItem {
        shrink = value
        return self
    }
    
    @discardableResult
    public func markDirty() -> StackItem {
        view.setNeedsLayout()
        
        if let stackView = view.superview as? StackView {
            stackView.markDirty()
        }
        return self
    }


    //
    // width, height
    //
    @discardableResult
    func width(_ value: CGFloat?) -> StackItem {
        width = Value(value)
        return self
    }
    
    @discardableResult
    func width(_ percent: SPercent) -> StackItem {
        width = Value(percent)
        return self
    }
    
    @discardableResult
    func minWidth(_ value: CGFloat?) -> StackItem {
        minWidth = Value(value)
        return self
    }
    
    @discardableResult
    func minWidth(_ percent: SPercent) -> StackItem {
        minWidth = Value(percent)
        return self
    }
    
    @discardableResult
    func maxWidth(_ value: CGFloat?) -> StackItem {
        maxWidth = Value(value)
        return self
    }
    
    @discardableResult
    func maxWidth(_ percent: SPercent) -> StackItem {
        maxWidth = Value(percent)
        return self
    }
    
    @discardableResult
    func height(_ value: CGFloat?) -> StackItem {
        height = Value(value)
        return self
    }
    
    @discardableResult
    func height(_ percent: SPercent) -> StackItem {
        height = Value(percent)
        return self
    }
    
    @discardableResult
    func minHeight(_ value: CGFloat?) -> StackItem {
        minHeight = Value(value)
        return self
    }
    
    @discardableResult
    func minHeight(_ percent: SPercent) -> StackItem {
        minHeight = Value(percent)
        return self
    }
    
    @discardableResult
    func maxHeight(_ value: CGFloat?) -> StackItem {
        maxHeight = Value(value)
        return self
    }
    
    @discardableResult
    func maxHeight(_ percent: SPercent) -> StackItem {
        maxHeight = Value(percent)
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> StackItem {
        width = Value(size.width)
        height = Value(size.height)
        return self
    }
    
    @discardableResult
    func size(_ sideLength: CGFloat?) -> StackItem{
        width = Value(sideLength)
        height = Value(sideLength)
        return self
    }
    
    @discardableResult
    func size(_ percent: SPercent) -> StackItem{
        width = Value(percent)
        height = Value(percent)
        return self
    }

    @discardableResult
    public func aspectRatio(_ value: CGFloat?) -> StackItem {
        _aspectRatio = value
        return self
    }

    @discardableResult
    func aspectRatio(of view: UIView) -> StackItem {
        _aspectRatio = view.bounds.width / view.bounds.height
        return self
    }

    @discardableResult
    func aspectRatio() -> StackItem {
        if let imageView = view as? UIImageView {
            if let imageSize = imageView.image?.size {
                _aspectRatio = imageSize.width / imageSize.height
            } else {
//                warnWontBeApplied("the layouted UIImageView's image hasn't been set", context)
            }
        } else {
//            warnWontBeApplied("the layouted must be an UIImageView() to use the aspectRatio() method without parameter.", context)
        }

        return self
    }
    
    @discardableResult
    public func alignSelf(_ value: SAlignSelf) -> StackItem {
        alignSelf = value
        return self
    }
    
    //
    // MARK: Margins
    //
    @discardableResult
    public func marginTop(_ value: CGFloat) -> StackItem {
        marginTop = Value(value)
        return self
    }
    
    @discardableResult
    public func marginTop(_ value: SPercent) -> StackItem {
        marginTop = Value(value)
        return self
    }
    
    @discardableResult
    public func marginLeft(_ value: CGFloat) -> StackItem {
        marginLeft = Value(value)
        return self
    }
    
    @discardableResult
    public func marginLeft(_ value: SPercent) -> StackItem {
        marginLeft = Value(value)
        return self
    }
    
    @discardableResult
    public func marginBottom(_ value: CGFloat) -> StackItem {
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult
    public func marginBottom(_ value: SPercent) -> StackItem {
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult
    public func marginRight(_ value: CGFloat) -> StackItem {
        marginRight = Value(value)
        return self
    }
    
    @discardableResult
    public func marginRight(_ value: SPercent) -> StackItem {
        marginRight = Value(value)
        return self
    }
    
    @discardableResult
    public func marginStart(_ value: CGFloat) -> StackItem {
        marginStart = Value(value)
        return self
    }
    
    @discardableResult
    public func marginStart(_ value: SPercent) -> StackItem {
        marginStart = Value(value)
        return self
    }
    
    @discardableResult
    public func marginEnd(_ value: CGFloat) -> StackItem {
        marginEnd = Value(value)
        return self
    }
    
    @discardableResult
    public func marginEnd(_ value: SPercent) -> StackItem {
        marginEnd = Value(value)
        return self
    }
    
    @discardableResult
    public func marginHorizontal(_ value: CGFloat) -> StackItem {
        marginLeft = Value(value)
        marginRight = Value(value)
        return self
    }
    
    @discardableResult
    func marginHorizontal(_ value: SPercent) -> StackItem {
        marginLeft = Value(value)
        marginRight = Value(value)
        return self
    }
    
    @discardableResult
    public func marginVertical(_ value: CGFloat) -> StackItem {
        marginTop = Value(value)
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult
    func marginVertical(_ value: SPercent) -> StackItem {
        marginTop = Value(value)
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult
    public func margin(_ insets: UIEdgeInsets) -> StackItem {
        marginTop = Value(insets.top)
        marginLeft = Value(insets.left)
        marginBottom = Value(insets.bottom)
        marginRight = Value(insets.right)
        return self
    }
    
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> StackItem {
        marginTop = Value(directionalInsets.top)
        marginStart = Value(directionalInsets.leading)
        marginBottom = Value(directionalInsets.bottom)
        marginEnd = Value(directionalInsets.trailing)
        return self
    }
    
    @discardableResult
    public func margin(_ value: CGFloat) -> StackItem {
        return margin(value, value, value, value)
    }
    
    @discardableResult
    func margin(_ value: SPercent) -> StackItem {
        marginTop = Value(value)
        marginLeft = Value(value)
        marginRight = Value(value)
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> StackItem {
        return margin(vertical, horizontal, vertical, horizontal)
    }
    
    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> StackItem {
        marginTop = Value(top)
        marginLeft = Value(horizontal)
        marginRight = Value(horizontal)
        marginBottom = Value(bottom)
        return self
    }
    
    @discardableResult
    public func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> StackItem {
        marginTop = Value(top)
        marginLeft = Value(left)
        marginBottom = Value(bottom)
        marginRight = Value(right)
        return self
    }
}
    
extension StackItemImpl {
    func applyMargins(toWidth width: CGFloat) -> CGFloat {
        var result = width
        
        if let marginLeftPixels = marginLeft?.resolve(usingContainerDimension: width) {
            result -= marginLeftPixels
        }
        
        if let marginRightPixels = marginRight?.resolve(usingContainerDimension: width) {
            result -= marginRightPixels
        }
        
        if let marginStartPixels = marginStart?.resolve(usingContainerDimension: width) {
            result -= marginStartPixels
        }
        
        if let marginEndPixels = marginEnd?.resolve(usingContainerDimension: width) {
            result -= marginEndPixels
        }
        
        return result
    }
    
    func applyMargins(toHeight height: CGFloat) -> CGFloat {
        var result = height
        
        if let marginTopPixels = marginTop?.resolve(usingContainerDimension: height) {
            result -= marginTopPixels
        }
        
        if let marginBottomPixels = marginBottom?.resolve(usingContainerDimension: height) {
            result -= marginBottomPixels
        }
        
        return result
    }
    
    func resolveStackItemAlign(stackAlignItems: SAlignItems) -> SAlignItems {
        var align = stackAlignItems
        
        if let alignSelf = alignSelf {
            switch alignSelf {
            case .auto:    align = stackAlignItems
            case .stretch: align = .stretch
            case .start:   align = .start
            case .center:  align = .center
            case .end:     align = .end
            }
        } 
        
        return align
    }
    
    func applyMargins(toCrossAxisLength length: CGFloat, container: Container) -> CGFloat {
        var itemCrossAxisLength: CGFloat = 0
        
        switch container.direction {
        case .column: itemCrossAxisLength = applyMargins(toWidth: length)
        case .row:    itemCrossAxisLength = applyMargins(toHeight: length)
        }
        
        if let containerCrossAxisInnerLength = container.crossAxisInnerLength {
            let crossAxisStartMargin = self.crossAxisStartMargin(container: container)
            let crossAxisEndMargin = self.crossAxisEndMargin(container: container)
            if crossAxisStartMargin + itemCrossAxisLength + crossAxisEndMargin > containerCrossAxisInnerLength {
                // The computed itemCrossAxisLength is too long, we must respect margins!
                itemCrossAxisLength = containerCrossAxisInnerLength - crossAxisStartMargin - crossAxisEndMargin
            }
        }
        
        return itemCrossAxisLength
    }
    
    func mainAxisStartMargin(container: Container) -> CGFloat {
        if container.direction == .column {
            return resolveMarginTop(container: container)
        } else {
            return resolveMarginLeft(container: container)
        }
    }
    
    func mainAxisEndMargin(container: Container) -> CGFloat {
        if container.direction == .column {
            return resolveMarginBottom(container: container)
        } else {
            return resolveMarginRight(container: container)
        }
    }
    
    func crossAxisStartMargin(container: Container) -> CGFloat {
        if container.direction == .column {
            return resolveMarginLeft(container: container)
        } else {
            return resolveMarginTop(container: container)
        }
    }
    
    func crossAxisEndMargin(container: Container) -> CGFloat {
        if container.direction == .column {
            return resolveMarginRight(container: container)
        } else {
            return resolveMarginBottom(container: container)
        }
    }
    
    func resolveMarginTop(container: Container) -> CGFloat {
        if let marginTopPixels = marginTop?.resolve(usingContainerDimension: container.height) {
            return marginTopPixels
        } else {
            return 0
        }
    }
    
    func resolveMarginBottom(container: Container) -> CGFloat {
        if let marginBottomPixels = marginBottom?.resolve(usingContainerDimension: container.height) {
            return marginBottomPixels
        } else {
            return 0
        }
    }
    
    func resolveMarginLeft(container: Container) -> CGFloat {
        if let marginLeftPixels = marginLeft?.resolve(usingContainerDimension: container.width) {
            return marginLeftPixels
        } else if let marginStartPixels = marginStart?.resolve(usingContainerDimension: container.width) {
            return marginStartPixels
        } else {
            return 0
        }
    }
    
    func resolveMarginRight(container: Container) -> CGFloat {
        if let marginRightPixels = marginRight?.resolve(usingContainerDimension: container.width) {
            return marginRightPixels
        } else if let marginEndPixels = marginEnd?.resolve(usingContainerDimension: container.width) {
            return marginEndPixels
        } else {
            return 0
        }
    }
}

#endif
