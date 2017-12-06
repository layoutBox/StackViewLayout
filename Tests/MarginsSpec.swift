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
        // colums + margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 370.0, height: 20.3333333333333), within: 0.5))
            }
        }
        
        //
        // colums + margins + alignItems(.start)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label1.item.marginLeft(10).marginRight(20)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
            }
        }
        
        //
        // colums + margins + alignItems(.center)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                view1.item.marginLeft(40)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 40.0, y: 40.6666666666667, width: 360.0, height: 22.2222222222222), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))

            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 148.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))
            }
            
            it("marginLeft() + marginRight())") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label1.item.marginLeft(10).marginRight(200)
                view1.item.marginLeft(10).marginRight(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 146.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.6666666666667, width: 190.0, height: 42.1052631578947), within: 0.5))
            }
        }
        
        //
        // colums + margins + alignItems(.end)
        //
        describe("margins") {
            it("marginLeft()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginLeft(10)
                label2.item.marginLeft(25%)
                view1.item.marginLeft(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 100.0, y: 40.6666666666667, width: 300.0, height: 26.6666666666667), within: 0.5))
            }
            
            it("marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginRight(10)
                label2.item.marginRight(25%)
                view1.item.marginLeft(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))
            }
            
            it("marginStart()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginStart(10)
                label2.item.marginStart(25%)
                view1.item.marginStart(20).marginRight(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 296.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))
            }
            
            it("marginEnd()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginEnd(10)
                label2.item.marginEnd(25%)
                view1.item.marginLeft(20).marginEnd(100)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 336.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 196.0, y: 20.3333333333333, width: 104.0, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 20.0, y: 40.6666666666667, width: 280.0, height: 28.5714285714286), within: 0.5))
            }
            
            it("marginLeft() + marginRight()") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                
                label1.item.marginLeft(10).marginRight(200)
                view1.item.marginLeft(10).marginRight(200)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 146.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(view1.frame).to(beCloseTo(CGRect(x: 10.0, y: 40.6666666666667, width: 190.0, height: 42.1052631578947), within: 0.5))
            }
        }
        
        //
        // row + margins + alignItems(.stretch)
        //
        describe("margins") {
            it("marginTop()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10)
                label2.item.marginTop(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 100.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginBottom(10)
                label2.item.marginBottom(25%)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 390.0, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 300.0, height: 20.3333333333333), within: 0.5))
            }
            
            it("marginTop() + marginBottom()") {
                stackLayoutView.direction(.row)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                
                label1.item.marginTop(10).marginBottom(20)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 10.0, y: 0.0, width: 370.0, height: 20.3333333333333), within: 0.5))
            }
        }
        
    }
}
