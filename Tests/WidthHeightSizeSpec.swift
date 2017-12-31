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

class WidthHeightSizeSpec: QuickSpec {
    override func spec() {
        let withinRange: CGFloat = 0.001
        var viewController: UIViewController!
        
        var stackLayoutView: StackLayoutView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTestDisplayScale(3)
        }

        beforeEach {
            viewController = UIViewController()
            
            stackLayoutView = StackLayoutView()
            stackLayoutView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
            viewController.view.addSubview(stackLayoutView)

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
        // WIDTH
        //
        describe("Width column") {
            it("adjust") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + margins") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + grow") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + shrink") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        describe("Width row") {
            it("adjust") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + margins") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + grow") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("width + shrink") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        
        //
        // HEIGHT
        //
        describe("height column") {
            it("adjust") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.height(100)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + margins") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.height(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + grow") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.height(100).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + shrink") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.height(100).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        describe("height row") {
            it("adjust") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.height(100)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + margins") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.height(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + grow") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.height(100).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + shrink") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.height(100).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        
        //
        // WIDTH + HEIGHT
        //
        describe("width + height column") {
            it("adjust") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).height(40)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + margins") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).height(40).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + grow") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).height(40).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + shrink") {
                stackLayoutView.direction(.column).define { (stack) in
                    label1.item.width(100).height(40).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        describe("height row") {
            it("adjust") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).height(40)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(40).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + margins") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).height(40).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + grow") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).height(40).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
            
            it("height + shrink") {
                stackLayoutView.direction(.row).define { (stack) in
                    label1.item.width(100).height(40).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackLayoutView.pin.top(64).width(400).sizeToFit(.width)
                stackLayoutView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        //
        // SIZE
        //
        describe("SIZE column") {
            it("adjust") {
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
        
        describe("SIZE row") {
            it("adjust") {
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 400, height: 20.333), within: withinRange))
            }
        }
    }
}
