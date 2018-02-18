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
 
public class StackView: UIView {
    internal var direction = SDirection.column
    internal var justifyContent = SJustifyContent.start
    internal var alignItems = SAlignItems.stretch

    internal var _paddingTop: Value?
    internal var _paddingLeft: Value?
    internal var _paddingStart: Value?
    internal var _paddingBottom: Value?
    internal var _paddingRight: Value?
    internal var _paddingEnd: Value?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public static override var requiresConstraintBasedLayout: Bool {
        return false
    }
    
    /**
     This method is used to structure your code so that it matches the stack view structure. The method has a closure parameter with a
     single parameter called `stackView`. This parameter is in fact the StackView instance, it can be used to adds items
     to the StackView.
     
     - Parameter closure:
     */
    @discardableResult
    public func define(_ closure: (_ stackView: StackView) -> Void) -> StackView {
        closure(self)
        return self
    }

    @discardableResult
    public func addStackView() -> StackView {
        let stackView = StackView()
        addItem(stackView)

        return stackView
    }

    @discardableResult
    public func addItem(_ view: UIView) -> StackItem {
        addSubview(view)
        markDirty()
        
        return view.item
     }
    
    @discardableResult
    public func insertItem(_ view: UIView, at index: Int) -> StackItem {
        insertSubview(view, at: index)
        markDirty()
        
        return view.item
    }
    
    @discardableResult
    public func insertItem(_ view: UIView, before refItem: UIView) -> StackItem? {
        insertSubview(view, aboveSubview: refItem)
        markDirty()
        
        return view.item
    }
    
    @discardableResult
    public func insertItem(_ view: UIView, after refItem: UIView) -> StackItem? {
        insertSubview(view, belowSubview: refItem)
        markDirty()
        
        return view.item
    }
    
    public func removeItem(_ view: UIView) {
        view.removeFromSuperview()
        markDirty()
    }
    
    /**
     The `direction` property establishes the main-axis, thus defining the direction items are placed in the StackView.
     
     The `direction` property specifies how items are laid out in the StackView, by setting the direction of the StackView’s main axis. They can be laid out in two main directions, like columns vertically or like rows horizontally.
     
     - Parameter value: Default value is .column
     */
    @discardableResult
    public func direction(_ value: SDirection) -> StackView {
        direction = value
        markDirty()
        return self
    }
    
    public func getDirection() -> SDirection {
        return direction
    }
    
    /**
     The `justifyContent` property defines the alignment along the main-axis of the StackView.
     It helps distribute extra free space leftover when either all the items on a line have reached their maximum
     size. For example, if items are flowing vertically, `justifyContent` controls how they align vertically.

     - Parameter value: Default value is .start
     */
    @discardableResult
    public func justifyContent(_ value: SJustifyContent) -> StackView {
        justifyContent = value
        markDirty()
        return self
    }
    
    public func getJustifyContent() -> SJustifyContent {
        return justifyContent
    }
    
    /**
     The `alignItems` property defines how items are laid out along the cross-axis in the StackView.
     Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, if
     items are flowing vertically, `alignItems` controls how they align horizontally.
     
     - Parameter value: Default value is .stretch
     */
    @discardableResult
    public func alignItems(_ value: SAlignItems) -> StackView {
        alignItems = value
        markDirty()
        return self
    }
    
    public func getAlignItems() -> SAlignItems {
        return alignItems
    }

    //
    // MARK: Padding
    //

    /**
     Set the top padding. Top padding specify the **offset children should have** from the container's top edge.
     */
    @discardableResult
    public func paddingTop(_ value: CGFloat) -> StackView {
        _paddingTop = Value(value)
        return self
    }

    /**
     Set the left padding. Left padding specify the **offset children should have** from the container's left edge.
     */
    @discardableResult
    public func paddingLeft(_ value: CGFloat) -> StackView {
        _paddingLeft = Value(value)
        return self
    }

    /**
     Set the bottom padding. Bottom padding specify the **offset children should have** from the container's bottom edge.
     */
    @discardableResult
    public func paddingBottom(_ value: CGFloat) -> StackView {
        _paddingBottom = Value(value)
        return self
    }

    /**
     Set the top padding. Top padding specify the **offset children should have** from the container's top edge.
     */
    @discardableResult
    public func paddingRight(_ value: CGFloat) -> StackView {
        _paddingRight = Value(value)
        return self
    }

    /**
     Set the start padding.

     Depends on the item `LayoutDirection`:
     * In LTR direction, start padding specify the **offset children should have** from the container's left edge.
     * IN RTL direction, start padding specify the **offset children should have** from the container's right edge.
     */
    @discardableResult
    public func paddingStart(_ value: CGFloat) -> StackView {
        _paddingStart = Value(value)
        return self
    }

    /**
     Set the end padding.

     Depends on the item `LayoutDirection`:
     * In LTR direction, end padding specify the **offset children should have** from the container's right edge.
     * IN RTL direction, end padding specify the **offset children should have** from the container's left edge.
     */
    @discardableResult
    public func paddingEnd(_ value: CGFloat) -> StackView {
        _paddingEnd = Value(value)
        return self
    }

    /**
     Set the left, right, start and end paddings to the specified value.
     */
    @discardableResult
    public func paddingHorizontal(_ value: CGFloat) -> StackView {
        _paddingLeft = Value(value)
        _paddingRight = Value(value)
        return self
    }

