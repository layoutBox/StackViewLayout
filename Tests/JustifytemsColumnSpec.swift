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
            label2.text = "Label a little longuer"
            
            label3 = UILabel()
            label3.font = UIFont.systemFont(ofSize: 17)
            label3.backgroundColor = .blue
            label3.text = "Label very very very much longuer"
            
            stackView.addItem(label1)
            stackView.addItem(label2)
            stackView.addItem(label3)
            
            stackView.direction(.column)
            stackView.justifyContent(.start)
            stackView.alignItems(.stretch)
        }
        
        //
        // justifyContent()
        //
        describe("StackLayout justifyContent()") {
            it("justify(.start)") {
                stackView.justifyContent(.start)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 0.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 20.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 40.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.justifyContent(.start)
                stackView.alignItems(.center)
                stackView.layout()

                expect(label1.frame).to(beCloseTo(CGRect(x: 173.334, y: 0.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 20.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 40.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justify(.start)") {
                stackView.justifyContent(.start)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.334, y: 0.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.667, y: 20.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.334, y: 40.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.justifyContent(.center)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 269.667, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 290, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 310.334, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.justifyContent(.center)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.334, y: 269.667, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 290, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 310.334, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justify(.center)") {
                stackView.justifyContent(.center)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.334, y: 269.667, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.667, y: 290, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.334, y: 310.334, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justifyContent(.end)") {
                stackView.justifyContent(.end)
                stackView.alignItems(.start)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 0.0, y: 539.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 0.0, y: 559.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 0.0, y: 579.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justifyContent(.end)") {
                stackView.justifyContent(.end)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.334, y: 539.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 559.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 579.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justifyContent(.end)") {
                stackView.justifyContent(.end)
                stackView.alignItems(.end)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 346.334, y: 539.0, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 245.667, y: 559.334, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 137.334, y: 579.667, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justifyContent(.spaceBetween)") {
                stackView.direction(.column)
                stackView.justifyContent(.spaceBetween)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.333, y: 0, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 290, width: 154.333, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 580, width: 262.667, height: 20.333), within: withinRange))
            }
            
            it("justifyContent(.spaceAround)") {
                stackView.direction(.column)
                stackView.justifyContent(.spaceAround)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.334, y: 90, width: 53.667, height: 20.334), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 290, width: 154.334, height: 20.334), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 490, width: 262.667, height: 20.334), within: withinRange))
            }
            
            it("justifyContent(.spaceEvenly)") {
                stackView.direction(.column)
                stackView.justifyContent(.spaceEvenly)
                stackView.alignItems(.center)
                stackView.layout()
                
                expect(stackView.frame).to(beCloseTo(CGRect(x: 0, y: 64, width: 400, height: 600), within: withinRange))
                expect(label1.frame).to(beCloseTo(CGRect(x: 173.333, y: 134.667, width: 53.667, height: 20.333), within: withinRange))
                expect(label2.frame).to(beCloseTo(CGRect(x: 123, y: 289.667, width: 154.333, height: 20.333), within: withinRange))
                expect(label3.frame).to(beCloseTo(CGRect(x: 68.667, y: 444.667, width: 262.667, height: 20.333), within: withinRange))
            }
        }
    }
}
