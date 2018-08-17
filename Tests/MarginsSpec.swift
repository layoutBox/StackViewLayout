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

class MarginsSpec: QuickSpec {
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
            
            stackView.addItem(label1)
            stackView.addItem(label2)
            stackView.addItem(view1)
        }
        
        //
        // 1. colums + horizontal margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginLeft()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stackView) in
                    label1.item.marginLeft(10)
                    label2.item.marginLeft(25%)
                })
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.333, width: 300.0, height: 20.333), within: withinRange))
            }
            
            it("marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.stretch)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.333, width: 300.0, height: 20.333), within: withinRange))
            }
            
            it("marginStart()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stackView) in
                    label1.item.marginStart(10)
                    label2.item.marginStart(25%)
                })

                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.333, width: 300.0, height: 20.333), within: withinRange))
            }
            
            it("marginEnd()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.stretch)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.333, width: 300.0, height: 20.333), within: withinRange))
            }
            
            it("marginLeft() + marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 370.0, height: 20.333), within: withinRange))
            }
        }
        
        //
        // 2. colums + horizontal margins + alignItems(.start)
        //
        describe("margins") {
            it("marginLeft()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
            }
            
            it("marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
            }
            
            it("marginStart()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
            }
            
            it("marginEnd()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
            }
            
            it("marginLeft() + marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
            }
        }
        
        //
        // 3. colums + horizontal margins + alignItems(.center)
        //
        describe("margins") {
            it("marginLeft()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(20)
                view1.item.marginLeft(30)
                
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 178.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 158, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 40.667, width: 370, height: 21.667), within: withinRange))
            }
            
            it("marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 98.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginStart()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 178.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 198.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginEnd()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 98.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginLeft() + marginRight())") {
                stackView.direction(.column).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10%).marginRight(50%)
                    view1.item.marginLeft(10)
                })
            
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 68, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 40.667, width: 390, height: 20.667), within: withinRange))
            }
            
            it("marginLeft() + marginRight())") {
                stackView.direction(.column).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10%).marginRight(50%)
                    view1.item.marginLeft(10).marginRight(200)
                })
            
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 68, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 40.667, width: 190, height: 42), within: withinRange))
            }
        }
        
        //
        // 4. colums + horizontal margins + alignItems(.end)
        //
        describe("colums + horizontal margins") {
            it("marginLeft()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginLeft(10)
                    label2.item.marginLeft(25%)
                    view1.item.marginLeft(100)
                })
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 100, y: 40.667, width: 300, height: 26.667), within: withinRange))
            }
            
            it("marginRight()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.end)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginStart()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.end)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginEnd()") {
                stackView.direction(.column)
                stackView.justifyContent(.start)
                stackView.alignItems(.end)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.333, width: 104.0, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.667, width: 280.0, height: 28.667), within: withinRange))
            }
            
            it("marginLeft() + marginRight()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(200)
                    view1.item.marginLeft(10).marginRight(200)
                })
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 146.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296, y: 20.333, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 40.667, width: 190, height: 42), within: withinRange))
            }
            
            it("should reduce the width of items due to large margins") {
                stackView.direction(.column).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(340)
                    label2.item.marginLeft(10%).marginRight(75%)
                    view1.item.marginLeft(10).marginRight(200)
                })
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 50, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40, y: 20.333, width: 58, height: 40.667), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10, y: 61, width: 190, height: 42), within: withinRange))
            }
        }
        
        //
        // 5. colums + vertical margins + alignItems
        //
        describe("colums + vertical margins") {
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(20)
                    label2.item.marginTop(10).marginBottom(20)
                    view1.item.marginTop(30).marginBottom(40)
                })
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 60.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 130.667, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackView.direction(.column)
                stackView.justifyContent(.end)
                stackView.alignItems(.end)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackView.layout()
                
                // Match FlexLayout
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333, y: 419.333, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296, y: 469.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 540, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.end) + marginTop() + marginBottom()") {
                stackView.direction(.column)
                stackView.justifyContent(.end)
                stackView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackView.layout()
                
                // Match FlexLayout
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 419.333, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 469.667, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 540, width: 400, height: 20), within: withinRange))
            }
            
            it("justifyContent(.center) + marginTop() + marginBottom()") {
                stackView.direction(.column)
                stackView.justifyContent(.center)
                stackView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackView.layout()
                
                // Match FlexLayout
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 214.667, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 265, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 335.333, width: 400, height: 20), within: withinRange))
            }
        }
        
        //
        // 1.1 row + vertical margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginTop()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginTop(10)
                    label2.item.marginTop(25%)
                    view1.item.marginTop(50%)
                })
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 590), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 150, width: 104, height: 450), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 300, width: 400, height: 300), within: withinRange))
            }
            
            it("marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginBottom(10)
                    label2.item.marginBottom(25%)
                    view1.item.marginBottom(50%).shrink(1)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 590), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 450), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 242.333, height: 300), within: withinRange))
            }
            
            it("marginTop() + marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(20)
                    label2.item.marginTop(10%).marginBottom(20%)
                    view1.item.marginTop(20%).marginBottom(10%).shrink(1)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 570), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 60, width: 104, height: 420), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 120, width: 242.333, height: 420), within: withinRange))
            }
        }
        
        //
        // 2.1 rows + vertical margins + alignItems(.start)
        //
        describe("margins") {
            it("marginTop()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginTop(10)
                    label2.item.marginTop(10%)
                    view1.item.marginTop(20%)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 60, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 120, width: 400, height: 20), within: withinRange))
            }
            
            it("marginTop()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginTop(10)
                    label2.item.marginTop(10%)
                    view1.item.marginTop(20%).shrink(1)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 60, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 120, width: 242.333, height: 33), within: withinRange))
            }
            
            it("marginBottom() + The label2 height will reduces to respect its margins!") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(20)
                    label2.item.marginTop(40).marginBottom(40)
                    view1.item.marginTop(20%).marginBottom(10%).shrink(1)
                })
                
                stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 90)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 90), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 40, width: 104, height: 10), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 18, width: 242.333, height: 33), within: withinRange))
            }
            
            it("marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginBottom(10)
                    label2.item.marginBottom(10%)
                    view1.item.marginBottom(20%).shrink(1)
                })
                stackView.pin.top(64).width(400).height(200)
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 200), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 0, width: 242.333, height: 33), within: withinRange))
            }
            
            it("marginTop() + marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(20)
                    label2.item.marginTop(10%).marginBottom(20%)
                    view1.item.marginTop(20%).marginBottom(10%).shrink(1)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 60, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 120, width: 242.333, height: 33), within: withinRange))
            }
        }
        
        //
        // 3.1 rows + vertical margins + alignItems(.center)
        //
        describe("margins") {
            it("marginTop()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label1.item.marginTop(10)
                    label2.item.marginTop(20)
                    view1.item.marginTop(30)
                })
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 295, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 300, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 305, width: 400, height: 20), within: withinRange))
            }
            
            it("marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    label1.item.marginBottom(10)
                    label2.item.marginBottom(25%)
                    view1.item.marginTop(20).marginBottom(100)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 285, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 215, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 250, width: 400, height: 20), within: withinRange))
            }
            
            it("marginTop() + marginBottom())") {
                stackView.direction(.row).justifyContent(.start).alignItems(.center).define({ (stack) in
                    // top margin cancel the bottom margin if they have the same value
                    label1.item.marginTop(10).marginBottom(10)
                    label2.item.marginTop(20).marginBottom(20)
                    view1.item.marginTop(30).marginBottom(30)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 400, height: 20), within: withinRange))
            }
            
            it("marginTop() + marginBottom())") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(340)
                    label2.item.marginTop(10%)
                    view1.item.marginTop(10).marginBottom(200)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 60, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 10, width: 400, height: 20), within: withinRange))
            }
            
            it("marginTop() + marginBottom())") {
                stackView.direction(.row).justifyContent(.start).alignItems(.start).define({ (stack) in
                    label1.text = "Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1"
                    label1.item.marginTop(10).marginBottom(340)
                    label2.item.marginTop(10%)
                    view1.item.marginTop(10).marginBottom(200)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 400, y: 60, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 504, y: 10, width: 400, height: 20), within: withinRange))
            }
        }
        
        //
        // 4.1 row + vertical margins + alignItems(.end)
        //
        describe("rows + horizontal margins") {
            it("marginTop()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginTop(10)
                    label2.item.marginTop(25%)
                    view1.item.marginTop(100)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 580, width: 400, height: 20), within: withinRange))
            }
            
            it("marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginBottom(10)
                    label2.item.marginBottom(25%)
                    view1.item.marginTop(20).marginBottom(100)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 569.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 429.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 480, width: 400, height: 20), within: withinRange))
            }
            
            it("marginStart()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginStart(10)
                    label2.item.marginStart(25%)
                    view1.item.marginStart(20).marginBottom(100)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 163.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 287.667, y: 479, width: 380, height: 21), within: withinRange))
            }
            
            it("marginEnd()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginEnd(10)
                    label2.item.marginEnd(25%)
                    view1.item.marginTop(20).marginEnd(100)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 573.333, width: 300, height: 26.667), within: withinRange))
            }
            
            it("marginTop() + marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.end).define({ (stack) in
                    label1.item.marginTop(10).marginBottom(200)
                    label2.item.marginTop(10%).marginBottom(50%)
                    view1.item.marginTop(10).marginBottom(200)
                })
                
                stackView.layout()
                
                // Match FlexLayout (except vertical %)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 379.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 279.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 380, width: 400, height: 20), within: withinRange))
            }
        }
        
        //
        // 5.1 rows + horizontal margins + alignItems
        //
        describe("rows + horizontal margins") {
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 330, height: 600), within: withinRange))
            }
            
            it("justifyContent(.start) + marginLeft() + marginRight()") {
                stackView.direction(.row).justifyContent(.end).alignItems(.end).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40).shrink(1)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 528.667, width: 112.333, height: 71.333), within: withinRange))
            }
            
            it("justifyContent(.end) + marginLeft() + marginRight()") {
                stackView.direction(.row).justifyContent(.end).alignItems(.stretch).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: -207.667, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: -124, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30, y: 0, width: 330, height: 600), within: withinRange))
            }
            
            it("justifyContent(.end) + marginLeft() + marginRight()") {
                stackView.direction(.row).justifyContent(.end).alignItems(.stretch).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40).shrink(1)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 112.333, height: 600), within: withinRange))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackView.direction(.row).justifyContent(.center).alignItems(.stretch).define({ (stack) in
                    label1.item.marginLeft(10).marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).marginRight(40).shrink(1)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 112.333, height: 600), within: withinRange))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackView.direction(.row).justifyContent(.center).alignItems(.stretch).define({ (stack) in
                    label1.item.marginRight(20)
                    label2.item.marginLeft(10).marginRight(20)
                    view1.item.marginLeft(30).shrink(1)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 237.667, y: 0, width: 162.333, height: 600), within: withinRange))
            }
        }
     
        //
        // Other margin methods
        //
        describe("Other margins methos") {
            it("marginHorizontal()") {
                stackView.direction(.column).justifyContent(.center).alignItems(.stretch).define({ (stack) in
                    label1.item.marginHorizontal(10)
                    label2.item.marginLeft(10).marginRight(10)
                    view1.item.marginHorizontal(10%)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 267.333, width: 380, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 287.667, width: 380, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 308, width: 320, height: 25), within: withinRange))
            }
            
            it("marginHorizontal()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginHorizontal(10)
                    label2.item.marginLeft(10).marginRight(10)
                    view1.item.marginHorizontal(10%)
                })
                
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 0, width: 104, height: 600), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 237.667, y: 0, width: 320, height: 600), within: withinRange))
            }
            
            it("marginVertical()") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginVertical(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginVertical(10%)
                })
                
                stackView.layout()
                
                // Match FlexLayout (except vertical margin %)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 400, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50.333, width: 400, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: withinRange))
            }
            
            it("marginVertical()") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.marginVertical(10)
                    label2.item.marginTop(10).marginBottom(10)
                    view1.item.marginVertical(10%)
                })
                
                stackView.layout()
                
                // Match FlexLayout (except vertical margin %)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 10, width: 104, height: 580), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 60, width: 400, height: 480), within: withinRange))
            }
            
            it("margin() + column") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.margin(10)
                    label2.item.margin(20)
                    view1.item.margin(10%)
                })
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 380, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 60.333, width: 360, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 160.667, width: 320, height: 25), within: withinRange))
            }
            
            it("margin() + row") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.margin(10)
                    label2.item.margin(20)
                    view1.item.margin(10%)
                })
                
                stackView.layout()
                
                // Match FlexLayout (except vertical margin %)
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 53.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 20, width: 104, height: 560), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 257.667, y: 60, width: 320, height: 480), within: withinRange))
            }
            
            it("margin() + row") {
                stackView.direction(.row).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.margin(10)
                    label2.item.margin(20)
                    view1.item.margin(10).shrink(1)
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 53.667, height: 580), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 20, width: 104, height: 560), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 227.667, y: 10, width: 162.333, height: 580), within: withinRange))
            }
            
            it("margin(UIEdgeInsets) + margin(NSDirectionalInsets") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.margin(UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
                    if #available(iOS 11.0, *) {
                        label2.item.margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
                    } else {
                        label2.item.marginTop(10).marginStart(20).marginBottom(30).marginEnd(40)
                    }
                })
                
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 340, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 70.333, width: 340, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 120.667, width: 400, height: 20), within: withinRange))
            }
            
            it("margin(...) + margin(...") {
                stackView.direction(.column).justifyContent(.start).alignItems(.stretch).define({ (stack) in
                    label1.item.margin(10, 20)
                    label2.item.margin(10, 20, 30)
                })
                    
                stackView.layout()
                
                // Match FlexLayout
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 20, y: 10, width: 360, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 50.333, width: 360, height: 20.333), within: withinRange))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 100.667, width: 400, height: 20), within: withinRange))
            }
        }
    }
}
