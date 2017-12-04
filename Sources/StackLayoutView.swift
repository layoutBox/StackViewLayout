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
 
public class StackLayoutView: UIView, StackLayout {
    internal var stackItems: [StackItemImpl] = []
    internal var direction = SDirection.column
    internal var justifyContent = SJustifyContent.start
    internal var alignItems = SAlignItems.stretch
    internal var alignContent = SAlignContent.start
    
    public func addItem(_ view: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        stackItemImpl.parent = self
        stackItems.append(stackItemImpl)
        
        super.addSubview(view)
     }
    
    public func insertItem(_ view: UIView, at index: Int) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: index)
        
        self.insertSubview(view, at: index)
    }
    
    public func insertItem(_ view: UIView, before refView: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The reference view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: itemIndex)
        
        super.insertSubview(view, aboveSubview: refView)
    }
    
    public func insertItem(_ view: UIView, after refView: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The reference view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: itemIndex + 1)

        super.insertSubview(view, belowSubview: refView)
    }
    
    public func removeItem(_ view: UIView) {
        removStackItem(view)
        view.removeFromSuperview()
    }
    
    public override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        removStackItem(subview)
    }
    
    private func removStackItem(_ view: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = nil
        stackItems.remove(at: itemIndex)
    }
    
    @discardableResult
    public func direction(_ value: SDirection) -> StackLayout {
        direction = value
        return self
    }
    
    @discardableResult
    public func justifyContent(_ value: SJustifyContent) -> StackLayout {
        justifyContent = value
        return self
    }
    
    @discardableResult
    public func alignItems(_ value: SAlignItems) -> StackLayout {
        alignItems = value
        return self
    }
    
    @discardableResult
    public func alignContent(_ value: SAlignContent) -> StackLayout {
        alignContent = value
        return self
    }
    
    public func hideItem(_ view: UIView, animate: Bool) {
        updateItemVisibility(view: view, isVisible: false, animate: animate)
    }
    
    public func showItem(_ view: UIView, animate: Bool) {
        updateItemVisibility(view: view, isVisible: true, animate: animate)
    }
    
    internal func updateItemVisibility(view: UIView, isVisible: Bool, animate: Bool) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The view is not part of this StackLayoutView!"); return }
        guard view.isHidden == isVisible else { return }
        let duration = 0.3
        
        if animate {
            if isVisible {
                view.frame.size = CGSize(width: view.frame.width, height: 0)
                view.isHidden = false
                
                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
                    self.forceLayoutNow()
                })
            } else {
                let itemSnapshot = view.snapshotView(afterScreenUpdates: true)!
                itemSnapshot.frame = view.frame
                insertSubview(itemSnapshot, at: itemIndex)
                view.isHidden = true
                
                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
                    itemSnapshot.frame.size = CGSize(width: itemSnapshot.frame.width, height: 0)
                    self.forceLayoutNow()
                }, completion: { (completed) in
                    itemSnapshot.removeFromSuperview()
                })
            }
        } else {
            view.isHidden = !isVisible
            forceLayoutNow()
        }
    }
    
    internal func forceLayoutNow() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
    
#endif
