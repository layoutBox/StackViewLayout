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

class JustifytemsRowSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackLayoutView: StackLayoutView!
        var label1: UILabel!
        var label2: UILabel!
        var label3: UILabel!
        
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
            
            label3 = UILabel()
            label3.font = UIFont.systemFont(ofSize: 17)
            label3.backgroundColor = .blue
            label3.text = "Label much longuer"
            
            stackLayoutView.addItem(label1)
            stackLayoutView.addItem(label2)
            stackLayoutView.addItem(label3)
            
            stackLayoutView.direction(.row)
        }
        
        //
        // justifyContent()
        //
        describe("StackLayout justifyContent() alignItems(.stretch)") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 600.0), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 600.0), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.5, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 600.0), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.33, y: 0.0, width: 151.33, height: 600.0), within: 0.5))
            }
            
            it("justify(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()

                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.66, y: 0.0, width: 104.0, height: 600.0), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 0.0, width: 151.33, height: 600.0), within: 0.5))
            }
            
            it("justify(.spaceAround)") {
                stackLayoutView.justifyContent(.spaceAround)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.33, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 600.0), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.5, y: 0.0, width: 151.33, height: 600.0), within: 1))
            }
            
            it("justify(.spaceBetween)") {
                stackLayoutView.justifyContent(.spaceBetween)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 600.0), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 0.0, width: 151.33, height: 600.0), within: 0.5))
            }
            
            it("justify(.spaceEvenly)") {
                stackLayoutView.justifyContent(.spaceEvenly)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.75, y: 0.0, width: 53.66, height: 600.0), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 600.0), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.66, y: 0.0, width: 151.33, height: 600.0), within: 0.7))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.start)") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.5, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.33, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.66, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceAround)") {
                stackLayoutView.justifyContent(.spaceAround)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.5, y: 0.0, width: 151.33, height: 20.33), within: 1))
            }
            
            it("justify(.spaceBetween)") {
                stackLayoutView.justifyContent(.spaceBetween)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceEvenly)") {
                stackLayoutView.justifyContent(.spaceEvenly)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.75, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 0.0, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.66, y: 0.0, width: 151.33, height: 20.33), within: 0.8))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.center)") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 290, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.5, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.33, y: 290, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.66, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 290, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceAround)") {
                stackLayoutView.justifyContent(.spaceAround)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.33, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 290, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.5, y: 290, width: 151.33, height: 20.33), within: 1.0))
            }
            
            it("justify(.spaceBetween)") {
                stackLayoutView.justifyContent(.spaceBetween)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 290, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceEvenly)") {
                stackLayoutView.justifyContent(.spaceEvenly)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.75, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 290, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.66, y: 290, width: 151.33, height: 20.33), within: 0.8))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.end)") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 579.66, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 579.66, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.5, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 579.66, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.33, y: 579.66, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.66, y: 579.66, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 579.66, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceAround)") {
                stackLayoutView.justifyContent(.spaceAround)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.33, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 579.66, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.5, y: 579.66, width: 151.33, height: 20.33), within: 1.0))
            }
            
            it("justify(.spaceBetween)") {
                stackLayoutView.justifyContent(.spaceBetween)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 579.66, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.66, y: 579.66, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.spaceEvenly)") {
                stackLayoutView.justifyContent(.spaceEvenly)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.75, y: 579.66, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.33, y: 579.66, width: 104.0, height: 20.33), within: 0.85))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.66, y: 579.66, width: 151.33, height: 20.33), within: 0.85))
            }
        }
        
        describe("StackLayout justifyContent() alignSelf") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label2.item.alignSelf(.auto)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label2.item.alignSelf(.stretch)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 600.0), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                
                label2.item.alignSelf(.start)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 0.0, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 290, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label2.item.alignSelf(.center)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 290, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                
                label2.item.alignSelf(.end)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.66, y: 579.66, width: 104.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.66, y: 0.0, width: 151.33, height: 20.33), within: 0.5))
            }
        }
        
        
    }
}
