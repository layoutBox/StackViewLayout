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

    fileprivate let stackLayoutView = StackLayoutView()
    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
//    fileprivate let segmented = UISegmentedControl(items: ["Intro", "1", "2"])
    fileprivate let textLabel = UILabel()
    fileprivate let separatorView = UIView()
    
//    fileprivate let columnView = UIView()
    fileprivate let label1 = UILabel()
    fileprivate let label2 = UILabel()
    fileprivate let label3 = UILabel()

    override init() {
        super.init()
        
        addSubview(stackLayoutView)

        logo.contentMode = .scaleAspectFit
        logo.item.size(40)
        stackLayoutView.addItem(logo)
        
//        segmented.selectedSegmentIndex = 0
//        segmented.tintColor = .stackLayoutColor
//        stackLayoutView.addSubview(segmented)
        
        textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        stackLayoutView.addItem(textLabel)
        
//        separatorView.pin.height(1)
//        separatorView.backgroundColor = .stackLayoutColor
//        stackLayoutView.addSubview(separatorView)
//
//        columnView.backgroundColor = .gray
//        stackLayoutView.addSubview(columnView)
        
        label1.backgroundColor = .red
        label1.text = "Label 1"
        label1.item.marginTop(10)
        label1.item.marginBottom(10)
        stackLayoutView.addItem(label1)

        label2.backgroundColor = .green
        label2.text = "Label 2"
        stackLayoutView.addItem(label2)

        label3.backgroundColor = .blue
        label3.text = "Label 3"
        stackLayoutView.addItem(label3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the stackLayoutView using the view's safeArea with at least of 10 pixels all around.
        let containerInsets = safeArea.minInsets(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        
        stackLayoutView.pin.all().margin(containerInsets)
        
//        logo.pin.top().left().width(100).aspectRatio().marginTop(10)
//        segmented.pin.after(of: logo, aligned: .top).right().marginLeft(10)
//        textLabel.pin.below(of: segmented, aligned: .left).width(of: segmented).pinEdges().marginTop(10).sizeToFit(.width)
//        separatorView.pin.below(of: [logo, textLabel], aligned: .left).right(to: segmented.edge.right).marginTop(10)
        
//        columnView.pin.top().left().right().layoutColumn(column, padding: UIEdgeInsets) {
//            column.layout(childView1).width(100%).height(200)           // Should apply columnView padding
//            column.layout(child2).hCenter().width(100).marginBottom(20)
//        }
//        
//        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        columnView.pin.top().left().right().layoutColumn(padding: padding) { (column) in
//            column.layout(label1).width(100%).height(40).marginTop(10)
//            column.layout(label2).left(0).right(0).height(40).marginTop(10).marginLeft(10).marginRight(10)
//            column.layout(label3).width(100%).height(40).marginTop(10).marginBottom(10)
//        }
    }
}
