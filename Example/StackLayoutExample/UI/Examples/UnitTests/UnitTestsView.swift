// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import UIKit
import PinLayout

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
import PinLayout
import StackViewLayout
import FlexLayout

class UnitTestsView: BaseView {
    fileprivate let buttonsStackView = StackView()
    fileprivate let toggleDirectionButton = UIButton(type: .custom)
    fileprivate let toggleJustifyButton = UIButton(type: .custom)
    fileprivate let toggleVisibilityButton = UIButton(type: .custom)
    fileprivate let removeButton = UIButton(type: .custom)
    fileprivate let insertButton = UIButton(type: .custom)

    fileprivate let rootFlexContainer = UIView()

    var stackView: StackView!

    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    let view1 = BasicView(text: "StackLayout", color: UIColor.red)

    override init() {
        super.init()

        rootFlexContainer.layer.borderColor = UIColor.green.cgColor
        rootFlexContainer.layer.borderWidth = 1

        stackView = StackView()
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        addSubview(stackView)

        toggleDirectionButton.backgroundColor = .gray
        toggleDirectionButton.setTitle("Dir", for: .normal)
        toggleDirectionButton.addTarget(self, action: #selector(didTapToggleDirection), for: .touchUpInside)
        buttonsStackView.addItem(toggleDirectionButton)

        toggleJustifyButton.backgroundColor = .gray
        toggleJustifyButton.setTitle("Just", for: .normal)
        toggleJustifyButton.addTarget(self, action: #selector(didTapToggleJustify), for: .touchUpInside)
        buttonsStackView.addItem(toggleJustifyButton)

        toggleVisibilityButton.backgroundColor = .gray
        toggleVisibilityButton.setTitle("Visible", for: .normal)
        toggleVisibilityButton.addTarget(self, action: #selector(didTapToggleVisibility), for: .touchUpInside)
        buttonsStackView.addItem(toggleVisibilityButton)

        removeButton.backgroundColor = .gray
        removeButton.setTitle("Remove", for: .normal)
        removeButton.addTarget(self, action: #selector(didTapRemove), for: .touchUpInside)
        buttonsStackView.addItem(removeButton)

        insertButton.backgroundColor = .gray
        insertButton.setTitle("Insert", for: .normal)
        insertButton.addTarget(self, action: #selector(didTapInsert), for: .touchUpInside)
        buttonsStackView.addItem(insertButton)

        buttonsStackView.direction(.row)
        buttonsStackView.justifyContent(.spaceBetween)
//        addSubview(buttonsStackView)

        view1.sizeThatFitsExpectedArea = 400 * 20

        setupFlex()

        testMargins()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func testMargins() {
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.numberOfLines = 1

        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.numberOfLines = 0

        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.numberOfLines = 0

        //        label1.text = "Label 1 Label 1 Label 1 Label 1 "
        //        label2.text = "Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 "
        //        view1.sizeThatFitsExpectedArea = 400 * 50

        label1.text = "Label 1"
        label2.text = "Label a little longuer"
        label3.text = "Label very very very much longuer"
        view1.sizeThatFitsExpectedArea = 400 * 50

        label1.text = "Label 1"
        label2.text = "Label longuer"
        label3.text = "Label much longuer"
        view1.sizeThatFitsExpectedArea = 400 * 20

        //        label1.text = "Label 1"
        //        label2.text = "Label a little longuer"
        //        label3.text = "Label very very very much longuer"

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))

        stackView.define({ (stackView) in
            stackView.addItem(label1)
            stackView.addItem(label2)
            stackView.addItem(view1)
        })

        label2.item.isIncludedInLayout = false

        layout()
    }

    func setupFlex() {
        let view1 = BasicView(text: "FlexLayout", color: UIColor.red)
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))

        let label1 = UILabel(); label1.backgroundColor = .red; label1.font = UIFont.systemFont(ofSize: 17)
        label1.numberOfLines = 1
        label1.text = "Label 1"

        let label2 = UILabel(); label2.font = UIFont.systemFont(ofSize: 17); label2.backgroundColor = .green; label2.numberOfLines = 0
        label2.text = "Label longuer"

        let label3 = UILabel();label3.font = UIFont.systemFont(ofSize: 17);label3.backgroundColor = .blue; label3.numberOfLines = 0
        label3.text = "Label much longuer"

        //        label1.text = "Label 1 Label 1 Label 1 Label 1 "
        //        label2.text = "Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 "
        //        view1.sizeThatFitsExpectedArea = 400 * 50

        label1.text = "Label 1"
        label2.text = "Label longuer"
        label3.text = "Label much longuer"
        view1.sizeThatFitsExpectedArea = 400 * 20

        //        label1.text = "Label 1"
        //        label2.text = "Label a little longuer"
        //        label3.text = "Label very very very much longuer"

        rootFlexContainer.isHidden = true

        rootFlexContainer.flex.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (flex) in
            flex.addItem(label1)
            flex.addItem(label2)
            flex.addItem(view1)
        })

//        label2.flex.isIncludedInLayout = false

        addSubview(rootFlexContainer)
    }

