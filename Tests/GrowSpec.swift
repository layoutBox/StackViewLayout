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

class GrowSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackLayoutView: StackLayoutView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTestDisplayScale(3)
        }

        beforeEach {
            Pin.lastWarningText = nil
            
            viewController = UIViewController()
            
            stackLayoutView = StackLayoutView()
            stackLayoutView.frame = CGRect(x: 0, y: 80, width: 400, height: 600)
            stackLayoutView.setNeedsLayout()
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
        describe("COLUMN: Grow") {
            it("1 item with grow") {
                stackLayoutView.define { (stack) in
                    label1.item.grow(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 559.667), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 559.667, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 580, width: 400, height: 20), within: 0.5))
            }
            
            it("1 item with grow") {
                stackLayoutView.define { (stack) in
                    label2.item.grow(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 559.667), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 580, width: 400, height: 20), within: 0.5))
            }
            
            it("2 items with grow") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 290), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 400, height: 290), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 580, width: 400, height: 20), within: 0.5))
            }
            
            it("3 items with grow") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(1)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200.333, width: 400, height: 200.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 400.667, width: 400, height: 200), within: 0.5))
            }
            
            it("3 items with grow") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 65.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 65.333, width: 400, height: 470), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 535.333, width: 400, height: 65), within: 0.5))
            }
            
            it("maxHeight") {
                stackLayoutView.define { (stack) in
                    label1.item.maxHeight(100)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
            }
        }
    }
}
