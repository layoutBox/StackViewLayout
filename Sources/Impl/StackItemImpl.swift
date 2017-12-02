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

class StackItemImpl: StackItem {
    internal let view: UIView
    
    internal var width: Value?
    internal var minWidth: Value?
    internal var maxWidth: Value?
    internal var height: Value?
    internal var minHeight: Value?
    internal var maxHeight: Value?
    
    internal var marginTop: Value?
    internal var marginLeft: Value?
    internal var marginStart: Value?
    internal var marginBottom: Value?
    internal var marginRight: Value?
    internal var marginEnd: Value?
    
    internal var alignSelf: SAlignSelf?
    
    init(view: UIView) {
        self.view = view
    }
    
    //
    // width, height
    //
    @discardableResult
    func width(_ value: CGFloat) -> StackItem {
        width = Value(value)
        return self
    }
    
    @discardableResult
    func width(_ percent: Percent) -> StackItem {
        width = Value(percent)
        return self
    }
    
    @discardableResult
    func minWidth(_ value: CGFloat) -> StackItem {
        minWidth = Value(value)
        return self
    }
    
    @discardableResult
    func minWidth(_ percent: Percent) -> StackItem {
        minWidth = Value(percent)
        return self
    }
    
    @discardableResult
    func maxWidth(_ value: CGFloat) -> StackItem {
        maxWidth = Value(value)
        return self
    }
    
    @discardableResult
    func maxWidth(_ percent: Percent) -> StackItem {
        maxWidth = Value(percent)
        return self
    }
    
    @discardableResult
    func height(_ value: CGFloat) -> StackItem {
        height = Value(value)
        return self
    }
    
    @discardableResult
    func height(_ percent: Percent) -> StackItem {
        height = Value(percent)
        return self
    }
    
    @discardableResult
    func minHeight(_ value: CGFloat) -> StackItem {
        minWidth = Value(value)
        return self
    }
    
    @discardableResult
    func minHeight(_ percent: Percent) -> StackItem {
        minHeight = Value(percent)
        return self
    }
    
    @discardableResult
    func maxHeight(_ value: CGFloat) -> StackItem {
        maxHeight = Value(value)
        return self
    }
    
    @discardableResult
    func maxHeight(_ percent: Percent) -> StackItem {
        maxHeight = Value(percent)
        return self
    }
    
    /**
     The value specifies view's width and the height in pixels. Values must be non-negative.
     */
    @discardableResult
    func size(_ size: CGSize) -> StackItem {
        width = Value(size.width)
        height = Value(size.height)
        return self
    }
    
    /**
     The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative.
     */
    @discardableResult
    func size(_ sideLength: CGFloat?) -> StackItem{
        width = Value(sideLength)
        height = Value(sideLength)
        return self
    }
    
    @discardableResult
    func size(_ percent: Percent) -> StackItem{
        width = Value(percent)
        height = Value(percent)
        return self
    }
    
    /**
     The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems`
     of the parent. For example, if children are flowing vertically, `alignSelf` will control how the StackItem item
     will align horizontally.
     
     - Parameter value: Default value is .auto
     */
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
    public func marginLeft(_ value: CGFloat) -> StackItem {
        marginLeft = Value(value)
        return self
    }
    
    @discardableResult
    public func marginBottom(_ value: CGFloat) -> StackItem {
        marginBottom = Value(value)
        return self
    }
    
    @discardableResult
    public func marginRight(_ value: CGFloat) -> StackItem {
        marginRight = Value(value)
        return self
    }
    
    @discardableResult
    public func marginStart(_ value: CGFloat) -> StackItem {
        marginStart = Value(value)
        return self
    }
    
    @discardableResult
    public func marginEnd(_ value: CGFloat) -> StackItem {
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
    public func marginVertical(_ value: CGFloat) -> StackItem {
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

#endif
