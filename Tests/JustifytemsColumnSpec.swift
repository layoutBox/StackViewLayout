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

class JustifytemsColumnSpec: QuickSpec {
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
            label2.text = "Label a little longuer"
            
            label3 = UILabel()
            label3.font = UIFont.systemFont(ofSize: 17)
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
        // justifyContent()
        //
        describe("StackLayout justifyContent()") {
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.3333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 40.6666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()

                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 20.3333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 40.6666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justify(.start)") {
                stackLayoutView.justifyContent(.start)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.666666666667, y: 20.3333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.333333333333, y: 40.6666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 269.5, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 289.833333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 310.166666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 269.5, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 289.833333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 310.166666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justify(.center)") {
                stackLayoutView.justifyContent(.center)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 269.5, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.666666666667, y: 289.833333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.333333333333, y: 310.166666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.start)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 539.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 559.333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 579.666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 539.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 559.333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 579.666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.end)") {
                stackLayoutView.justifyContent(.end)
                stackLayoutView.alignItems(.end)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 539.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.666666666667, y: 559.333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.333333333333, y: 579.666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.spaceBetween)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.spaceBetween)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 289.833333333333, width: 154.333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 579.666666666667, width: 262.666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.spaceAround)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.spaceAround)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 89.8333333333333, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 289.833333333333, width: 154.333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 489.833333333333, width: 262.666666666667, height: 20.3333333333333), within: 0.5))
            }
            
            it("justifyContent(.spaceEvenly)") {
                stackLayoutView.direction(.column)
                stackLayoutView.justifyContent(.spaceEvenly)
                stackLayoutView.alignItems(.center)
                stackLayoutView.layoutIfNeeded()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.166666666667, y: 134.75, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
                expect(label2.frame).to(beCloseTo(CGRect(x: 122.833333333333, y: 289.833333333333, width: 154.333333333333, height: 20.3333333333333), within: 0.5))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.6666666666667, y: 444.916666666667, width: 262.666666666667, height: 20.3333333333333), within: 0.5))
            }
            
//            it("align(.end)") {
//                stackLayoutView.justifyContent(.spaceBetween)
//                stackLayoutView.alignItems(.end)
//                stackLayoutView.layoutIfNeeded()
//
////                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
////                expect(label2.frame).to(beCloseTo(CGRect(x: 245.666666666667, y: 20.3333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
////                expect(label3.frame).to(beCloseTo(CGRect(x: 137.333333333333, y: 40.6666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
//            }
            
//            it("align(.end)") {
//                stackLayoutView.justifyContent(.spaceBetween)
//                stackLayoutView.alignItems(.end)
//                stackLayoutView.layoutIfNeeded()
//
//                //                expect(label1.frame).to(beCloseTo(CGRect(x: 346.333333333333, y: 0.0, width: 53.6666666666667, height: 20.3333333333333), within: 0.5))
//                //                expect(label2.frame).to(beCloseTo(CGRect(x: 245.666666666667, y: 20.3333333333333, width: 154.3333333333333, height: 20.3333333333333), within: 0.5))
//                //                expect(label3.frame).to(beCloseTo(CGRect(x: 137.333333333333, y: 40.6666666666667, width: 262.6666666666667, height: 20.3333333333333), within: 0.5))
//            }
        }
    }
}
