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
    @available(*, deprecated, message: "You should call addItem() to add a view to a StackLayoutView")
    override public func addSubview(_ view: UIView) {
        assert(false, "You should call addItem() to add a view to a StackLayoutView")
    }
    
    @available(*, deprecated, message: "You should call insertItem(:before) to insert a view to a StackLayoutView")
    override public func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        assert(false, "You should call insertItem(:before) to insert a view to a StackLayoutView")
    }
    
    @available(*, deprecated, message: "You should call insertItem(after:) to insert a view to a StackLayoutView")
    public override func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        assert(false, "You should call insertItem(after:) to insert a view to a StackLayoutView")
    }
}

#endif
