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

import Quick
import Nimble
import PinLayout
import StackViewLayout

class isIncludedInLayoutSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackView: StackView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTestDisplayScale(scale: 3)
            _pinlayoutSetUnitTest(scale: 3)
        }

        beforeEach {
            viewController = UIViewController()

            stackView = StackView()
            stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
            viewController.view.addSubview(stackView)

            label1 = UILabel()
            label1.backgroundColor = .red
            label1.font = UIFont.systemFont(ofSize: 17)
            label1.numberOfLines = 0
            
            label2 = UILabel()
            label2.font = UIFont.systemFont(ofSize: 17)
            label2.backgroundColor = .green
            label2.numberOfLines = 0
            
            view1 = BasicView(text: "View 1", color: .red)

            label1.text = "Label 1"
            label2.text = "Label longuer"
            view1.sizeThatFitsExpectedArea = 400 * 20
        }
        
        //
        // isIncludedInLayout()
        //
        describe("usage of isIncludedInLayout") {
            it("isIncludedInLayout()") {
                stackView.define({ (_) in
                    stackView.addItem(label1)
                    stackView.addItem(label2).isIncludedInLayout(false)
                    stackView.addItem(view1)
                })
                let size = stackView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackView.frame = CGRect(x: 0, y: 64, width: size.width, height: size.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 40.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20), within: withinRange))
            }

            it("isIncludedInLayout() after") {
                stackView.define({ (_) in
                    stackView.addItem(label1)
                    stackView.addItem(label2)
                    stackView.addItem(view1)
                })

                label2.item.isIncludedInLayout(false)

                let size = stackView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackView.frame = CGRect(x: 0, y: 64, width: size.width, height: size.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 40.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20), within: withinRange))
            }

            it("isIncludedInLayout") {
                stackView.define({ (_) in
                    stackView.addItem(label1)
                    stackView.addItem(label2)
                    stackView.addItem(view1)
                })

                label2.item.isIncludedInLayout = false
                let size = stackView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackView.frame = CGRect(x: 0, y: 64, width: size.width, height: size.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 40.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20), within: withinRange))
            }
        }
    }
}
