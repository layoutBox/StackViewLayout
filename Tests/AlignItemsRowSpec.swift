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
import StackLayout
import PinLayout

class AlignItemsRowSpec: QuickSpec {
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
            label1.numberOfLines = 1
            
            label2 = UILabel()
            label2.font = UIFont.systemFont(ofSize: 17)
            label2.backgroundColor = .green
            label2.numberOfLines = 0
            
            label1.text = "Label 1"
            label2.text = "Label longuer"
            
            view1 = BasicView(text: "View 1", color: .red)
            view1.sizeThatFitsExpectedArea = 400 * 20
        }
        
        //
        // align()
        //
        describe("StackLayout align()") {
            it("align(.stretch)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()

                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 400, height: 600), within: withinRange))
            }

            it("align(.start)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 400, height: 20), within: withinRange))
            }
            
            it("align(.center)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 400, height: 20), within: withinRange))
            }
            
            it("align(.end)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 580, width: 400, height: 20), within: withinRange))
            }
        }
        
        //
        // alignSelf()
        //
        describe("StackLayout alignSelf()") {
            it("alignSelf(.auto)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label2.item.alignSelf(.auto)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 400, height: 20), within: withinRange))
            }
            
            it("alignSelf(.start)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label2.item.alignSelf(.start)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 400, height: 20), within: withinRange))
            }
            
            it("alignSelf(.center)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label2.item.alignSelf(.center)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 400, height: 20), within: withinRange))
            }
            
            it("alignSelf(.end)") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label2.item.alignSelf(.end)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match UIStackView
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 400, height: 20), within: withinRange))
            }
        }
    }
}
