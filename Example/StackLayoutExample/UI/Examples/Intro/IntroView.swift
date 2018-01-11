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

class IntroView: BaseView {

    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let textLabel = UILabel()
    fileprivate let separatorView = UIView()
    
    fileprivate let buttonsStackView = StackView()
    fileprivate let toggleDirectionButton = UIButton(type: .custom)
    fileprivate let toggleJustifyButton = UIButton(type: .custom)
    fileprivate let toggleVisibilityButton = UIButton(type: .custom)
    fileprivate let removeButton = UIButton(type: .custom)
    fileprivate let insertButton = UIButton(type: .custom)

    fileprivate let rootFlexContainer = UIView()
    
    var stackView: StackView!
    //        let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    //        let textLabel = UILabel()
    //        let separatorView = UIView()
    
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

//        stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
//            label1.item.grow(1).maxHeight(100)
//            label2.item.grow(10).maxHeight(120)
//            view1.item.grow(1)//.maxHeight(140)
//
//            stack.addItem(label1)
//            stack.addItem(label2)
//            stack.addItem(view1)
//        }

        stackView.direction(.column).define { (stack) in
//            label1.item.aspectRatio(2).marginVertical(10).marginHorizontal(10)
            label1.item.aspectRatio(2).marginVertical(10).marginHorizontal(10).maxWidth(200).maxHeight(150)
            label2.item.aspectRatio(1)
            view1.item.aspectRatio(5/6).margin(20).shrink(1)

            stack.addItem(label1)
            stack.addItem(label2)
            stack.addItem(view1)
        }

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

//        rootFlexContainer.flex.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (flex) in
//            label1.flex.grow(1).maxHeight(100)
//            label2.flex.grow(10).maxHeight(120)
//            view1.flex.grow(1)//.maxHeight(140)
//
//            flex.addItem(label1)
//            flex.addItem(label2)
//            flex.addItem(view1)
//        })

        rootFlexContainer.flex.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (flex) in
//            label1.flex.aspectRatio(2).marginVertical(10).marginHorizontal(10)
            label1.flex.aspectRatio(2).marginVertical(10).marginHorizontal(10).maxWidth(200).maxHeight(150)

            label2.flex.aspectRatio(1)
            view1.flex.aspectRatio(5/6).margin(20).shrink(1)

            flex.addItem(label1)
            flex.addItem(label2)
            flex.addItem(view1)
        })
    
        addSubview(rootFlexContainer)
    }
    
    private func layout() {
        func layoutView(view: UIView) {
//            view.pin.top(64).left().width(400).height(100)
//            view.pin.top(64).left().width(400).height(90)
            view.pin.top(64).width(400).height(600)
//            view.pin.top(64).width(400).height(600)
//            view.pin.top(64).width(400).sizeToFit(.width)
//            view.pin.top(64).height(200).sizeToFit(.height)
        }
//        stackView.pin.top(64).left().width(200).height(180)
        
//        stackView.pin.top(80).left().height(400).sizeToFit(.height)
        layoutView(view: stackView)
        layoutView(view: rootFlexContainer)
        stackView.layout()
        
//        rootFlexContainer.flex.layout(mode: .adjustWidth)
//        rootFlexContainer.flex.layout(mode: .adjustHeight)
        rootFlexContainer.flex.layout()
        
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

        print("expect(\(name).frame).to(beCloseTo(CGRect(x: \(x), y: \(y), width: \(width), height: \(height)), within: withinRange))")
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
