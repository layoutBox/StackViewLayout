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

import UIKit

enum Type {
    case stackView
    case items
    case all

    var text: String {
        switch self {
        case .stackView: return "StackView"
        case .items:     return "Item"
        case .all:       return "StackView and Item"
        }
    }
}

struct Method {
    let type: Type
    let name: String
    let description: String
}

class TableViewExampleViewController: UIViewController {
    fileprivate var mainView: TableViewExampleView {
        return self.view as! TableViewExampleView
    }

    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        
        title = pageType.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = TableViewExampleView()
        mainView.configure(methods: [
            Method(type: .stackView, name: "addItem(_: UIView)", description: "This method adds an item (UIView) to a StackView. The item is added as the last item. Internally this method adds the UIView as a subview. Note that you can also use."),
            Method(type: .stackView, name: "insertItem(_ view: UIView, at index: Int)", description: "This method adds an item (UIView) at the specified index. Note that you can also use \"insertSubview(_ view: UIView, at index: Int)\"."),
            Method(type: .stackView, name: "insertItem(_ view: UIView, before refItem: UIView)", description: "This method adds an item (UIView) before the specified reference item. Note that you can also use \"insertSubview(_ view: UIView, aboveSubview: UIView)\"."),
            Method(type: .stackView, name: "removeItem(_ view: UIView)", description: "Removes the specified item from the StackView. Note that you can also use \"UIView.removeFromSuperview()\" for the same result. The only difference is that \"removeItem()\" will also call \"markDirty()\"."),
            Method(type: .stackView, name: "define(_ closure: (_ stackView: StackView) -> Void)", description: "This method is used to structure your code so that it matches the view structure. The method has a closure parameter with a single parameter called \"stackView\". This parameter is in fact the StackView instance."),
            Method(type: .stackView, name: "direction(_: SDirection)", description: "The \"direction\" property establishes the [main-axis](#axes), thus defining the direction items are placed in the StackView."),
            Method(type: .stackView, name: "justifyContent(_: JustifyContent)", description: "The \"justifyContent\" property defines the alignment along the main-axis. It helps distribute extra free space leftover when either all items have reached their maximum size. For example, for a column StackView, \"justifyContent\" controls how items align vertically."),
            Method(type: .stackView, name: "alignItems(_: AlignItems)", description: "The \"alignItems\" property defines how items are laid out along the cross axis. Similar to \"justifyContent\" but for the cross-axis (perpendicular to the main-axis). For example, for a column StackView, \"alignItems\" controls how they align horizontally."),
            Method(type: .items, name: "alignSelf(_: AlignSelf)", description: "The \"alignSelf\" property controls how an item aligns in the cross direction, overriding the \"alignItems\" of the StackView. For example, for a column StackView, \"alignSelf\" will control how the item will align horizontally. The \"auto\" value means use the stack view \"alignItems\" property. See \"alignItems\" for documentation of the other values."),
            Method(type: .items, name: "grow(_: CGFloat)", description: "The \"grow\" property defines the ability for an item to grow if necessary. It accepts a unitless value that serves as a proportion. It dictates what amount of the available space inside the StackView the item should take up.\n\nA \"grow\" value of 0 (default value) keeps the view's size in the main-axis direction. If you want the view to use the available space set a \"grow\" value > 0.\n\nFor example, if all items have \"grow\" set to 1, every child will grow to an equal size inside the container. If you were to give one of the children a value of 2, that child would take up twice as much space as the others."),
            Method(type: .items, name: "shrink(_: CGFloat)", description: "The \"shrink\" defines how much the item will shrink relative to the rest of items in the StackView **when there isn't enough space on the main-axis**.\n\nA shrink value of 0 keeps the view's size in the main-axis direction. Note that this may cause the view to overflow its flex container.\n\nShrink is about proportions. If an item has a shrink of 3, and the rest have a shrink of 1, the item will shrink 3x as fast as the rest."),
            Method(type: .all, name: "backgroundColor(_ color: UIColor)", description: "Set the StackView or item's UIView background color. "),
            Method(type: .items, name: "alpha(_ value: CGFloat)", description: "Set the StackView or item's \"alpha\" property to adjust the transparency. ")
            ])
    }
}
