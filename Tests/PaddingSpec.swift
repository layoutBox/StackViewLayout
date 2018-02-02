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
            _setUnitTestDisplayScale(3)
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
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 261.667, width: 330, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282, width: 330, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.333, width: 310, height: 25.667), within: withinRange))
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
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 261.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.333, width: 310, height: 25.667), within: withinRange))
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
                expect(label1.frame).to(beCloseTo(CGRect(x: 158.333, y: 261.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 133, y: 282, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.333, width: 310, height: 25.667), within: withinRange))

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
                expect(label1.frame).to(beCloseTo(CGRect(x: 296.333, y: 261.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 282, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 302.333, width: 310, height: 25.667), within: withinRange))
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
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 282, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 559, width: 310, height: 25.667), within: withinRange))
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

        // + Aspect ratio
    }
}
