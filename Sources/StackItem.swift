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

public protocol StackItem {

//    stack.direction(.column)
//    stack.justifyContent(.spaceBetween)
//    stack.alignItems(.center)
//
//    view.item.alignSelf(.start)

    //
    // MARK: Width, height and size
    //
    /**
     The value specifies the view's width in pixels. The value must be non-negative.
     */
    @discardableResult func width(_ width: CGFloat) -> StackItem
    
    /**
     The value specifies the view's width in percentage of its container width. The value must be non-negative.
     Example: view.flex.width(20%)
     */
    @discardableResult func width(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's minimum width in pixels. The value must be non-negative.
     */
    @discardableResult func minWidth(_ width: CGFloat) -> StackItem
    
    /**
     The value specifies the view's minimum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult func minWidth(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's maximum width in pixels. The value must be non-negative.
     */
    @discardableResult func maxWidth(_ width: CGFloat) -> StackItem
    
    /**
     The value specifies the view's maximum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult func maxWidth(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's height in pixels. The value must be non-negative.
     */
    @discardableResult func height(_ height: CGFloat) -> StackItem
    
    /**
     The value specifies the view's height in percentage of its container height. The value must be non-negative.
     Example: view.flex.height(40%)
     */
    @discardableResult func height(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's minimum height in pixels. The value must be non-negative.
     */
    @discardableResult func minHeight(_ height: CGFloat) -> StackItem
    
    /**
     The value specifies the view's minimum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult func minHeight(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's maximum height in pixels. The value must be non-negative.
     */
    @discardableResult func maxHeight(_ height: CGFloat) -> StackItem
    
    /**
     The value specifies the view's maximum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult func maxHeight(_ percent: SPercent) -> StackItem
    
    
    /**
     The value specifies view's width and the height in pixels. Values must be non-negative.
     */
    @discardableResult
    func size(_ size: CGSize) -> StackItem
    
    /**
     The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative.
     */
    @discardableResult
    func size(_ sideLength: CGFloat?) -> StackItem
    
    @discardableResult
    func size(_ percent: SPercent) -> StackItem
    
    /**
     The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems`
     of the parent. For example, if children are flowing vertically, `alignSelf` will control how the StackItem item
     will align horizontally.
     
     - Parameter value: Default value is .auto
     */
    @discardableResult
    func alignSelf(_ value: SAlignSelf) -> StackItem
    
    //
    // MARK: Margins
    //
    
    /**
     Set the top margin. Top margin specify the offset the top edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginTop(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginTop(_ value: SPercent) -> StackItem
    
    /**
     Set the left margin. Left margin specify the offset the left edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginLeft(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginLeft(_ value: SPercent) -> StackItem
    
    /**
     Set the bottom margin. Bottom margin specify the offset the bottom edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginBottom(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginBottom(_ value: SPercent) -> StackItem
    
    /**
     Set the right margin. Right margin specify the offset the right edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginRight(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginRight(_ value: SPercent) -> StackItem
    
    /**
     Set the start margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, start margin specify the offset the **left** edge of the item should have from from it’s closest sibling (item) or parent (container).
     * IN RTL direction, start margin specify the offset the **right** edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginStart(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginStart(_ value: SPercent) -> StackItem
    
    /**
     Set the end margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, end margin specify the offset the **right** edge of the item should have from from it’s closest sibling (item) or parent (container).
     * IN RTL direction, end margin specify the offset the **left** edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginEnd(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginEnd(_ value: SPercent) -> StackItem
    
    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult
    func marginHorizontal(_ value: CGFloat) -> StackItem
    
    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult
    func marginVertical(_ value: CGFloat) -> StackItem
    
    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    func margin(_ insets: UIEdgeInsets) -> StackItem
    
    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> StackItem
    
    /**
     Set all margins to the specified value.
     */
    @discardableResult
    func margin(_ value: CGFloat) -> StackItem
    
    /**
     Set the individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> StackItem
    
    /**
     Set the individually top, horizontal margins and bottom margin.
     */
    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> StackItem
    
    /**
     Set the individually top, left, bottom and right margins.
     */
    @discardableResult
    func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> StackItem
}
    
    
#endif
