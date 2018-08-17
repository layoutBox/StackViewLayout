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
import StackLayout

class ShrinkColumnSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackView: StackView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTestDisplayScale(displayScale: 3)
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
            label1.text = "Label 1 Label 1 Label 1 Label 1 "

            // label1 is multi line
            label2 = UILabel()
            label2.font = UIFont.systemFont(ofSize: 17)
            label2.backgroundColor = .green
            label2.numberOfLines = 0
            label2.text = "Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 Label 2 "

            view1 = BasicView(text: "View 1", color: .red)
            view1.sizeThatFitsExpectedArea = 400 * 50
        }
        
        //
        // COLUMN: Adjust the height based on a fixed width
        //
        describe("COLUMN: shrink") {
            it("no shrink") {
                stackView.define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 200, height: 101.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 122, width: 200, height: 100), within: withinRange))
            }
            
            it("1 item with shrink") {
                stackView.define { (stack) in
                    label1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 101.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 101.667, width: 200, height: 100), within: withinRange))
            }
            
            it("1 item with shrink") {
                stackView.define { (stack) in
                    label2.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 200, height: 59.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 100), within: withinRange))
            }
            
            it("2 items with shrink") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 13.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 13.333, width: 200, height: 66.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 100), within: withinRange))
            }
            
            it("2 items with shrink") {
                stackView.define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(4)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 18.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 18.333, width: 200, height: 61.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 100), within: withinRange))
            }
            
            it("3 items with shrink") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(1)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 16.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 16.333, width: 200, height: 82.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 98.667, width: 200, height: 81), within: withinRange))
            }
            
            it("3 items with shrink") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 19.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 19.667, width: 200, height: 64), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 83.667, width: 200, height: 96.333), within: withinRange))
            }
            
            it("shrink + maxHeight") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).maxHeight(100)
                    label2.item.shrink(10).maxHeight(120)
                    view1.item.shrink(1).maxHeight(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 19.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 19.667, width: 200, height: 64), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 83.667, width: 200, height: 96.333), within: withinRange))
            }
            
            it("The label1 should shrink to takes the extra space.") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10).maxHeight(120)
                    view1.item.shrink(1).maxHeight(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 19.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 19.667, width: 200, height: 64), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 83.667, width: 200, height: 96.333), within: withinRange))
            }
            
            it("shrink + minHeight + label2 height result is 0") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).minHeight(80)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minHeight(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 80), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 100), within: withinRange))
            }
            
            it("shrink + minHeight + overflow") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).minHeight(200)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minHeight(220)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 200, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 200, height: 220), within: withinRange))
            }
            
            it("shrink + minHeight + overflow") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1).minHeight(300)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minHeight(320)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 300), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 300, width: 200, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 300, width: 200, height: 320), within: withinRange))
            }
            
            it("shrink + minHeight") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(2)
                    view1.item.shrink(1).minHeight(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.frame = CGRect(x: 0, y: 64, width: 200, height: 180)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 200, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 16.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 16.667, width: 200, height: 63.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 80, width: 200, height: 100), within: withinRange))
            }
            
            it("should not apply shrink since the stack will adjust its height") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.shrink(10)
                    view1.item.shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 131.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 61), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 81.333, width: 400, height: 50), within: withinRange))
            }
        }
    }
}
