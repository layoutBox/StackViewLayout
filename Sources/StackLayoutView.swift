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
    internal var direction = SDirection.column
    internal var justifyContent = SJustifyContent.start
    internal var alignItems = SAlignItems.stretch
    internal var alignContent = SAlignContent.start
    
    
    public func addItem(_ view: UIView) {
        super.addSubview(view)
    }
    
    public func insertItem(_ view: UIView, at index: Int) {
        self.insertSubview(view, at: index)
    }
    
    public func insertItem(_ view: UIView, before refView: UIView) {
        super.insertSubview(view, aboveSubview: refView)
    }
    
    public func insertItem(_ view: UIView, after refView: UIView) {
        super.insertSubview(view, belowSubview: refView)
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
}
    
#endif
