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

class ShrinkRowSpec: QuickSpec {
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

            // label1 is single line
            label1 = UILabel()
            label1.font = UIFont.systemFont(ofSize: 17)
            label1.backgroundColor = .red
            label1.numberOfLines = 1
            label1.text = "Label 1"

            // label1 is multi line
            label2 = UILabel()
            label2.font = UIFont.systemFont(ofSize: 17)
            label2.backgroundColor = .green
            label2.numberOfLines = 0
            label2.text = "Label longuer"
            
            view1 = BasicView(text: "View 1", color: .red)
            view1.sizeThatFitsExpectedArea = 400 * 20
        }
        
        //
        // ROW: Adjust the width based on a fixed height
        //
        describe("ROW: shrink") {
            it("1 item with shrink + adjust height") {
                stackView.direction(.row).define { (stack) in
                    label1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                let size = stackView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackView.frame = CGRect(x: 0, y: 64, width: size.width, height: size.height)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 504, height: 20.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 504, height: 20.333), within: withinRange))
            }
            
            it("1 item with shrink + adjust height") {
                stackView.direction(.row).define { (stack) in
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                let size = stackView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackView.frame = CGRect(x: 0, y: 64, width: size.width, height: size.height)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 33), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 33), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 33), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 242.333, height: 33), within: withinRange))
            }
            
            it("1 item with shrink") {
                stackView.direction(.row).define { (stack) in
                    label1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 600), within: withinRange))
            }
            
            it("1 item with shrink") {
                stackView.direction(.row).define { (stack) in
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 242.333, height: 600), within: withinRange))
            }
            
            it("1 item with shrink") {
                stackView.direction(.row).define { (stack) in
                    label2.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 0, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 400, height: 600), within: withinRange))
            }
            
            it("2 items with shrink") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 600), within: withinRange))
            }
            
            it("2 items with shrink") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 35, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 35, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 139, y: 0, width: 261, height: 600), within: withinRange))
            }
            
            it("3 items with shrink") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(1)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(200).height(180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 0, width: 58, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 88, y: 0, width: 112, height: 180), within: withinRange))
            }
            
            it("3 items with shrink") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(200).height(180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 42.333, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 42.333, y: 0, width: 0, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 42.333, y: 0, width: 157.667, height: 180), within: withinRange))
            }
            
            it("shrink + maxWidth") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).maxWidth(100)
                    label2.item.shrink(10).maxWidth(120)
                    view1.item.shrink(1).maxWidth(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(250).height(180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 250, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 51.667, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 51.667, y: 0, width: 63.667, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 115.333, y: 0, width: 134.667, height: 180), within: withinRange))
            }
            
            it("shrink with maxWidth.") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10).maxWidth(60)
                    view1.item.shrink(1).maxWidth(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(200).height(180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 52.667, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 52.667, y: 0, width: 49, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 101.667, y: 0, width: 98.333, height: 180), within: withinRange))
            }
            
            it("shrink + minWidth = labe2 width will be zero") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).minWidth(150)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minWidth(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 150, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 0, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 100, height: 180), within: withinRange))
            }
            
            it("shrink + minWidth + overflow") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).minWidth(200)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minWidth(220)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
             
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 200, y: 0, width: 0, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 200, y: 0, width: 220, height: 180), within: withinRange))
            }
            
            it("should not apply shrink since the stack will adjust its height") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.height(200).sizeToFit(.height)
                stackView.layoutIfNeeded()

                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 197.667, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 40, height: 200), within: withinRange))
            }
            
            it("1 item with shrink: View1 should overflow horizontally") {
                label1.text = "Label 1"
                label2.text = "Label longuer"
                view1.sizeThatFitsExpectedArea = 400 * 20
                
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                
                stackView.pin.width(400).height(30)
                stackView.layoutIfNeeded()
                
                // Match mostly UIStackView which by default shrink the view1's width WITHOUT adjusting the view1's height. The result is
                //      that view1 doesn't respect its sizeThatFits() returned value!
                // Match FlexLayout: The view1 overflow the row's width. No shrink factor.
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 30), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 400, height: 20), within: withinRange))
            }
            
            it("1 item with shrink: View1 should NOT overflow horizontally and its size set to container's height (30)") {
                label1.text = "Label 1"
                label2.text = "Label longuer"
                view1.sizeThatFitsExpectedArea = 400 * 20
                
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                })
                
                stackView.pin.width(400).height(30)
                stackView.layoutIfNeeded()
                
                // Match mostly UIStackView which shrink the view1's width WITHOUT adjusting the view1's height. The result is
                //      that view1 doesn't respect its sizeThatFits() returned value!
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 30), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 242.333, height: 30), within: withinRange))
            }
        }
    }
}
