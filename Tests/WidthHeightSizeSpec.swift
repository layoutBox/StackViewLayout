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
                    label1.item.width(100).minWidth(120)
                    label2.item.width(100).maxWidth(80)
                    view1.item.width(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.width(100).minWidth(120)
                    label2.item.width(100).maxWidth(80)
                    view1.item.width(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100)
                    label2.item.height(20%)
                    view1.item.height(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100).minHeight(120)
                    label2.item.height(200).maxHeight(180)
                    view1.item.height(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100).grow(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100).shrink(1)
                    view1.item.shrink(1)
                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100)
                    label2.item.height(200)
                    view1.item.height(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.height(100).minHeight(120)
                    label2.item.height(200).maxHeight(180)
                    view1.item.height(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.size(100)
                    label2.item.size(50)
                    view1.item.size(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.size(100).minHeight(120)
                    label2.item.size(50).maxHeight(40)
                    view1.item.size(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.size(100).minWidth(120)
                    label2.item.size(50).maxWidth(40)
                    view1.item.size(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.size(100).minHeight(120)
                    label2.item.size(50).maxHeight(40)
                    view1.item.size(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
                    label1.item.size(100).minWidth(120)
                    label2.item.size(50).maxWidth(40)
                    view1.item.size(200)

                    stack.addItem(label1)
                    stack.addItem(label2)
                    stack.addItem(view1)
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
//            it("adjust") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).sizeToFit(.width)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 350), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 150, width: 200, height: 200), within: withinRange))
//            }
//
//            it("aspectRatio + margins") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).marginVertical(10).marginHorizontal(10)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2).margin(20).shrink(1)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).sizeToFit(.width)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 410), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 120, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 20, y: 190, width: 200, height: 200), within: withinRange))
//            }
//
//            it("aspectRatio + grow") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).grow(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 350), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 350, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 400, width: 200, height: 200), within: withinRange))
//            }

//            it("aspectRatio + shrink") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).shrink(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + sizeToFit(.width)") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).shrink(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).sizeToFit(.width)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + sizeToFit(.height)") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).shrink(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).height(400).sizeToFit(.height)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + width/height/size") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).width(20)
//                    label2.item.aspectRatio(4/2).height(40)
//                    view1.item.aspectRatio(1/2).size(50)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + minWidth/maxWidth") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).minWidth(20)
//                    label2.item.aspectRatio(4/2).maxWidth(40)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + minHeight/maxHeight") {
//                stackView.direction(.column).define { (stack) in
//                    label1.item.aspectRatio(2/3).minHeight(20)
//                    label2.item.aspectRatio(4/2).maxHeight(40)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
        }

        // row
        describe("aspectRatio row") {
//            it("adjust") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + margins") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).marginVertical(10).marginHorizontal(10)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2).margin(20)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 190, y: 20, width: 100, height: 100), within: withinRange))
//            }
//
//            it("aspectRatio + grow") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3)
//                    label2.item.aspectRatio(4/2).grow(1)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 150, y: 0, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + shrink") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3)
//                    label2.item.aspectRatio(4/2).shrink(1)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 100), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 100, y: 0, width: 20, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 120, y: 0, width: 280, height: 280), within: withinRange))
//            }
//
//            it("aspectRatio + sizeToFit(.width)") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).shrink(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).sizeToFit(.width)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + sizeToFit(.height)") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).shrink(1)
//                    label2.item.aspectRatio(4/2)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).height(400).sizeToFit(.height)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + width/height/size") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).width(20)
//                    label2.item.aspectRatio(4/2).height(40)
//                    view1.item.aspectRatio(1/2).size(50)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + minWidth/maxWidth") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).minWidth(20)
//                    label2.item.aspectRatio(4/2).maxWidth(40)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
//
//            it("aspectRatio + minHeight/maxHeight") {
//                stackView.direction(.row).define { (stack) in
//                    label1.item.aspectRatio(2/3).minHeight(20)
//                    label2.item.aspectRatio(4/2).maxHeight(40)
//                    view1.item.aspectRatio(1/2)
//
//                    stack.addItem(label1)
//                    stack.addItem(label2)
//                    stack.addItem(view1)
//                }
//
//                stackView.pin.top(64).width(400).height(600)
//                stackView.layoutIfNeeded()
//
//                // Match FlexLayout
//                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
//                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 100, height: 50), within: withinRange))
//                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50, width: 50, height: 50), within: withinRange))
//                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100, width: 500, height: 500), within: withinRange))
//            }
        }
    }
}
