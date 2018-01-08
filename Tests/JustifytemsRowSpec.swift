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
        
        var stackView: StackView!
        var label1: UILabel!
        var label2: UILabel!
        var label3: UILabel!
        
        beforeSuite {
            _setUnitTestDisplayScale(3)
        }

        beforeEach {
            viewController = UIViewController()
            
            stackView = StackView()
            stackView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
            viewController.view.addSubview(stackView)

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
            
            stackView.addItem(label1)
            stackView.addItem(label2)
            stackView.addItem(label3)
            
        }
        
        //
        // justifyContent()
        //
        describe("StackLayout justifyContent() alignItems(.stretch)") {
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.stretch)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 600.0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0.0, width: 104.0, height: 600.0), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 600.0), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.direction(.row)
                stackView.justifyContent(.center)
                stackView.alignItems(.stretch)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.667, y: 0.0, width: 53.667, height: 600.0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0.0, width: 104.0, height: 600.0), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.333, y: 0.0, width: 151.333, height: 600.0), within: withinRange))
            }
            
            it("justify(.end)") {
                stackView.direction(.row)
                stackView.justifyContent(.end)
                stackView.alignItems(.stretch)
                stackView.layout()

                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 0.0, width: 53.667, height: 600.0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.667, y: 0.0, width: 104.0, height: 600.0), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.667, y: 0.0, width: 151.333, height: 600.0), within: withinRange))
            }
            
            it("justify(.spaceAround)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceAround)
                stackView.alignItems(.stretch)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.333, y: 0.0, width: 53.667, height: 600.0), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0.0, width: 104.0, height: 600.0), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.667, y: 0.0, width: 151.333, height: 600.0), within: withinRange))
            }
            
            it("justify(.spaceBetween)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceBetween)
                stackView.alignItems(.stretch)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0, width: 104, height: 600), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 249, y: 0, width: 151.333, height: 600), within: withinRange))
            }
            
            it("justify(.spaceEvenly)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceEvenly)
                stackView.alignItems(.stretch)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.667, y: 0, width: 53.667, height: 600), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99, y: 0, width: 104, height: 600), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.667, y: 0, width: 151.333, height: 600), within: withinRange))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.start)") {
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.direction(.row)
                stackView.justifyContent(.center)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.667, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.333, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.end)") {
                stackView.direction(.row)
                stackView.justifyContent(.end)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.667, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceAround)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceAround)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.333, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceBetween)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceBetween)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 249, y: 0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceEvenly)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceEvenly)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.667, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99, y: 0, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.667, y: 0, width: 151.333, height: 20.333), within: withinRange))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.center)") {
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.direction(.row)
                stackView.justifyContent(.center)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.667, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 290, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.333, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.end)") {
                stackView.direction(.row)
                stackView.justifyContent(.end)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.667, y: 290, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.667, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceAround)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceAround)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.333, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 290, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.667, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceBetween)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceBetween)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 249, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceEvenly)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceEvenly)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.667, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99, y: 290, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.667, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
        }
        
        describe("StackLayout justifyContent() alignItems(.end)") {
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.direction(.row)
                stackView.justifyContent(.center)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 45.667, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 579.667, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 203.333, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.end)") {
                stackView.direction(.row)
                stackView.justifyContent(.end)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 91.0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 144.667, y: 579.667, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 248.667, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceAround)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceAround)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 15.333, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 579.667, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 233.667, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceBetween)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceBetween)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 0, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99.333, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 249, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.spaceEvenly)") {
                stackView.direction(.row)
                stackView.justifyContent(.spaceEvenly)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 22.667, y: 579.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 99, y: 579.667, width: 104, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 225.667, y: 579.667, width: 151.333, height: 20.333), within: withinRange))
            }
        }
        
        describe("StackLayout justifyContent() alignSelf") {
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label2.item.alignSelf(.auto)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label2.item.alignSelf(.stretch)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0.0, width: 104.0, height: 600.0), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                
                label2.item.alignSelf(.start)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 0.0, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 290, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label2.item.alignSelf(.center)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 290, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.direction(.row)
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                
                label2.item.alignSelf(.end)
                
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 53.667, y: 579.667, width: 104.0, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 157.667, y: 0.0, width: 151.333, height: 20.333), within: withinRange))
            }
        }
    }
}
