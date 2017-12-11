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
import StackLayoutView
import PinLayout

class DocExamplesView: BaseView {

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
        
        view1.sizeThatFitsExpectedArea = 400 * 20

        showExample1()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showExample1() {
//        label1 = UILabel()
//        label1.backgroundColor = .red
//        label1.font = UIFont.systemFont(ofSize: 17)
//        label1.text = "Label 1"
//
//        label2 = UILabel()
//        label2.font = UIFont.systemFont(ofSize: 17)
//        label2.backgroundColor = .green
//        label2.text = "Label longuer"
//
//        label3 = UILabel()
//        label3.font = UIFont.systemFont(ofSize: 17)
//        label3.backgroundColor = .blue
//        label3.text = "Label much longuer"
        
        let view1 = BasicView(text: "View 1", color: .red)
        let view2 = BasicView(text: "View 2", color: .red)
        let view3 = BasicView(text: "View 3", color: .red)
        
        stackLayoutView.direction(.column).define { (stack) in
            view1.item.height(40)
            stack.addItem(view1)
            
//            view2.item.height(40)
//            stack.addItem(view2)
//
//            view3.item.height(40)
//            stack.addItem(view3)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackLayoutView.pin.top(80).left().width(400).height(600)

//        buttonsStackView.pin.below(of: stackLayoutView).left().right().margin(8).sizeToFit(.width)
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
