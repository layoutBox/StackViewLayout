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

class PaddingSpec: QuickSpec {
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
            label1.font = UIFont.systemFont(ofSize: 17)
            label1.backgroundColor = .red

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
        // 1. colums + paddings
        //
        describe("columns + paddings") {
            it("padding(5, 10, 15, 20) + start + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(0, 0, 0, 40) + start + center") {
                stackView.direction(.column).padding(0, 0, 0, 40).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 153.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 128, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 360, height: 22.333), within: withinRange))
            }
            
            it("padding(0, 40, 0, 0) + start + center") {
                stackView.direction(.column).padding(0, 40, 0, 0).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 193.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 168, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 40.667, width: 360, height: 22.333), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 264, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 262, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282.333, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.667, width: 310, height: 25.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 91.333, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceEvenly + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134.333, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceEvenly + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceEvenly + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceEvenly + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }
        }
            
        describe("columns + paddings + sizeToFit") {
            it("padding(5, 10, 15, 20) + start + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + start + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceBetween + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceAround + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + spaceEvenly + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()
                
                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
        }

        //
        // 1. colums + paddings + MARGINS
        //
        describe("columns + paddings") {
            it("padding(0, 0, 0, 20) + marginLeft + start + center") {
                stackView.direction(.column).padding(0, 0, 0, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).marginLeft(20)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 163.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 138, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 40.667, width: 360, height: 22.333), within: withinRange))
            }
            
            it("padding(0, 10, 0, 20) + marginLeft + start + center") {
                stackView.direction(.column).padding(0, 10, 0, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).marginLeft(20)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 40.667, width: 350, height: 23), within: withinRange))
            }
            
            it("padding(0, 10, 0, 20) + marginLeft + marginRight+ start + center") {
                stackView.direction(.column).padding(0, 10, 0, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 40.667, width: 310, height: 25.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + margins + start + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 45.667, width: 310, height: 25.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + margins + center + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 262, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.667, width: 310, height: 25.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + margins + center + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 158.333, y: 262, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 133, y: 282.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.666, width: 310, height: 25.667), within: withinRange))
            }
            
            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                
                stackView.pin.width(400).height(600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 262, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 282.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 518.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 539, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 158.333, y: 518.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 133, y: 539, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }
                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 518.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 539, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 518.667, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 539, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 518.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 539, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559.666, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + magins + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 274.667, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 539.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 158.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 133, y: 274.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 539.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + spaceAround + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 83, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 274.667, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 466.333, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + spaceAround + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 83, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 274.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 466.333, width: 310, height: 25.667), within: withinRange))
            }
        }

        describe("columns + paddings + sizeToFit") {
            it("padding(5, 10, 15, 20) + margins + start + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 55.333, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 158.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 133, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))

            }

            it("padding(5, 10, 15, 20) + magins + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 55.333, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }
        }

        //
        // 1. colums + paddings
        //
        describe("columns + paddings") {
            it("padding(5, 10, 15, 20) + start + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(0, 0, 0, 40) + start + center") {
                stackView.direction(.column).padding(0, 0, 0, 40).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 153.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 128, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 360, height: 22.333), within: withinRange))
            }

            it("padding(0, 40, 0, 0) + start + center") {
                stackView.direction(.column).padding(0, 40, 0, 0).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 193.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 168, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 40.667, width: 360, height: 22.333), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 264, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 262, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282.333, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 264, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 304.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 522.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 91.333, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 91.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 477.333, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134.333, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 134.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 284, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 433.667, width: 370, height: 21.667), within: withinRange))
            }
        }

        describe("columns + paddings + sizeToFit") {
            it("padding(5, 10, 15, 20) + start + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.end).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 326.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 276, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + center") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceAround + end") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 161.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 100.667, width: 310, height: 25.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + stretch") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceEvenly + start") {
                stackView.direction(.column).padding(5, 10, 15, 20).justifyContent(.spaceEvenly).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Don't Match FlexLayout because FlexLayout don't support spaceEvenly
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 82.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 45.667, width: 370, height: 21.667), within: withinRange))
            }
        }

        //
        // 2. rows + paddings + MARGINS
        //
        describe("columns + paddings") {
            it("padding(0, 0, 0, 20) + marginLeft + start + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.start).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1).marginLeft(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 187.667, y: 5, width: 192.333, height: 41.667), within: withinRange))
            }

            it("padding(0, 10, 0, 20) + marginLeft + start + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1).marginLeft(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 285, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 285, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 187.667, y: 274.333, width: 192.333, height: 41.667), within: withinRange))
            }

            it("padding(0, 10, 0, 20) + marginLeft + marginRight+ start + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 104, height: 580), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 187.667, y: 5, width: 152.333, height: 580), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + start + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 564.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 564.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 474.333, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + center + start") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 5, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 5, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + center + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 285, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 285, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 239.667, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 564.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 564.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 474.333, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + start") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }
                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 5, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 5, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.center).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 285, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 285, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 239.667, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }
                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 564.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 564.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 474.333, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + stretch") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 5, width: 104, height: 580), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 5, width: 72.333, height: 580), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + end + start") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 5, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 5, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + start") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    stack.addItem(label1).marginLeft(10).marginRight(30)
                    stack.addItem(label2).marginLeft(10).marginRight(30)
                    stack.addItem(view1).shrink(1).marginLeft(20).marginRight(40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 5, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 5, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + magins + spaceBetween + stretch") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 53.667, height: 555), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 10, width: 104, height: 555), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 555), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + spaceBetween + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.center).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 277.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 277.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 232.333, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + spaceAround + stretch") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 53.667, height: 555), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 10, width: 104, height: 555), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 555), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + spaceAround + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).height(600)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 544.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 544.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 454.333, width: 72.333, height: 110.667), within: withinRange))
            }
        }

        describe("columns + paddings + sizeToFit") {
            it("padding(5, 10, 15, 20) + margins + start + stretch") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 155.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 53.667, height: 110.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 10, width: 104, height: 110.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + start + center") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.start).alignItems(.center).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 155.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 55.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 55.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + center + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 155.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 100.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 100.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + margins + end + end") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.end).alignItems(.end).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 155.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 100.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 100.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 110.667), within: withinRange))
            }

            it("padding(5, 10, 15, 20) + magins + spaceBetween + stretch") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).margin(5, 10, 20, 30)
                    stack.addItem(label2).margin(5, 10, 20, 30)
                    stack.addItem(view1).shrink(1).margin(5, 20, 20, 40)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layout()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 155.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 53.667, height: 110.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 113.667, y: 10, width: 104, height: 110.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 10, width: 72.333, height: 110.667), within: withinRange))
            }
        }

        //
        // WIDTH
        //
        describe("padding + Width + column") {
            it("adjust") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100)
                    stack.addItem(label2).width(20%)
                    stack.addItem(view1).width(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 74.0, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 66, width: 200, height: 40), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).minWidth(120)
                    stack.addItem(label2).width(100).maxWidth(80)
                    stack.addItem(view1).width(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 120, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 66, width: 200, height: 40), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 45.333, width: 74, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 136, width: 200, height: 40), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 138.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 118.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 150, y: 25, width: 74, height: 78.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 244, y: 35, width: 136, height: 58.667), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).marginHorizontal(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 45.333, width: 74, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 136, width: 200, height: 40), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).marginHorizontal(20)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 221), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 45.333, width: 74, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 136, width: 200, height: 40), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).marginHorizontal(20)
                }

                stackView.pin.height(200).sizeToFit(.height)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout!!
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 270, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 45.333, width: 48, height: 61), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 156.333, width: 200, height: 40), within: withinRange))
            }

            it("width + grow") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).grow(1)
                    stack.addItem(label2).width(20%)
                    stack.addItem(view1).width(50)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 379.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 384.333, width: 74, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 425, width: 50, height: 160), within: withinRange))
            }
        }

        describe("padding + Width + row") {
            it("minWidth + maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).minWidth(120)
                    stack.addItem(label2).width(100).maxWidth(80)
                    stack.addItem(view1).width(200).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 120, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 130, y: 5, width: 80, height: 580), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 210, y: 5, width: 170, height: 580), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 150, y: 25, width: 74, height: 540), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 244, y: 35, width: 136, height: 520), within: withinRange))
            }

            it("width + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).marginHorizontal(10)
                    stack.addItem(label2).width(20%).margin(20)
                    stack.addItem(view1).width(200).marginVertical(30).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 138.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 5, width: 100, height: 118.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 150, y: 25, width: 74, height: 78.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 244, y: 35, width: 136, height: 58.667), within: withinRange))
            }

            it("width + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).width(100).grow(1)
                    stack.addItem(label2).width(20%)
                    stack.addItem(view1).width(50).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 180), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 246, height: 160), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 256, y: 5, width: 74, height: 160), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 330, y: 5, width: 50, height: 160), within: withinRange))
            }

            it("width + shrink") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).shrink(1)
                    stack.addItem(label2).width(20%)
                    stack.addItem(view1).shrink(1).width(350)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 39.333, height: 40.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 49.333, y: 5, width: 74, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 123.333, y: 5, width: 256.667, height: 40.667), within: withinRange))
            }
        }

        //
        // HEIGHT
        //
        describe("padding + height + column") {
            it("adjust") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100)
                    stack.addItem(label2).height(20%)
                    stack.addItem(view1).height(200)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout (except height(20%))
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 340.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 105, width: 370, height: 64), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 169, width: 370, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).minHeight(120)
                    stack.addItem(label2).height(200).maxHeight(180)
                    stack.addItem(view1).height(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 125, width: 370, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 305, width: 370, height: 200), within: withinRange))
            }

            it("height + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1).marginVertical(20).marginHorizontal(20)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 224.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 350, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 125, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 165.333, width: 330, height: 24.333), within: withinRange))
            }

            it("height + grow") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).grow(1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 538), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 543, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 563.333, width: 370, height: 21.667), within: withinRange))
            }

            it("height + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).shrink(1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1)
                }

                stackView.pin.width(400).height(100)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 49), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 54, width: 370, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 74.333, width: 370, height: 10.667), within: withinRange))
            }
        }

        describe("padding + height + row") {
            it("adjust") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100)
                    stack.addItem(label2).height(200)
                    stack.addItem(view1).height(200).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout (except view1, flexlayout doesn't respect the view1.sizeThatFits using
                // using the height of 200)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 104, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 167.667, y: 5, width: 40, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).minHeight(120)
                    stack.addItem(label2).height(200).maxHeight(180)
                    stack.addItem(view1).height(200).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout (except view1, flexlayout doesn't respect the view1.sizeThatFits using
                // using the height of 200)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 104, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 167.667, y: 5, width: 40, height: 200), within: withinRange))
            }

            it("height + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1).marginVertical(10).marginHorizontal(10)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 140), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 53.667, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 5, width: 104, height: 120), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 197.667, y: 15, width: 172.333, height: 100), within: withinRange))
            }

            it("height + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).grow(1)
                    stack.addItem(label2)
                    stack.addItem(view1).width(100)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 120), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 166, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 176, y: 5, width: 104, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 280, y: 5, width: 100, height: 100), within: withinRange))
            }

            it("height + shrink") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).height(100).shrink(1)
                    stack.addItem(label2)
                    stack.addItem(view1).width(250)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 120), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 16, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 26, y: 5, width: 104, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 130, y: 5, width: 250, height: 100), within: withinRange))
            }
        }

        //
        // SIZE
        //
        describe("padding + size + column") {
            it("adjust") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 370), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 105, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 155, width: 200, height: 200), within: withinRange))
            }

            it("minHeight + maxHeight") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).minHeight(120)
                    stack.addItem(label2).size(50).maxHeight(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 125, width: 50, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 165, width: 200, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).minWidth(120)
                    stack.addItem(label2).size(50).maxWidth(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 120, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 105, width: 40, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 155, width: 200, height: 200), within: withinRange))
            }

            it("size + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(200).margin(20).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 430), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 125, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 195, width: 200, height: 200), within: withinRange))
            }

            it("size + grow") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).grow(1)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 330), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 335, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 385, width: 200, height: 200), within: withinRange))
            }

            it("size + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).shrink(1)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(500)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 30), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 35, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 85, width: 500, height: 500), within: withinRange))
            }
        }

        describe("padding + size row") {
            it("adjust") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(500).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 110, y: 5, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 160, y: 5, width: 220, height: 500), within: withinRange))
            }

            it("minHeight + maxHeight") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).minHeight(120)
                    stack.addItem(label2).size(50).maxHeight(40)
                    stack.addItem(view1).size(200).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 110, y: 5, width: 50, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 160, y: 5, width: 200, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).minWidth(120)
                    stack.addItem(label2).size(50).maxWidth(40)
                    stack.addItem(view1).size(200).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 120, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 130, y: 5, width: 40, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 170, y: 5, width: 200, height: 200), within: withinRange))
            }

            it("size + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(100).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 130, y: 5, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 200, y: 25, width: 100, height: 100), within: withinRange))
            }

            it("size + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100)
                    stack.addItem(label2).size(50).grow(1)
                    stack.addItem(view1).size(500).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 110, y: 5, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 160, y: 5, width: 220, height: 500), within: withinRange))
            }

            it("size + shrink") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).size(100)
                    stack.addItem(label2).size(50).shrink(1)
                    stack.addItem(view1).size(280).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 110, y: 5, width: 41, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 151, y: 5, width: 229, height: 280), within: withinRange))
            }
        }

        //
        // aspectRatio
        //
        describe("padding + aspectRatio column") {
            it("adjust") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 370, height: 370), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 560, width: 370, height: 444), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 370, height: 370), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 560, width: 21, height: 25), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 350, height: 175), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 200, width: 370, height: 370), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 590, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10).maxWidth(200).maxHeight(150)
                    stack.addItem(label2).aspectRatio(1).maxWidth(350).maxHeight(340)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //   - label1, with FlexLayout this label aspectRatio is not respected (200x150), StackViewLayout respect it (200x100)
                //   - view1, with FlexLayout the item size if 1x2!, StackLayoutView size is 83x100 which respect aspectRatio,
                //     maxWidth, maxHeight and the available space (shrink)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 125, width: 340, height: 340), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 485, width: 66.667, height: 80), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10).minWidth(320).minHeight(430)
                    stack.addItem(label2).aspectRatio(1).maxWidth(300)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout except:
                //   - label1, with FlexLayout this label overflow horizontally, StackViewLayout keep it inside but doesn't respect the aspectRatio)
                //   - label2, with FlexLayout this label aspectRatio is not respected (300x400), StackViewLayout respect it (300x300)
                //   - view1 are identical, except the y position
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 350, height: 430), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 455, width: 300, height: 300), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 775, width: 330, height: 396), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10).minWidth(420).minHeight(430)
                    stack.addItem(label2).aspectRatio(1).maxHeight(300)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 420, height: 430), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 455, width: 300, height: 300), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 775, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //    1- view1: FlexLayout size is too small (149x179) and leaves free space horizontally, where StackViewLayout don't
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 53.667, height: 27), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 5, width: 104, height: 104), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 207.667, y: 25, width: 152.333, height: 182.667), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(4)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 370, height: 92.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 282.667, width: 370, height: 92.667), within: withinRange))
            }

            it("row aspectRatio + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(5).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(6).maxWidth(50).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 216, height: 43.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 226, y: 5, width: 104, height: 26), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 330, y: 5, width: 50, height: 8.333), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).margin(20).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(4)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //  1- label1: the label overflow horizontally (cross-axis) with flexlayout, with StackLayout it don't.
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 30, y: 25, width: 330, height: 165), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 210, width: 370, height: 92.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 302.667, width: 370, height: 92.667), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1).shrink(1)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 179.667, height: 179.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 369.667, width: 179.333, height: 215.333), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1).shrink(1)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 174.667, y: 5, width: 40.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 185, y: 25.333, width: 20.333, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 186, y: 45.667, width: 18, height: 21.667), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 0, height: 0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 370), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 375, width: 370, height: 444), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 1019), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 370, height: 370), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 560, width: 370, height: 444), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.column).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(5)
                }

                stackView.pin.height(400).sizeToFit(.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 131.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 40.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 25.333, width: 101.667, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200)
                    stack.addItem(label2).aspectRatio(1).height(40)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //  1- view1: flexlayout layout size is 41.3x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 105, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 145, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).padding(5, 10, 15, 20).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200).margin(20)
                    stack.addItem(label2).aspectRatio(1).height(40).margin(20)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).margin(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //  1- view1: flexlayout layout size is 41.6x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 30, y: 25, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 165, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 245, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200).margin(20)
                    stack.addItem(label2).aspectRatio(1).height(40).margin(20)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).margin(20)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                //  1- view1: flexlayout layout size is 41.3x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 30, y: 25, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 165, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 245, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).minWidth(50)
                    stack.addItem(label2).aspectRatio(1).maxWidth(40)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                // 1- label2, flexlayout layout it with a size of 400x480?!, StackView size if 40x40 which respect the maxWidth
                //    of 40 and the aspectRatio of 1.
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 185), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 190, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 230, width: 370, height: 444), within: withinRange))
            }

            it("aspectRatio + minHeight/maxHeight") {
                stackView.direction(.column).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).minHeight(220)
                    stack.addItem(label2).aspectRatio(1).maxHeight(50)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout:
                // 1- label1 overflow in flexlayout but not using StackView
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 370, height: 220), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 225, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 275, width: 370, height: 444), within: withinRange))
            }
        }

        // row
        describe("aspectRatio row") {
            it("adjust") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4).shrink(1)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 5, width: 30, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 70, y: 5, width: 45, height: 180), within: withinRange))
            }

            it("adjust") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).margin(20)
                    stack.addItem(label2).aspectRatio(1 / 6).margin(20)
                    stack.addItem(view1).aspectRatio(1 / 4).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                //  - view1, flexlayout height is too small (25x100), StackView is right on (35x140)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 30, y: 25, width: 23.333, height: 140), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.333, y: 25, width: 23.333, height: 140), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 156.667, y: 25, width: 35, height: 140), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1 / 6).marginHorizontal(15)
                    stack.addItem(view1).aspectRatio(1 / 4).margin(20).shrink(1)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 15, width: 26.667, height: 160), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 71.667, y: 5, width: 30, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 136.667, y: 25, width: 35, height: 140), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4).shrink(1)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 5, width: 30, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 70, y: 5, width: 45, height: 180), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).margin(20)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 30, y: 25, width: 23.333, height: 140), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 73.333, y: 5, width: 30, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 103.333, y: 5, width: 45, height: 180), within: withinRange))
            }

            it("aspectRatio + grow + maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4).maxWidth(30)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 1738), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 286.333, height: 1718), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 350, y: 5, width: 30, height: 120), within: withinRange))
            }

            it("aspectRatio + alignItems(.center)") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                //  - label1, label2 and view1 overflow the container in flexlayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 8, width: 29, height: 174), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 69, y: 5, width: 45, height: 180), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                //  - label2 overflow its container in Flexlayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 121, width: 58, height: 348), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 121.667, y: 5, width: 145, height: 580), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 5, width: 30, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 70, y: 5, width: 350, height: 180), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 5, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 5, width: 350, height: 180), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1-label1: flexlayout don't stretch it vertically! (53x322)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 644), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 104, height: 624), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 114, y: 5, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 218, y: 5, width: 350, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 342), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 63.667, y: 5, width: 350, height: 322), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.end).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 342), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 327, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 63.667, y: 304, width: 350, height: 23), within: withinRange))
            }

            it("aspectRatio + alignItems center") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 342), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 166, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 63.667, y: 154.667, width: 350, height: 23), within: withinRange))
            }

            it("aspectRatio + justify center ") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.center).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(150).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 644), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 41.333, y: 156, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 95, y: 5, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 199, y: 290.333, width: 150, height: 53.333), within: withinRange))
            }

            it("aspectRatio + justify spaceAround ") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(150).shrink(1)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 644), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20.333, y: 5, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 94.667, y: 5, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 219.333, y: 5, width: 150, height: 53.333), within: withinRange))
            }

            it("aspectRatio + justify spaceEvenly ") {
                stackView.direction(.row).padding(5, 10, 15, 20).justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(150).shrink(1)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                //  -label1 using Flexlayout has a size of 53x322, it respect the aspectRatio but not the .stretch. StackLayout is right on
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 644), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 12, y: 5, width: 104, height: 624), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 120, y: 5, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 228, y: 5, width: 150, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).width(350).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                //  -label1 is smaller with Flexlayout
                //  -view1 is wider with Flexlayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 644), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 61, height: 366), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 71, y: 5, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 175, y: 5, width: 205, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).width(20)
                    stack.addItem(label2).aspectRatio(1 / 6).height(40)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).shrink(1)
                }

                stackView.pin.height(400).sizeToFit(.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 106.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 5, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 36.667, y: 5, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).width(20)
                    stack.addItem(label2).aspectRatio(1 / 6).height(40)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).shrink(1)
                }

                stackView.pin.width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 140), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 5, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 36.667, y: 5, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).width(20)
                    stack.addItem(label2).aspectRatio(1 / 6).height(40)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 30, y: 5, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 36.667, y: 5, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).minWidth(20)
                    stack.addItem(label2).aspectRatio(1).maxWidth(40)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 96.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 106.667, y: 5, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 146.667, y: 5, width: 233.333, height: 280), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.row).padding(5, 10, 15, 20).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).minWidth(20)
                    stack.addItem(label2).aspectRatio(1).maxWidth(40)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Don't Match FlexLayout
                // - label2 is little bit smaller on flexlayout
                // - view1 is little bit bigger on flexlayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 134, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 275, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 103.667, y: 129.333, width: 276.333, height: 331.667), within: withinRange))
            }

            it("aspectRatio + minHeight/maxHeight") {
                stackView.direction(.row).padding(5, 10, 15, 20).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).minHeight(20)
                    stack.addItem(label2).aspectRatio(1).maxHeight(40)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- label2, flexlayout size is 600x40, which respect maxHeight(40) but not aspectRatio(1)! StackView is right (40x40)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 5, width: 96.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 106.667, y: 5, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 146.667, y: 5, width: 233.333, height: 280), within: withinRange))
            }
        }
    }
}
