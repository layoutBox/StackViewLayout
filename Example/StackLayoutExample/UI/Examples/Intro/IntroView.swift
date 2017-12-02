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
    
    var stackLayoutView: StackLayoutView!
    //        let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    //        let textLabel = UILabel()
    //        let separatorView = UIView()
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    override init() {
        super.init()
        
        stackLayoutView = StackLayoutView()
        stackLayoutView.layer.borderColor = UIColor.black.cgColor
        stackLayoutView.layer.borderWidth = 1
        addSubview(stackLayoutView)
        
        testAlignItems()
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
        label1.text = "Label 1"
        
        label2 = UILabel()
        label2.backgroundColor = .green
        label2.text = "Label 2"
        
        label3 = UILabel()
        label3.backgroundColor = .blue
        label3.text = "Label 3"
        
        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)
        
        stackLayoutView.direction(.column)
        stackLayoutView.justifyContent(.end)
        stackLayoutView.alignItems(.end)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the stackLayoutView using the view's safeArea with at least of 10 pixels all around.
//        let containerInsets = safeArea.minInsets(UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        stackLayoutView.frame = CGRect(x: 0, y: 80, width: 400, height: 600)
        
        printViewFrame(label1, name: "label1")
        printViewFrame(label2, name: "label2")
        printViewFrame(label3, name: "label3")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("expect(\(name).frame).to(beCloseTo(CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height)), within: 0.5))")
    }
}
