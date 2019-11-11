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

class BasicView: UIView {
    fileprivate let label = UILabel()
    static var intanceCount = 0
    
    init(text: String? = nil) {
        super.init(frame: .zero)
        BasicView.intanceCount += 1

        backgroundColor = UIColor(red: 0.58, green: 0.78, blue: 0.95, alpha: 1.00)
        layer.borderColor = UIColor(red: 0.37, green: 0.67, blue: 0.94, alpha: 1.00).cgColor
        layer.borderWidth = 2
        
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       BasicView.intanceCount -= 1
       print("Deinit BasicView intanceCount:\(BasicView.intanceCount)")
   }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        label.pin.center()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: label.frame.width + 2 * 10, height: label.frame.height + 2 * 10)
    }
}
