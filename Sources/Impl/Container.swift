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

#if os(iOS) || os(tvOS)
import UIKit

class Container {
    unowned fileprivate let stackView: StackView
    var width: CGFloat?
    var height: CGFloat?
    var innerWidth: CGFloat?
    var innerHeight: CGFloat?
    var items: [ItemInfo] = []

    var direction: SDirection {
        return stackView.direction
    }

    var alignItems: SAlignItems {
        return stackView.alignItems
    }

    var mainAxisLength: CGFloat? {
        return direction == .column ? height : width
    }

    var mainAxisInnerLength: CGFloat? {
        return direction == .column ? innerHeight : innerWidth
    }

    var crossAxisLength: CGFloat? {
        return direction == .column ? width : height
    }

    var crossAxisInnerLength: CGFloat? {
        return direction == .column ? innerWidth : innerHeight
    }

    var paddingLeft: CGFloat = 0
    var paddingRight: CGFloat = 0
    var paddingTop: CGFloat = 0
    var paddingBottom: CGFloat = 0

    var mainAxisStartPadding: CGFloat {
        return direction == .column ? paddingTop : paddingLeft
    }

    var mainAxisEndPadding: CGFloat {
        return direction == .column ? paddingBottom : paddingRight
    }

    var crossAxisStartPadding: CGFloat {
        return direction == .column ? paddingLeft : paddingTop
    }
    
    var crossAxisEndPadding: CGFloat {
        return direction == .column ? paddingRight : paddingBottom
    }
    
    var mainAxisTotalItemsLength: CGFloat = 0
    
    init(_ stackView: StackView) {
        self.stackView = stackView
    }
    
    convenience init(stackView: StackView) {
        self.init(stackView)
        
        let rect = Coordinates.getUntransformedViewRect(stackView)
        width = rect.width
        height = rect.height
        
        initializeInnerSize()
    }

    convenience init(stackView: StackView, size: CGSize) {
        self.init(stackView)
        width = (size.width == .greatestFiniteMagnitude || size.width == .nan) ? nil : size.width
        height = (size.height == .greatestFiniteMagnitude || size.height == .nan) ? nil : size.height

        initializeInnerSize()
    }

    fileprivate func initializeInnerSize() {
        if let paddingLeft = stackView._paddingLeft?.resolveWidth(container: self) {
            self.paddingLeft = paddingLeft
        }

        if let paddingRight = stackView._paddingRight?.resolveWidth(container: self) {
            self.paddingRight = paddingRight
        }

        if let paddingTop = stackView._paddingTop?.resolveWidth(container: self) {
            self.paddingTop = paddingTop
        }

        if let paddingBottom = stackView._paddingBottom?.resolveWidth(container: self) {
            self.paddingBottom = paddingBottom
        }

        if let width = width {
            innerWidth = width - paddingLeft - paddingRight
        }

        if let height = height {
            innerHeight = height - paddingTop - paddingBottom
        }
    }

    func updateMainAxisTotalLength() {
        mainAxisTotalItemsLength = 0
        
        items.forEach({ (item) in
            mainAxisTotalItemsLength += item.mainAxisStartMargin
            
            if direction == .column {
                mainAxisTotalItemsLength += (item.height != nil ? item.height! : 0)
            } else {
                mainAxisTotalItemsLength += (item.width != nil ? item.width! : 0)
            }
            
            mainAxisTotalItemsLength += item.mainAxisEndMargin
        })
    }
    
    func growableItems() -> [ItemInfo] {
        return items.filter({ $0.growFactor() > 0 })
    }
    
    func shrinkableItems() -> [ItemInfo] {
        return items.filter({ $0.shrinkFactor() > 0 })
    }
}

#endif
