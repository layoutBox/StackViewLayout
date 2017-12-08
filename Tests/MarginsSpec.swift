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
        
        var stackLayoutView: StackLayoutView!
        var label1: UILabel!
        var label2: UILabel!
        var view1: BasicView!
        
        beforeSuite {
            _setUnitTest(displayScale: 2)
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
            
            stackLayoutView.addItem(label1)
            stackLayoutView.addItem(label2)
            stackLayoutView.addItem(view1)
        }
        
        //
        // 1. colums + horizontal margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.33, width: 300.0, height: 20.33), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 300.0, height: 20.33), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.33, width: 300.0, height: 20.33), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 300.0, height: 20.33), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 370.0, height: 20.33), within: 0.5))
            }
        }
        
        //
        // 2. colums + horizontal margins + alignItems(.start)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
            }
        }
        
        //
        // 3. colums + horizontal margins + alignItems(.center)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(20)
                view1.item.marginLeft(30)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 178, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 158.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 30.0, y: 40.66, width: 370.0, height: 21.66), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 98.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 178.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 198.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 98.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginLeft() + marginRight())") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10%).marginRight(50%)
                view1.item.marginLeft(10)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 68.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.6666666666667, width: 390.0, height: 20.6666666666667), within: 0.5))
            }
            
            it("marginLeft() + marginRight())") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10%).marginRight(50%)
                view1.item.marginLeft(10).marginRight(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 168.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 68.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.6666666666667, width: 190.0, height: 42.3333333333333), within: 0.5))
            }
        }
        
        //
        // 4. colums + horizontal margins + alignItems(.end)
        //
        describe("colums + horizontal margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                view1.item.marginLeft(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 100.0, y: 40.66, width: 300.0, height: 26.66), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.33, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.66, width: 280.0, height: 28.66), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginLeft(10).marginRight(200)
                view1.item.marginLeft(10).marginRight(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 146.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.66, width: 190.0, height: 42.33), within: 0.5))
            }
            
            it("should reduce the width of items due to large margins") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginLeft(10).marginRight(340)
                label2.item.marginLeft(10%).marginRight(75%)
                view1.item.marginLeft(10).marginRight(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 50.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 40.0, y: 20.3333333333333, width: 60.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.6666666666667, width: 190.0, height: 42.3333333333333), within: 0.5))
            }
        }
        
        //
        // 5. colums + vertical margins + alignItems
        //
        describe("colums + vertical margins") {
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 60.333, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 130.667, width: 400, height: 20), within: 0.5))
            }
            
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333, y: 419.333, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296, y: 469.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 540, width: 400, height: 20), within: 0.5))
            }
            
            it("justifyContent(.end) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 419.333, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 469.667, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 540, width: 400, height: 20), within: 0.5))
            }
            
            it("justifyContent(.center) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10).marginBottom(20)
                view1.item.marginTop(30).marginBottom(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 214.667, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 265, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 335.333, width: 400, height: 20), within: 0.5))
            }
        }
        
        //
        // 1.1 row + vertical margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginTop()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10)
                label2.item.marginTop(25%)
                view1.item.marginTop(50%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 53.66, height: 590.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 150.0, width: 104.0, height: 450.0), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 300.0, width: 26.66, height: 300.0), within: 0.5))
            }
            
            it("marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginBottom(10)
                label2.item.marginBottom(25%)
                view1.item.marginBottom(50%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 590.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 450.0), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 26.66, height: 300.0), within: 0.5))
            }
            
            it("marginTop() + marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10%).marginBottom(20%)
                view1.item.marginTop(20%).marginBottom(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 53.66, height: 570.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 60.0, width: 104.0, height: 420.0), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 120.0, width: 19.047619047619, height: 420.0), within: 0.5))
            }
        }
        
        //
        // 2.1 rows + vertical margins + alignItems(.start)
        //
        describe("margins") {
            it("marginTop()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginTop(10)
                label2.item.marginTop(10%)
                view1.item.marginTop(20%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 60.0, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 120.0, width: 16.66, height: 480.0), within: 0.5))
            }
            
            it("marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginBottom(10)
                label2.item.marginBottom(10%)
                view1.item.marginBottom(20%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 16.66, height: 480.0), within: 0.5))
            }
            
            it("marginTop() + marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginTop(10).marginBottom(20)
                label2.item.marginTop(10%).marginBottom(20%)
                view1.item.marginTop(20%).marginBottom(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 60.0, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 120.0, width: 19.047619047619, height: 420.0), within: 0.5))
            }
        }
        
        //
        // 3.1 rows + vertical margins + alignItems(.center)
        //
        describe("margins") {
            it("marginTop()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginTop(10)
                label2.item.marginTop(20)
                view1.item.marginTop(30)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 295, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 300, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 30.0, width: 14.33, height: 570.0), within: 0.5))
            }
            
            it("marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginBottom(10)
                label2.item.marginBottom(25%)
                view1.item.marginTop(20).marginBottom(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 284.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 214.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 20, width: 16.667, height: 480), within: 0.5))
            }
            
            it("marginTop() + marginBottom())") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                // top margin cancel the bottom margin if they have the same value
                label1.item.marginTop(10).marginBottom(10)
                label2.item.marginTop(20).marginBottom(20)
                view1.item.marginTop(30).marginBottom(30)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 30.0, width: 15, height: 540), within: 0.5))
            }
            
            it("marginTop() + marginBottom())") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginTop(10).marginBottom(340)
                label2.item.marginTop(10%)
                view1.item.marginTop(10).marginBottom(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 60.0, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.66, y: 10.0, width: 20.66, height: 390.0), within: 0.5))
            }
            
            it("marginTop() + marginBottom())") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.text = "Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1"
                label1.item.marginTop(10).marginBottom(340)
                label2.item.marginTop(10%)
                view1.item.marginTop(10).marginBottom(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 10.0, width: 400.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 400.0, y: 60.0, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 504.0, y: 10.0, width: 20.6666666666667, height: 390.0), within: 0.5))
            }
        }
        
        //
        // 4.1 row + vertical margins + alignItems(.end)
        //
        describe("rows + horizontal margins") {
            it("marginTop()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginTop(10)
                label2.item.marginTop(25%)
                view1.item.marginTop(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 100, width: 16, height: 500), within: 0.5))
            }
            
            it("marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginBottom(10)
                label2.item.marginBottom(25%)
                view1.item.marginTop(20).marginBottom(100)
                
                stackLayoutView.layout()
                
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 20, width: 16.667, height: 480), within: 0.5))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 569.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 429.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 20, width: 16.667, height: 480), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginBottom(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 579.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 163.667, y: 579.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 287.667, y: 0, width: 16, height: 500), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginTop(20).marginEnd(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 63.667, y: 579.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 267.667, y: 20, width: 14, height: 580), within: 0.5))
            }
            
            it("marginTop() + marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginTop(10).marginBottom(200)
                label2.item.marginTop(10%).marginBottom(50%)
                view1.item.marginTop(10).marginBottom(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 379.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 279.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 10, width: 20.667, height: 390), within: 0.5))
            }
        }
        
        //
        // 5.1 rows + horizontal margins + alignItems
        //
        describe("rows + horizontal margins") {
            it("justifyContent(.start) + marginTop() + marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10).marginRight(20)
                view1.item.marginLeft(30).marginRight(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 247.667, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("justifyContent(.start) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10).marginRight(20)
                view1.item.marginLeft(30).marginRight(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 109, y: 579.667, width: 53.667, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 192.667, y: 579.667, width: 104, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 346.667, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("justifyContent(.end) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10).marginRight(20)
                view1.item.marginLeft(30).marginRight(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 109, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 192.667, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 346.667, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                label2.item.marginLeft(10).marginRight(20)
                view1.item.marginLeft(30).marginRight(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 59.333, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 143, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 297, y: 0, width: 13.333, height: 600), within: 0.5))
            }
            
            it("justifyContent(.center) + marginLeft() + marginRight()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginRight(20)
                label2.item.marginLeft(10).marginRight(20)
                view1.item.marginLeft(30)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 74.333, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 158, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 312, y: 0, width: 13.333, height: 600), within: 0.5))
            }
        }
     
        //
        // Other margin methods
        //
        describe("Other margins methos") {
            it("marginHorizontal()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginHorizontal(10)
                label2.item.marginLeft(10).marginRight(10)
                view1.item.marginHorizontal(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 267, width: 380, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 10, y: 287.333, width: 380, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 307.667, width: 320, height: 25), within: 0.5))
            }
            
            it("marginHorizontal()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginHorizontal(10)
                label2.item.marginLeft(10).marginRight(10)
                view1.item.marginHorizontal(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 0, width: 53.667, height: 600), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 83.667, y: 0, width: 104, height: 600), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 237.667, y: 0, width: 13.333, height: 600), within: 0.5))

            }
            
            it("marginVertical()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginVertical(10)
                label2.item.marginTop(10).marginBottom(10)
                view1.item.marginVertical(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 400, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0, y: 50.333, width: 400, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 0, y: 140.667, width: 400, height: 20), within: 0.5))
            }
            
            it("marginVertical()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginVertical(10)
                label2.item.marginTop(10).marginBottom(10)
                view1.item.marginVertical(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 10, width: 53.667, height: 580), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 10, width: 104, height: 580), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 157.667, y: 60, width: 16.667, height: 480), within: 0.5))
            }
            
            it("margin() + column") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.margin(10)
                label2.item.margin(20)
                view1.item.margin(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 380, height: 20.333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 20, y: 60.333, width: 360, height: 20.333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40, y: 160.667, width: 320, height: 25), within: 0.5))
            }
            
            it("margin() + row") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.margin(10)
                label2.item.margin(20)
                view1.item.margin(10%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10, y: 10, width: 53.667, height: 580), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 93.667, y: 20, width: 104, height: 560), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 257.667, y: 60, width: 16.667, height: 480), within: 0.5))
            }
        }
    }
}
