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
import PinLayout

class DocExamplesView: BaseView {
    fileprivate let stackView = StackView()

    fileprivate let buttonsStackView = StackView()
    fileprivate let directionLabel = UILabel()
    fileprivate let alignItemsLabel = UILabel()
    fileprivate let justifyLabel = UILabel()

    override init() {
        super.init()

        stackView.direction(.column).define { (stack) in
            stack.addItem(BasicView(text: "View 1"))
            stack.addItem(BasicView(text: "View 2"))
            stack.addItem(BasicView(text: "View 3"))
            stack.addItem(BasicView(text: "View 4"))
        }
        addSubview(stackView)

        createButtonsBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Position the two StackViews using PinLayout
        buttonsStackView.pin.bottom().horizontally().sizeToFit(.width)
        stackView.pin.top().above(of: buttonsStackView).horizontally().margin(safeArea)
    }

    override func safeAreaDidChange() {
        buttonsStackView.padding(5, 5, safeArea.bottom, 5)
    }

    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
    }

    fileprivate func createButtonsBar() {
        buttonsStackView.direction(.row).justifyContent(.spaceBetween).define { (stackView) in
            stackView.addStackView().alignItems(.center).define({ (stackView) in
                let toggleDirectionButton = createButton(title: "direction")
                toggleDirectionButton.addTarget(self, action: #selector(didTapToggleDirection), for: .touchUpInside)
                stackView.addItem(toggleDirectionButton)

                stackView.addItem(directionLabel)
            }).item.shrink(1)

            stackView.addStackView().alignItems(.center).define({ (stackView) in
                let toggleJustifyButton = createButton(title: "justifyContent")
                toggleJustifyButton.addTarget(self, action: #selector(didTapToggleJustify), for: .touchUpInside)
                stackView.addItem(toggleJustifyButton)

                stackView.addItem(justifyLabel)
            }).item.marginLeft(4).shrink(1)

            stackView.addStackView().alignItems(.center).define({ (stackView) in
                let toggleVisibilityButton = createButton(title: "alignItems")
                toggleVisibilityButton.addTarget(self, action: #selector(didTapToggleAlignItems), for: .touchUpInside)
                stackView.addItem(toggleVisibilityButton)

                stackView.addItem(alignItemsLabel)
            }).item.marginLeft(4).shrink(1)
        }

        buttonsStackView.backgroundColor(.lightGray)
        addSubview(buttonsStackView)

        updateLabels()
    }

    fileprivate func createButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .darkGray
        button.setTitle(title, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }

    internal func didTapToggleDirection() {
        switch stackView.getDirection() {
        case .column: stackView.direction(.row)
        case .row:    stackView.direction(.column)
        }

        applyChange()
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
        
        applyChange()
    }
    
    internal func didTapToggleAlignItems() {
        switch stackView.getAlignItems() {
        case .stretch: stackView.alignItems(.start)
        case .start:   stackView.alignItems(.center)
        case .center:  stackView.alignItems(.end)
        case .end:     stackView.alignItems(.stretch)
        }

        applyChange()
    }

    fileprivate func applyChange() {
        updateLabels()

        UIView.animate(withDuration: 0.3) {
            self.stackView.layout()
        }
    }

    fileprivate func updateLabels() {
        switch stackView.getDirection() {
        case .column: directionLabel.text = ".column"
        case .row:    directionLabel.text = ".row"
        }

        switch stackView.getJustifyContent() {
        case .start:        justifyLabel.text = ".start"
        case .center:       justifyLabel.text = ".center"
        case .end:          justifyLabel.text = ".end"
        case .spaceBetween: justifyLabel.text = ".spaceBetween"
        case .spaceAround:  justifyLabel.text = ".spaceAround"
        case .spaceEvenly:  justifyLabel.text = ".spaceEvenly"
        }

        switch stackView.getAlignItems() {
        case .stretch: alignItemsLabel.text = ".stretch"
        case .start:   alignItemsLabel.text = ".start"
        case .center:  alignItemsLabel.text = ".center"
        case .end:     alignItemsLabel.text = ".end"
        }

        buttonsStackView.markDirty()
    }
}