    /**
     Set the top and bottom paddings to the specified value.
     */
    @discardableResult
    public func paddingVertical(_ value: CGFloat) -> StackView {
        _paddingTop = Value(value)
        _paddingBottom = Value(value)
        return self
    }

    /**
     Set paddings using UIEdgeInsets.
     This method is particularly useful to set all paddings using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    public func padding(_ insets: UIEdgeInsets) -> StackView {
        _paddingTop = Value(insets.top)
        _paddingLeft = Value(insets.left)
        _paddingBottom = Value(insets.bottom)
        _paddingRight = Value(insets.right)
        return self
    }

    /**
     Set paddings using NSDirectionalEdgeInsets.
     This method is particularly to set all paddings using iOS 11 `UIView.directionalLayoutMargins`.

     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func padding(dirInsets: NSDirectionalEdgeInsets) -> StackView {
        _paddingTop = Value(dirInsets.top)
        _paddingStart = Value(dirInsets.leading)
        _paddingBottom = Value(dirInsets.bottom)
        _paddingEnd = Value(dirInsets.trailing)
        return self
    }

    /**
     Set all paddings to the specified value.
     */
    @discardableResult
    public func padding(all value: CGFloat) -> StackView {
        _paddingTop = Value(value)
        _paddingBottom = _paddingTop
        _paddingLeft = _paddingTop
        _paddingRight = _paddingTop
        return self
    }

    /**
     Set the individually vertical paddings (top, bottom) and horizontal paddings (left, right, start, end).
     */
    @discardableResult func padding(_ vertical: CGFloat, _ horizontal: CGFloat) -> StackView {
        paddingVertical(vertical)
        paddingHorizontal(horizontal)
        return self
    }

    /**
     Set the individually top, horizontal paddings and bottom padding.
     */
    @discardableResult func padding(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> StackView {
        _paddingTop = Value(top)
        paddingHorizontal(horizontal)
        _paddingBottom = Value(bottom)
        return self
    }

    /**
     Set the individually top, left, bottom and right paddings.
     */
    @discardableResult
    public func padding(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> StackView {
        _paddingTop = Value(top)
        _paddingLeft = Value(left)
        _paddingBottom = Value(bottom)
        _paddingRight = Value(right)
        return self
    }
    
    //
    // Layout view
    //

    /**
     StackView's items are layouted only when a item's property is changed and when the StackView size change.
     In the event that you want to force StackView to do a layout of its items, you can mark it as dirty
     using `markDirty()`.
     */
    public func markDirty() {
        setNeedsLayout()

        // All StackViews ancestors dirty.
        if let stackView = superview as? StackView {
            stackView.markDirty()
        }
    }
    
    /**
     The method layout the StackView's items using the current frame's size
     or by automatically adjusting the width or the height to match
     its items.
     
     - Parameter mode: specify the layout mode (LayoutMode).
     */
    public func layout(mode: SLayoutMode = .fitContainer) {
        let container = Container(stackView: self)
        let viewRect = Coordinates.getUntransformedViewRect(self)
        
        switch mode {
        case .fitContainer:
            container.width = viewRect.width
            container.height = viewRect.height
        case .adjustWidth:
            container.width = nil
            container.height = viewRect.height
        case .adjustHeight:
            container.width = viewRect.width
            container.height = nil
        }
        
        layoutItems(container: container)
    }

    //
    // MARK: UIView Visual properties
    //

    /**
     Set the item/view background color.
     */
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> StackView {
        backgroundColor = color
        return self
    }

    /**
     Set the item/view transparency `alpha`.
     */
    @discardableResult
    public func alpha(_ value: CGFloat) -> StackView {
        alpha = value
        return self
    }
    
    //
    // Show/hide items
    //
    public func hideItem(_ view: UIView, animate: Bool) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        stackItemImpl.isHidden = true
//        updateItemVisibility(view: view, isVisible: false, animate: animate)
    }
    
    public func showItem(_ view: UIView, animate: Bool) {
//        updateItemVisibility(view: view, isVisible: true, animate: animate)
    }
    
//    internal func updateItemVisibility(view: UIView, isVisible: Bool, animate: Bool) {
//        guard let stackItemImpl = view.item as? StackItemImpl else { return }
//        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The view is not part of this stackView!"); return }
//        let duration = 0.3
//
//        if animate {
//            if isVisible {
//                view.bounds.size = direction == .column ? CGSize(width: view.frame.width, height: 0) : CGSize(width: 0, height: view.frame.height)
//                view.isHidden = false
//
//                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
//                    self.forceLayoutNow()
//                })
//            } else {
//                let itemSnapshot = view.snapshotView(afterScreenUpdates: true)!
//                itemSnapshot.frame = view.frame
//                insertSubview(itemSnapshot, at: itemIndex)
//                view.isHidden = true
//
//                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
//                    itemSnapshot.frame.size = self.direction == .column ? CGSize(width: itemSnapshot.frame.width, height: 0) : CGSize(width: 0, height: itemSnapshot.frame.height)
//                    self.forceLayoutNow()
//                }, completion: { (completed) in
//                    itemSnapshot.removeFromSuperview()
//                })
//            }
//        } else {
//            view.isHidden = !isVisible
//            forceLayoutNow()
//        }
//    }
    
//    internal func forceLayoutNow() {
//        setNeedsLayout()
//        layoutIfNeeded()
//    }
}
    
#endif
