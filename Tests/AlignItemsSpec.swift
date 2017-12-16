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

class AlignItemsSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var stackLayoutView: StackLayoutView!
        var label1: UILabel!
        var label2: UILabel!
        var label3: UILabel!

        beforeSuite {
            _setUnitTestDisplayScale(3)
        }

        beforeEach {
            Pin.lastWarningText = nil
            
            viewController = UIViewController()

            stackLayoutView = StackLayoutView()
            stackLayoutView.frame = CGRect(x: 0, y: 64, width: 400, height: 600)
            viewController.view.addSubview(stackLayoutView)

            label1 = UILabel()
            label1.backgroundColor = .red
            label1.text = "Label 1"
            
            label2 = UILabel()
            label2.backgroundColor = .green
            label2.text = "Label a little longuer"
            
            label3 = UILabel()
            label3.backgroundColor = .blue
            label3.text = "Label very very very much longuer"
            
            stackLayoutView.addItem(label1)
            stackLayoutView.addItem(label2)
            stackLayoutView.addItem(label3)
            
            stackLayoutView.direction(.column)
            stackLayoutView.justifyContent(.start)
            stackLayoutView.alignItems(.stretch)
        }
        
        //
        // align()
        //
        describe("StackLayout align()") {
            it("align(.stretch)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.stretch)
                stackLayoutView.layout()

                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 400.0, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 400.0, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 40.66, width: 400.0, height: 20.33), within: 0.5))
            }
            
            it("align(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
            
            it("align(.center)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.66, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
            
            it("align(.end)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.66, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.33, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
        }
        
        //
        // alignSelf()
        //
        describe("StackLayout alignSelf()") {
            it("alignSelf(.auto)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                label2.item.alignSelf(.auto)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.66, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
            
            it("alignSelf(.start)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                label2.item.alignSelf(.start)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.66, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
            
            it("alignSelf(.center)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                label2.item.alignSelf(.center)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
            
            it("alignSelf(.end)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                label2.item.alignSelf(.end)
                
                stackLayoutView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.33, y: 0.0, width: 53.66, height: 20.33), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.66, y: 20.33, width: 154.33, height: 20.33), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.66, y: 40.66, width: 262.66, height: 20.33), within: 0.5))
            }
        }
    }
}
