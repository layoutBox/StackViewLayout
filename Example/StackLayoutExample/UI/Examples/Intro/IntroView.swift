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

class IntroView: BaseView {

    fileprivate let stackView = StackView()

    override init() {
        super.init()

        let button1 = createButton(imageName: "share_1")
        let button2 = createButton(imageName: "share_2")
        let button3 = createButton(imageName: "share_3")
        let button4 = createButton(imageName: "share_4")

        let button5 = createButton(imageName: "share_5")
        let button6 = createButton(imageName: "share_6")
        let button7 = createButton(imageName: "share_7")
        let button8 = createButton(imageName: "share_8")

        var imageRatio: CGFloat? = nil
        if let imageSize = button1.image(for: .normal)?.size {
            imageRatio = imageSize.width / imageSize.height
        }

        //stackView.define { (stackView) in
            stackView.addStackView().direction(.row).justifyContent(.spaceBetween).define { (stackView) in
                stackView.addItem(button1).shrink(1).aspectRatio(imageRatio)
                stackView.addItem(button2)/*.marginLeft(10)*/.shrink(1).aspectRatio(imageRatio)
                stackView.addItem(button3)/*.marginLeft(10)*/.shrink(1).aspectRatio(imageRatio)
                stackView.addItem(button4)/*.marginLeft(10)*/.shrink(1).aspectRatio(imageRatio)
            }

//            stackView.addStackView().direction(.row).justifyContent(.spaceBetween).define { (stackView) in
//                stackView.addItem(button5).shrink(1)//.aspectRatio(imageRatio)
//                stackView.addItem(button6).marginLeft(10).shrink(1)//.aspectRatio(imageRatio)
//                stackView.addItem(button7).marginLeft(10).shrink(1)//.aspectRatio(imageRatio)
//                stackView.addItem(button8).marginLeft(10).shrink(1)//.aspectRatio(imageRatio)
//            }.item.marginTop(10)
        //}
        addSubview(stackView)

        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 1 / 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        stackView.pin.top(safeArea.top).left().width(120).sizeToFit(.width)
    }

    fileprivate func createButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)

        return button
    }
}
