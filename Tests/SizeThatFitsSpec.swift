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

class SizeThatFitsSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackLayoutView: StackView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTestDisplayScale(3)
        }

        beforeEach {
            viewController = UIViewController()
            
            stackLayoutView = StackView()
            stackLayoutView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
            viewController.view.addSubview(stackLayoutView)

            label1 = UILabel()
            label1.font = UIFont.systemFont(ofSize: 17)
            label1.backgroundColor = .red
            label1.text = "Label 1"
            
            label2 = UILabel()
            label2.font = UIFont.systemFont(ofSize: 17)
            label2.backgroundColor = .green
            label2.text = "Label longuer"
            
            view1 = BasicView(text: "View 1", color: .red)
            view1.sizeThatFitsExpectedArea = 400 * 20
        }
        
        //
        // COLUMN: Adjust the height based on a fixed width
        //
        describe("COLUMN: Adjust height") {
            it("default") {
                stackLayoutView.define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
            
            it("using sizeThatFits") {
                stackLayoutView.define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                let size = stackLayoutView.sizeThatFits(CGSize(width: 400, height: CGFloat.greatestFiniteMagnitude))
                stackLayoutView.frame = CGRect(origin: CGPoint(x: 0, y: 64), size: size)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.stretch)") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.marginStart(10)
                    label2.item.marginStart(25%)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 390, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 20.333, width: 300, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.stretch)") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define{ (stack) in
                    label1.item.marginEnd(10)
                    label2.item.marginEnd(25%)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 390, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 300, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.stretch)") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 370, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.stretch)") {
                stackLayoutView.define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.start)") {
                stackLayoutView.justifyContent(.start).alignItems(.start).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.center)") {
                stackLayoutView.justifyContent(.start).alignItems(.center).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                
                // Match FlexLayout
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.333, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start).alignItems(.end)") {
                stackLayoutView.justifyContent(.start).alignItems(.end).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.center).alignItems(.start)") {
                stackLayoutView.justifyContent(.center).alignItems(.start).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.spaceBetween).alignItems(.start)") {
                stackLayoutView.justifyContent(.spaceBetween).alignItems(.start).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.spaceAround).alignItems(.center)") {
                stackLayoutView.justifyContent(.spaceAround).alignItems(.center).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                // Match FlexLayout
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.333, y: 40, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148, y: 80.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.center).alignItems(.stretch)") {
                stackLayoutView.justifyContent(.center).alignItems(.stretch).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.end).alignItems(.stretch)") {
                stackLayoutView.justifyContent(.end).alignItems(.stretch).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.spaceAround).alignItems(.stretch)") {
                stackLayoutView.justifyContent(.spaceAround).alignItems(.stretch).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.spaceBetween).alignItems(.stretch)") {
                stackLayoutView.justifyContent(.spaceBetween).alignItems(.stretch).define { (stack) in
                    label1.item.marginTop(40).marginBottom(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginTop(30).marginBottom(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 40, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 80.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.spaceEvenly).alignItems(.stretch)") {
                stackLayoutView.direction(.column).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: withinRange))
            }
        }
        
        //
        // COLUMN: Adjust the width based on a fixed height (weird case)
        //
        describe("COLUMN: Adjust width") {
            it("default") {
                stackLayoutView.define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(400).sizeToFit(.height)
                stackLayoutView.layout()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 104, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 104, height: 77), within: withinRange))
            }
        }
        
        
        //
        // ROW: Adjust the width based on the height
        //
        describe("rows + horizontal margins") {
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.start).define { (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(400).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 307.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 20, height: 400), within: withinRange))
            }
            
            it("justifyContent(.start) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row).justifyContent(.end).alignItems(.end).define { (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(400).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 307.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 379.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 379.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 20, height: 400), within: withinRange))
            }
            
            it("justifyContent(.end) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row).justifyContent(.end).alignItems(.stretch).define { (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(400).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 307.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 400), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 20, height: 400), within: withinRange))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(400).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 307.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 400), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 20, height: 400), within: withinRange))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row).justifyContent(.center).alignItems(.stretch).define { (stack) in
                    label1.item.marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
            
                stackLayoutView.pin.height(400).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 257.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 400), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 0, width: 104, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 237.667, y: 0, width: 20, height: 400), within: withinRange))
            }
        }
        
        //
        // ROW: Adjust the height based on a width (weird case)
        //
        describe("ROW: Adjust width") {
            it("default") {
                stackLayoutView.direction(.row).define { (stack) in
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                stackLayoutView.layout()
                
                // Match FlexLayout
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 20.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
    }
}
