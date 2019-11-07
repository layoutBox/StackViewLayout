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
import StackViewLayout

class MethodCell: UITableViewCell {
    static let reuseIdentifier = "MethodCell"
    
    fileprivate let stackView = StackView()

    fileprivate let iconImageView = UIImageView(image: UIImage(named: "method"))
    fileprivate let nameLabel = UILabel()
    fileprivate let typeLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero

        let margin: CGFloat = 10

        // Column StackView
        stackView.padding(14).define { (stackView) in

            // Row StackView
            stackView.addStackView().direction(.row).define({ (stackView) in
                stackView.addItem(iconImageView).size(30)

                nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
                nameLabel.lineBreakMode = .byTruncatingTail
                stackView.addItem(nameLabel).marginLeft(margin)
            })

            typeLabel.font = UIFont.boldSystemFont(ofSize: 14)
            stackView.addItem(typeLabel).marginTop(margin)

            descriptionLabel.font = UIFont.systemFont(ofSize: 12)
            descriptionLabel.numberOfLines = 0
            stackView.addItem(descriptionLabel).marginTop(margin)
        }

        contentView.addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(method: Method) {
        nameLabel.text = method.name
        typeLabel.text = "▪︎ Apply to: \(method.type.text)"
        descriptionLabel.text = method.description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        stackView.pin.top().horizontally().sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()
        
        // 3) Returns the size of the StackView
        return CGSize(width: contentView.frame.width, height: stackView.frame.maxY)
    }
}
