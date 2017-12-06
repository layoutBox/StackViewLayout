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
import StackLayout
import PinLayout

class IntroView: BaseView {

    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let textLabel = UILabel()
    fileprivate let separatorView = UIView()
    
    fileprivate let buttonsStackView = StackLayoutView()
    fileprivate let toggleDirectionButton = UIButton(type: .custom)
    fileprivate let toggleJustifyButton = UIButton(type: .custom)
    fileprivate let toggleVisibilityButton = UIButton(type: .custom)
    fileprivate let removeButton = UIButton(type: .custom)
    fileprivate let insertButton = UIButton(type: .custom)
    
    var stackLayoutView: StackLayoutView!
    //        let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    //        let textLabel = UILabel()
    //        let separatorView = UIView()
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    let view1 = BasicView(text: "View 1", color: UIColor.red)
    
    override init() {
        super.init()
    
        stackLayoutView = StackLayoutView()
        stackLayoutView.layer.borderColor = UIColor.black.cgColor
        stackLayoutView.layer.borderWidth = 1
        addSubview(stackLayoutView)
        
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
        
//        testAlignItems()
//        testRowDirection()
        testMargins()

//        logo.contentMode = .scaleAspectFit
//
//        textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
//        textLabel.font = .systemFont(ofSize: 14)
//        textLabel.numberOfLines = 0
//        textLabel.lineBreakMode = .byWordWrapping
//
//        separatorView.backgroundColor = .stackLayoutColor
//
//        label1.backgroundColor = .red
//        label1.text = "Label 1"
//
//        label2.backgroundColor = .green
//        label2.text = "Label 2"
//
//        label3.backgroundColor = .blue
//        label3.text = "Label 3"
        
        // configure the StackView
//        logo.item.size(60)
//        stackLayoutView.addItem(logo)
//        
//        textLabel.item.maxWidth(50%)
//        stackLayoutView.addItem(textLabel)
//        
//        separatorView.item.height(4)
//        stackLayoutView.addItem(separatorView)
//        
//        label1.item.marginTop(10).marginBottom(10)
//        stackLayoutView.addItem(label1)
//        
//        stackLayoutView.addItem(label2)
//        stackLayoutView.addItem(label3)
//
//        stackLayoutView.direction(.column)  // Default
//        stackLayoutView.justifyContent(.start)
//        stackLayoutView.alignItems(.stretch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func testAlignItems() {
        logo.contentMode = .scaleAspectFit
        
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label a little longuer"
        
        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label very very very much longuer"
        
        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)
        
        stackLayoutView.direction(.column)
        stackLayoutView.justifyContent(.spaceAround)
//        stackLayoutView.alignItems(.center)
        
//        label2.item.alignSelf(.end)
    }
    
    func testRowDirection() {
        logo.contentMode = .scaleAspectFit
        
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label longuer"
        
        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label much longuer"
        
        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)
        
        stackLayoutView.direction(.row)
        stackLayoutView.justifyContent(.start)
        stackLayoutView.alignItems(.start)
        
        label2.item.alignSelf(.auto)
    }
    
    func testMargins() {
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label longuer"
        
        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label much longuer"
        
        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)

        view1.item.height(40)
        stackLayoutView.addItem(view1)

        stackLayoutView.direction(.column)
        stackLayoutView.justifyContent(.start)
        stackLayoutView.alignItems(.stretch)

        label1.item.marginTop(10).marginBottom(20)
        label2.item.marginTop(10).marginBottom(20)
        label3.item.marginTop(30)
        view1.item.marginTop(2).marginBottom(40)
        
//        label1.item.marginLeft(10).marginRight(200)
//        view1.item.marginLeft(10).marginRight(200)
        
//        label1.item.marginLeft(10).marginRight(200)
////        label1.item.marginEnd(10)
////        label2.item.marginEnd(25%)
//        view1.item.marginLeft(10).marginRight(200)
//        label1.item.marginRight(10)
//        label2.item.marginRight(25%)
//        view1.item.marginLeft(200).marginRight(40)
//        label3.item.marginLeft(25%)
//        label1.item.marginLeft(10).marginRight(20)
//        label1.item.marginRight(50%)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the stackLayoutView using the view's safeArea with at least of 10 pixels all around.
//        let containerInsets = safeArea.minInsets(UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        stackLayoutView.pin.top(80).left().width(400).height(600)

//        buttonsStackView.pin.below(of: stackLayoutView).left().right().margin(8).sizeToFit(.width)

        printViewFrame(label1, name: "label1")
        printViewFrame(label2, name: "label2")
        printViewFrame(label3, name: "label3")
        printViewFrame(view1, name: "view1")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("expect(\(name).frame).to(beCloseTo(CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height)), within: 0.5))")
    }
    
    internal func didTapToggleDirection() {
        if stackLayoutView.getDirection() == .column {
            stackLayoutView.direction(.row)
        } else {
            stackLayoutView.direction(.column)
        }
        
        setNeedsLayout()
    }
    
    internal func didTapToggleJustify() {
        switch stackLayoutView.getJustifyContent() {
        case .start:        stackLayoutView.justifyContent(.center)
        case .center:       stackLayoutView.justifyContent(.end)
        case .end:          stackLayoutView.justifyContent(.spaceBetween)
        case .spaceBetween: stackLayoutView.justifyContent(.spaceAround)
        case .spaceAround:  stackLayoutView.justifyContent(.spaceEvenly)
        case .spaceEvenly:  stackLayoutView.justifyContent(.start)
        }
        
        setNeedsLayout()
    }
    
    internal func didTapToggleVisibility() {
        if label2.isHidden {
            stackLayoutView.showItem(label2, animate: true)
        } else {
            stackLayoutView.hideItem(label2, animate: true)
        }

        setNeedsLayout()
    }
    
    internal func didTapRemove() {
        label2.removeFromSuperview()
    }
    
    internal func didTapInsert() {
        stackLayoutView.insertItem(label2, at: 1)
    }
}
