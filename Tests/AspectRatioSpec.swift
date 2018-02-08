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

class AspectRatioSpec: QuickSpec {
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

            // label1 is single line
            label1 = UILabel()
            label1.font = UIFont.systemFont(ofSize: 17)
            label1.backgroundColor = .red
            label1.numberOfLines = 1

            // label1 is multi line
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
        // WIDTH
        //
        describe("Width column") {
            it("adjust") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100)
                    label2.item.width(20%)
                    view1.item.width(200)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 61, width: 200, height: 40), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).width(100).minWidth(120)
                    stack.addItem(label2).width(100).maxWidth(80)
                    stack.addItem(view1).width(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 120, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 61, width: 200, height: 40), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 40.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 131, width: 200, height: 40), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 140, y: 20, width: 80, height: 60), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 240, y: 30, width: 200, height: 40), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30).marginHorizontal(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 40.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 131, width: 200, height: 40), within: withinRange))
            }
                
            it("width + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30).marginHorizontal(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 201), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 40.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 131, width: 200, height: 40), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30).marginHorizontal(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).height(200).sizeToFit(.height)
                stackView.layoutIfNeeded()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 240, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 40.333, width: 48, height: 61), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 151.333, width: 200, height: 40), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30).marginHorizontal(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).height(200).sizeToFit(.height)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout (except label2 which FlexLayout is little smaller)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 504, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 140, y: 20, width: 100.667, height: 160), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 280.667, y: 30, width: 200, height: 140), within: withinRange))
            }
            
            it("width + grow") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100).grow(1)
                    label2.item.width(20%)
                    view1.item.width(50)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 399.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 399.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 440, width: 50, height: 160), within: withinRange))
            }
            
            it("width + shrink") {
                stackView.direction(.column).define { (stack) in
                    label1.item.width(100)
                    label2.item.width(20%)
                    view1.item.width(200).shrink(1)
                  
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(80)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 80), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 61, width: 200, height: 19), within: withinRange))
            }
        }
        
        describe("Width row") {
            it("adjust") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100)
                    label2.item.width(20%)
                    view1.item.width(200)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(80)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 80), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 80), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 80, height: 80), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 180, y: 0, width: 200, height: 80), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).width(100).minWidth(120)
                    stack.addItem(label2).width(100).maxWidth(80)
                    stack.addItem(view1).width(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 120, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 80, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 200, y: 0, width: 200, height: 600), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 140, y: 20, width: 80, height: 560), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 240, y: 30, width: 200, height: 540), within: withinRange))
            }
            
            it("width + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100).marginHorizontal(10)
                    label2.item.width(20%).margin(20)
                    view1.item.width(200).marginVertical(30)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 140, y: 20, width: 80, height: 60), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 240, y: 30, width: 200, height: 40), within: withinRange))
            }
            
            it("width + grow") {
                stackView.direction(.row).define { (stack) in
                    label1.item.width(100).grow(1)
                    label2.item.width(20%)
                    view1.item.width(50)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 160), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 270, height: 160), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 270, y: 0, width: 80, height: 160), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 350, y: 0, width: 50, height: 160), within: withinRange))
            }
            
            it("width + shrink") {
                stackView.direction(.row).define { (stack) in
                    label1.item.shrink(1)
                    label2.item.width(20%)
                    view1.item.width(350).shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 40.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 42.667, height: 40.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 42.667, y: 0, width: 80, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 122.667, y: 0, width: 277.333, height: 40.667), within: withinRange))
            }
        }
        
        
        //
        // HEIGHT
        //
        describe("height column") {
            it("adjust") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).height(100)
                    stack.addItem(label2).height(20%)
                    stack.addItem(view1).height(200)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout (except height(20%))
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 320.333), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 400, height: 64), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 164, width: 400, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).height(100).minHeight(120)
                    stack.addItem(label2).height(200).maxHeight(180)
                    stack.addItem(view1).height(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 400, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 300, width: 400, height: 200), within: withinRange))
            }
            
            it("height + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.height(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1).marginVertical(20).marginHorizontal(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 202.667), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 380, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 160.333, width: 360, height: 22.333), within: withinRange))
            }
            
            it("height + grow") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).height(100).grow(1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 559.667), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 559.667, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 580, width: 400, height: 20), within: withinRange))
            }
            
            it("height + shrink") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).height(100).shrink(1)
                    stack.addItem(label2)
                    stack.addItem(view1).shrink(1)
                }
                
                stackView.pin.top(64).width(400).height(100)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 66.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 66.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 86.667, width: 400, height: 13.333), within: withinRange))
            }
        }
        
        describe("height row") {
            it("adjust") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).height(100)
                    stack.addItem(label2).height(200)
                    stack.addItem(view1).height(200)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout (except view1, flexlayout doesn't respect the view1.sizeThatFits using
                // using the height of 200)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 40, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).height(100).minHeight(120)
                    stack.addItem(label2).height(200).maxHeight(180)
                    stack.addItem(view1).height(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout (except view1, flexlayout doesn't respect the view1.sizeThatFits using
                // using the height of 200)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 180), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 40, height: 200), within: withinRange))
            }
            
            it("height + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.height(100).marginVertical(10).marginHorizontal(10)
                    view1.item.shrink(1).marginVertical(10).marginHorizontal(10)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 120), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 53.667, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 73.667, y: 0, width: 104, height: 120), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 187.667, y: 10, width: 202.333, height: 100), within: withinRange))
            }
            
            it("height + grow") {
                stackView.direction(.row).define { (stack) in
                    label1.item.height(100).grow(1)
                    view1.item.width(100)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 196, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196, y: 0, width: 104, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 300, y: 0, width: 100, height: 100), within: withinRange))
            }
            
            it("height + shrink") {
                stackView.direction(.row).define { (stack) in
                    label1.item.height(100).shrink(1)
                    view1.item.width(250)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 100), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 46, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 46, y: 0, width: 104, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 250, height: 100), within: withinRange))
            }
        }
        
        
        //
        // SIZE
        //
        describe("size column") {
            it("adjust") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).size(100)
                    stack.addItem(label2).size(50)
                    stack.addItem(view1).size(200)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 350), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 150, width: 200, height: 200), within: withinRange))
            }

            it("minHeight + maxHeight") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).size(100).minHeight(120)
                    stack.addItem(label2).size(50).maxHeight(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 50, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 160, width: 200, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).size(100).minWidth(120)
                    stack.addItem(label2).size(50).maxWidth(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 120, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 40, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 150, width: 200, height: 200), within: withinRange))
            }
            
            it("size + margins") {
                stackView.direction(.column).define { (stack) in
                    label1.item.size(100).marginVertical(10).marginHorizontal(10)
                    label2.item.size(50)
                    view1.item.size(200).margin(20).shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 410), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 190, width: 200, height: 200), within: withinRange))
            }
            
            it("size + grow") {
                stackView.direction(.column).define { (stack) in
                    label1.item.size(100).grow(1)
                    label2.item.size(50)
                    view1.item.size(200)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 350), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 350, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 400, width: 200, height: 200), within: withinRange))
            }
            
            it("size + shrink") {
                stackView.direction(.column).define { (stack) in
                    label1.item.size(100).shrink(1)
                    label2.item.size(50)
                    view1.item.size(500)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
            }
        }
        
        describe("size row") {
            it("adjust") {
                stackView.direction(.row).define { (stack) in
                    label1.item.size(100)
                    label2.item.size(50)
                    view1.item.size(500)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 500, height: 500), within: withinRange))
            }

            it("minHeight + maxHeight") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).size(100).minHeight(120)
                    stack.addItem(label2).size(50).maxHeight(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 200, height: 200), within: withinRange))
            }

            it("minWidth + maxWidth") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).size(100).minWidth(120)
                    stack.addItem(label2).size(50).maxWidth(40)
                    stack.addItem(view1).size(200)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 120, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 40, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 160, y: 0, width: 200, height: 200), within: withinRange))
            }

            it("size + margins") {
                stackView.direction(.row).define { (stack) in
                    label1.item.size(100).marginVertical(10).marginHorizontal(10)
                    label2.item.size(50)
                    view1.item.size(100).margin(20)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 190, y: 20, width: 100, height: 100), within: withinRange))
            }
            
            it("size + grow") {
                stackView.direction(.row).define { (stack) in
                    label1.item.size(100)
                    label2.item.size(50).grow(1)
                    view1.item.size(500)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 500, height: 500), within: withinRange))
            }
            
            it("size + shrink") {
                stackView.direction(.row).define { (stack) in
                    label1.item.size(100)
                    label2.item.size(50).shrink(1)
                    view1.item.size(280)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }
                
                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 20, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 280, height: 280), within: withinRange))
            }
        }


        //
        // aspectRatio
        //
        describe("aspectRatio column") {
            it("adjust") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 400, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 600, width: 400, height: 480), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 400, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 600, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 380, height: 190), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 210, width: 400, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 630, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10).maxWidth(200).maxHeight(150)
                    stack.addItem(label2).aspectRatio(1).maxWidth(350).maxHeight(340)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //   - label1, with FlexLayout this label aspectRatio is not respected (200x150), StackViewLayout respect it (200x100)
                //   - view1, with FlexLayout the item size if 1x2!, StackLayoutView size is 83x100 which respect aspectRatio,
                //     maxWidth, maxHeight and the available space (shrink)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 340, height: 340), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 480, width: 83.333, height: 100), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).define { (stack) in
                    label1.item.aspectRatio(2).marginVertical(10).marginHorizontal(10).minWidth(420).minHeight(430)
                    label2.item.aspectRatio(1).maxWidth(300)
                    view1.item.aspectRatio(5 / 6).margin(20).shrink(1)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout except:
                //   - label1, with FlexLayout this label overflow horizontally, StackViewLayout keep it inside but doesn't respect the aspectRatio)
                //   - label2, with FlexLayout this label aspectRatio is not respected (300x400), StackViewLayout respect it (300x300)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 420, height: 430), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 450, width: 300, height: 300), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 770, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins + min max") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10).minWidth(420).minHeight(430)
                    stack.addItem(label2).aspectRatio(1).maxHeight(300)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 420, height: 430), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 450, width: 300, height: 300), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 770, width: 0, height: 0), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.row).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6).margin(20).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //    1- view1: FlexLayout size is too small (149x179) and leaves free space horizontally, where StackViewLayout don't
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 53.667, height: 27), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 73.667, y: 0, width: 104, height: 104), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 197.667, y: 20, width: 182.333, height: 218.667), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(4)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 400, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 300, width: 400, height: 100), within: withinRange))
            }

            it("row aspectRatio + grow") {
                stackView.direction(.row).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(5).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(6).maxWidth(50).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 246, height: 49.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 246, y: 0, width: 104, height: 26), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 350, y: 0, width: 50, height: 8.333), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).margin(20).grow(1)
                    stack.addItem(label2).aspectRatio(4)
                    stack.addItem(view1).aspectRatio(4)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- label1: the label overflow horizontally (cross-axis) with flexlayout, with StackLayout it don't.
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 20, width: 360, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 220, width: 400, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 320, width: 400, height: 100), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2)
                    stack.addItem(label2).aspectRatio(1).shrink(1)
                    stack.addItem(view1).aspectRatio(5 / 6).shrink(1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 181.667, height: 181.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 381.667, width: 181.667, height: 218.333), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).alignItems(.center).define { (stack) in
                    label1.item.aspectRatio(2)
                    label2.item.aspectRatio(1).shrink(1)
                    view1.item.aspectRatio(5 / 6).shrink(1)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 179.667, y: 0, width: 40.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 190, y: 20.333, width: 20.333, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 191.667, y: 40.667, width: 16.667, height: 20), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 400, width: 400, height: 480), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(1)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 1080), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 400, height: 400), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 600, width: 400, height: 480), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.column).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).shrink(1)
                    stack.addItem(label2).aspectRatio(5)
                }

                stackView.pin.top(64).height(400).sizeToFit(.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 101.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 40.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 20.333, width: 101.667, height: 20.333), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200)
                    stack.addItem(label2).aspectRatio(1).height(40)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- view1: flexlayout layout size is 41.3x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).alignItems(.stretch).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200).margin(20)
                    stack.addItem(label2).aspectRatio(1).height(40).margin(20)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).margin(20)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- view1: flexlayout layout size is 41.6x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 20, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 160, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 240, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.column).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).width(200).margin(20)
                    stack.addItem(label2).aspectRatio(1).height(40).margin(20)
                    stack.addItem(view1).aspectRatio(5 / 6).size(50).margin(20)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- view1: flexlayout layout size is 41.3x50, and StackViewLayout is 50x50
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 20, width: 200, height: 100), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 160, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 240, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).minWidth(50)
                    stack.addItem(label2).aspectRatio(1).maxWidth(40)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                // 1- label2, flexlayout layout it with a size of 400x480?!, StackView size if 40x40 which respect the maxWidth
                //    of 40 and the aspectRatio of 1.
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 200, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 240, width: 400, height: 480), within: withinRange))
            }

            it("aspectRatio + minHeight/maxHeight") {
                stackView.direction(.column).define { (stack) in
                    stack.addItem(label1).aspectRatio(2).minHeight(220)
                    stack.addItem(label2).aspectRatio(1).maxHeight(50)
                    stack.addItem(view1).aspectRatio(5 / 6)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                // 1- label1 overflow in flexlayout but not using StackView
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 400, height: 220), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 220, width: 50, height: 50), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 270, width: 400, height: 480), within: withinRange))
            }
        }

        // row
        describe("aspectRatio row") {
            it("adjust") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 33.333, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 66.667, y: 0, width: 50, height: 200), within: withinRange))
            }

            it("adjust") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).margin(20)
                    stack.addItem(label2).aspectRatio(1 / 6).margin(20)
                    stack.addItem(view1).aspectRatio(1 / 4).margin(20)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 20, width: 26.667, height: 160), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 86.667, y: 20, width: 26.667, height: 160), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 153.333, y: 20, width: 40, height: 160), within: withinRange))
            }

            it("aspectRatio + margins") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).marginVertical(10).marginHorizontal(10)
                    stack.addItem(label2).aspectRatio(1 / 6).marginHorizontal(15)
                    stack.addItem(view1).aspectRatio(1 / 4).margin(20)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 30, height: 180), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 65, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 133.333, y: 20, width: 40, height: 160), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 33.333, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 66.667, y: 0, width: 50, height: 200), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6).margin(20)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 20, width: 26.667, height: 160), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 66.667, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 200), within: withinRange))
            }

            it("aspectRatio + grow + maxWidth") {
                stackView.direction(.row).alignItems(.start).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).grow(1)
                    stack.addItem(view1).aspectRatio(1 / 4).maxWidth(30)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 1898), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 316.333, height: 1898), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 370, y: 0, width: 30, height: 120), within: withinRange))
            }

            it("aspectRatio + alignItems(.center)") {
                stackView.direction(.row).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 33.333, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 66.667, y: 0, width: 50, height: 200), within: withinRange))
            }

            it("aspectRatio + grow") {
                stackView.direction(.row).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).aspectRatio(1 / 4)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- label2, flexlayout layout is much bigger (104x624). StackView don't overflow its container
                //  2- view1, flexlayout layout is much bigger (400x1600). StackView don't overflow its container
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 139, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 126, width: 58, height: 348), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 111.667, y: 0, width: 150, height: 600), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 33.333, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 66.667, y: 0, width: 350, height: 200), within: withinRange))
            }

            it("aspectRatio + shrink") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(350)
                    
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(200)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 33.333, height: 200), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 33.333, y: 0, width: 16.667, height: 100), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 50, y: 0, width: 350, height: 200), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1-label1: flexlayout don't stretch it vertically! (53x322)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 624), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 104, height: 624), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 208, y: 0, width: 350, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 322), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 350, height: 322), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.width)") {
                stackView.direction(.row).alignItems(.end).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 322), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 322, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 53.667, y: 299, width: 350, height: 23), within: withinRange))
            }

            it("aspectRatio + alignItems center") {
                stackView.direction(.row).alignItems(.center).define { (stack) in
                    stack.addItem(label1).aspectRatio(1 / 6)
                    stack.addItem(label2).aspectRatio(1 / 6).shrink(1)
                    stack.addItem(view1).width(350)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 322), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 161, width: 0, height: 0), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 53.667, y: 149.667, width: 350, height: 23), within: withinRange))
            }

            it("aspectRatio + justify center ") {
                stackView.direction(.row).justifyContent(.center).alignItems(.center).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(150)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 624), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 46.333, y: 151, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 204, y: 285.333, width: 150, height: 53.333), within: withinRange))
            }

            it("aspectRatio + justify spaceAround ") {
                stackView.direction(.row).justifyContent(.spaceAround).alignItems(.start).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(150)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 624), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.333, y: 0, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.667, y: 0, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 234.333, y: 0, width: 150, height: 53.333), within: withinRange))
            }

            it("aspectRatio + justify spaceEvenly ") {
                stackView.direction(.row).justifyContent(.spaceEvenly).alignItems(.stretch).define { (stack) in
                    label1.item.aspectRatio(1 / 6)
                    label2.item.aspectRatio(1 / 6).shrink(1)
                    view1.item.width(150)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 624), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.667, y: 0, width: 104, height: 624), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 125.333, y: 0, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 240, y: 0, width: 150, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).shrink(1)
                    label2.item.aspectRatio(1 / 6)
                    view1.item.width(350)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 624), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 0, height: 0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 104, height: 624), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 104, y: 0, width: 350, height: 624), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).width(20)
                    label2.item.aspectRatio(1 / 6).height(40)
                    view1.item.aspectRatio(5 / 6).size(50)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).height(400).sizeToFit(.height)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 76.667, height: 400), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 0, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 26.667, y: 0, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + sizeToFit(.height)") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).width(20)
                    label2.item.aspectRatio(1 / 6).height(40)
                    view1.item.aspectRatio(5 / 6).size(50)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).sizeToFit(.width)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 120), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 0, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 26.667, y: 0, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + width/height/size") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).width(20)
                    label2.item.aspectRatio(1 / 6).height(40)
                    view1.item.aspectRatio(5 / 6).size(50)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 20, height: 120), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 0, width: 6.667, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 26.667, y: 0, width: 50, height: 60), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).minWidth(20)
                    label2.item.aspectRatio(1).maxWidth(40)
                    view1.item.aspectRatio(5 / 6)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 140, y: 0, width: 500, height: 600), within: withinRange))
            }

            it("aspectRatio + minWidth/maxWidth") {
                stackView.direction(.row).alignItems(.center).define { (stack) in
                    label1.item.aspectRatio(1 / 6).minWidth(20)
                    label2.item.aspectRatio(1).maxWidth(40)
                    view1.item.aspectRatio(5 / 6)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 139, width: 53.667, height: 322), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 280, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 93.667, y: 60, width: 400, height: 480), within: withinRange))
            }

            it("aspectRatio + minHeight/maxHeight") {
                stackView.direction(.row).define { (stack) in
                    label1.item.aspectRatio(1 / 6).minHeight(20)
                    label2.item.aspectRatio(1).maxHeight(40)
                    view1.item.aspectRatio(5 / 6)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
                }

                stackView.pin.top(64).width(400).height(600)
                stackView.layoutIfNeeded()

                // Match FlexLayout, except:
                //  1- label2, flexlayout size is 600x40, which respect maxHeight(40) but not aspectRatio(1)! StackView is right (40x40)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 40, height: 40), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 140, y: 0, width: 500, height: 600), within: withinRange))
            }
        }
    }
}