    private func layout() {
        func layoutView(view: UIView) {
            view.pin.top(64).width(400).height(600)
        }
        layoutView(view: stackView)
        layoutView(view: rootFlexContainer)
        stackView.layout()
        rootFlexContainer.flex.layout()

        //        func layoutView(view: UIView) {
        //            view.pin.top(64).width(400).sizeToFit(.width)
        //        }
        //        layoutView(view: stackView)
        //        layoutView(view: rootFlexContainer)
        //        stackView.layout()
        //        rootFlexContainer.flex.layout(mode: .adjustHeight)

        //        func layoutView(view: UIView) {
        //            view.pin.top(64).height(200).sizeToFit(.height)
        //        }
        //        layoutView(view: stackView)
        //        layoutView(view: rootFlexContainer)
        //        stackView.layout()
        //        rootFlexContainer.flex.layout(mode: .adjustWidth)

        print("// Match FlexLayout")
        printViewFrame(stackView, name: "stackView")
        printViewFrame(label1, name: "label1")
        printViewFrame(label2, name: "label2")
        //        printViewFrame(label3, name: "label3")
        printViewFrame(view1, name: "view1")
    }

    func doc() {
        let button1 = BasicButton(text: "button1")
        let button2 = BasicButton(text: "button2")
        let button3 = BasicButton(text: "button3")

        stackView.define { (stack) in
            stack.addItem(button1)
            stack.addItem(button2).marginTop(10)
            stack.addItem(button3).marginTop(10)
        }

        //        stackView.direction(.row).alignItems(.start).define { (stack) in
        //            stack.addItem(button1).shrink(1)
        //            stack.addItem(button2).marginLeft(10).shrink(1)
        //            stack.addItem(button3).marginLeft(10).shrink(1)
        //        }

        layout()
    }

    func didTapView() {
        //        if label1.isHidden {
        //            stackView.showItem(label1, animate: true)
        //        } else {
        //            stackView.hideItem(label1, animate: true)
        //        }
        stackView.isHidden = !stackView.isHidden
        rootFlexContainer.isHidden = !rootFlexContainer.isHidden
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    fileprivate func printViewFrame(_ view: UIView, name: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = "."

        let x = numberFormatter.string(from: NSNumber(value: Float(view.frame.origin.x)))!
        let y = numberFormatter.string(from: NSNumber(value: Float(view.frame.origin.y)))!
        let width = numberFormatter.string(from: NSNumber(value: Float(view.frame.size.width)))!
        let height = numberFormatter.string(from: NSNumber(value: Float(view.frame.size.height)))!

        print("expect(\(name).frame).to(beCloseTo(CGRect`, within: withinRange))")
    }

    internal func didTapToggleDirection() {
        if stackView.getDirection() == .column {
            stackView.direction(.row)
        } else {
            stackView.direction(.column)
        }

        setNeedsLayout()
    }

    internal func didTapToggleJustify() {
        switch stackView.getJustifyContent() {
        case .start:        stackView.justifyContent(.center)
        case .center:       stackView.justifyContent(.end)
        case .end:          stackView.justifyContent(.spaceBetween)
        case .spaceBetween: stackView.justifyContent(.spaceAround)
        case .spaceAround:  stackView.justifyContent(.spaceEvenly)
        case .spaceEvenly:  stackView.justifyContent(.start)
        }

        setNeedsLayout()
    }

    internal func didTapToggleVisibility() {
        if label2.isHidden {
            stackView.showItem(label2, animate: true)
        } else {
            stackView.hideItem(label2, animate: true)
        }

        setNeedsLayout()
    }

    internal func didTapRemove() {
        label2.removeFromSuperview()
    }

    internal func didTapInsert() {
        stackView.insertItem(label2, at: 1)
    }
}
