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
            stackLayoutView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
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
            
            it("grow + maxHeight") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).maxHeight(100)
                    label2.item.grow(10).maxHeight(120)
                    view1.item.grow(1).maxHeight(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()

                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 100), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 400, height: 120), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 220, width: 400, height: 140), within: 0.5))
            }
            
            it("The label1 should grow to takes the extra space.") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10).maxHeight(120)
                    view1.item.grow(1).maxHeight(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 340), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 340, width: 400, height: 120), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 460, width: 400, height: 140), within: 0.5))
            }
            
            it("grow + minHeight") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).minHeight(200)
                    label2.item.grow(2)
                    view1.item.grow(1).minHeight(220)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 240), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 240, width: 400, height: 100.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 340.333, width: 400, height: 260), within: 0.5))
            }
            
            it("grow + minHeight + overflow") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).minHeight(300)
                    label2.item.grow(2)
                    view1.item.grow(1).minHeight(320)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 300), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 300, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 320.333, width: 400, height: 320), within: 0.5))
            }
            
            it("grow + minHeight") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(2)
                    view1.item.grow(1).minHeight(220)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 105.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 105.333, width: 400, height: 190), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 295.333, width: 400, height: 305), within: 0.5))
            }
            
            it("should not apply grow since the stack will adjust its height") {
                stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).sizeToFit(.width)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 60.667), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 40.667, width: 400, height: 20), within: 0.5))
            }
        }
        
        //
        // ROW: Adjust the width based on a fixed height
        //
        describe("ROW: Grow") {
            it("1 item with grow") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.grow(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 282.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 282.667, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 386.667, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("1 item with grow") {
                stackLayoutView.direction(.row).define { (stack) in
                    label2.item.grow(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 333, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 386.667, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("2 items with grow") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 168.333, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 168.333, y: 0, width: 218.667, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 387, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("3 items with grow") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(1)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 130, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 130, y: 0, width: 180.333, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 310.333, y: 0, width: 89.667, height: 600), within: 0.5))
            }
            
            it("3 items with grow") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 73, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 73, y: 0, width: 295, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 368, y: 0, width: 32.667, height: 600), within: 0.5))
            }
            
            it("grow + maxWidth") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).maxWidth(100)
                    label2.item.grow(10).maxWidth(120)
                    view1.item.grow(1).maxWidth(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 120, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 220, y: 0, width: 140, height: 600), within: 0.5))
            }
            
            it("The label1 should grow to takes the extra space.") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10).maxWidth(120)
                    view1.item.grow(1).maxWidth(140)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 160.333, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 160.333, y: 0, width: 120, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 280.333, y: 0, width: 120, height: 600), within: 0.5))
            }
            
            it("grow + minWidth") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).minWidth(150)
                    label2.item.grow(2)
                    view1.item.grow(1).minWidth(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 161.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 161.667, y: 0, width: 127, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 288.667, y: 0, width: 111.667, height: 600), within: 0.5))
            }
            
            it("grow + minWidth + overflow") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1).minWidth(200)
                    label2.item.grow(2)
                    view1.item.grow(1).minWidth(220)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.width(400).height(600)
                stackLayoutView.layoutIfNeeded()
             
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 200, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 304, y: 0, width: 220, height: 600), within: 0.5))
            }
            
            it("should not apply grow since the stack will adjust its height") {
                stackLayoutView.direction(.row).justifyContent(.start).alignItems(.stretch).define { (stack) in
                    label1.item.grow(1)
                    label2.item.grow(10)
                    view1.item.grow(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.height(200).sizeToFit(.height)
                
                expect(stackLayoutView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 197.667, height: 200), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 200), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 200), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 40, height: 200), within: 0.5))
            }
        }
    }
}
