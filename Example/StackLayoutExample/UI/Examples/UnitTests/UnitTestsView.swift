// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import UIKit
import PinLayout

class UnitTestsView: UIView {
    fileprivate let contentScrollView = UIScrollView()
    
    fileprivate let descriptionLabel = UILabel()
    
    fileprivate let noMarginsNoPaddings = BasicView(text: "70x30", color: .black)
    
//    fileprivate let noMarginsLeftInsetView = BasicView(text: "LI", color: UIColor.red.withAlphaComponent(1.0))
//    fileprivate let noMarginsRightInsetView = BasicView(text: "RI", color: UIColor.red.withAlphaComponent(0.8))
//    fileprivate let noMarginsLeftRightInsetView = BasicView(text: "LI-RI", color: UIColor.red.withAlphaComponent(0.6))
//    
//    fileprivate let leftMarginView = BasicView(text: "LM", color: UIColor.blue.withAlphaComponent(1.0))
//    fileprivate let leftMarginLeftInsetView = BasicView(text: "LM LI", color: UIColor.blue.withAlphaComponent(0.8))
//    fileprivate let leftMarginRightInsetView = BasicView(text: "LM RI", color: UIColor.blue.withAlphaComponent(0.6))
//    fileprivate let leftMarginLeftRightInsetView = BasicView(text: "LM LI-RI", color: UIColor.blue.withAlphaComponent(0.4))
//    
//    fileprivate let rigthMarginView = BasicView(text: "RM", color: UIColor.green.withAlphaComponent(1))
//    fileprivate let rigthMarginLeftInsetView = BasicView(text: "RM LI", color: UIColor.green.withAlphaComponent(0.8))
//    fileprivate let rigthMarginRightInsetView = BasicView(text: "RM RI", color: UIColor.green.withAlphaComponent(0.6))
//    fileprivate let rigthMarginLeftRightInsetView = BasicView(text: "RM LI-RI", color: UIColor.green.withAlphaComponent(0.4))
//    
//    fileprivate let leftRightMarginsView = BasicView(text: "LM-RM", color: UIColor.purple.withAlphaComponent(1))
//    fileprivate let leftRightMarginsLeftInsetView = BasicView(text: "LM-RM LI", color: UIColor.purple.withAlphaComponent(0.8))
//    fileprivate let leftRightMarginsRightInsetView = BasicView(text: "LM-RM RI", color: UIColor.purple.withAlphaComponent(0.6))
//    fileprivate let leftRightMarginsLeftRightInsetView = BasicView(text: "LM-RM LI-RI", color: UIColor.purple.withAlphaComponent(0.4))
    
    var rootView: BasicView!
    var aView: BasicView!
    var aViewChild: BasicView!
    
    var bView: BasicView!
    var bViewChild: BasicView!

    var index = 0
    var anchorsList: [(String, Anchor)] = []

    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        rootView.addSubview(aView)
        
        aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
//        aView.addSubview(aViewChild)
        
        bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
        rootView.addSubview(bView)
        
        bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
        bView.addSubview(bViewChild)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))

        anchorsList = getAnchorList(forView: bView)
        index = anchorsList.count - 1
        setNeedsLayout()
    }

    func didTap() {
        index += 1

        if index >= anchorsList.count {
            index = 0
        }

        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        testMarginInsets()
//        testPinAll()
        testFitWidthFitHeight()
        
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
//        aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
//        bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)

//        aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
//
        
//        bView.pin.hCenter(to: aView.edge.left)
//        expect(bView.frame).to(equal(CGRect(x: 85.0, y: 120.0, width: 110.0, height: 80.0)))
        
//    bView.pin.hCenter(to: aView.edge.hCenter)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 120.0, width: 110.0, height: 80.0)))

//        bView.pin.hCenter(to: aView.edge.right)
//        expect(bView.frame).to(equal(CGRect(x: 285.0, y: 120.0, width: 110.0, height: 80.0)))

//        bView.pin.vCenter(to: aView.edge.vCenter)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 110.0, height: 80.0)))

//            bView.pin.vCenter(to: aView.edge.bottom)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 160.0, width: 110.0, height: 80.0)))

//    bViewChild.pin.vCenter(to: aView.edge.vCenter)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 20.0, width: 60.0, height: 20.0)))
    
        //////////////////////////////////////////////
//        bView.pin.vCenter(to: aView.edge.top)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 110.0, height: 80.0)))

//        bView.pin.vCenter(to: aView.edge.vCenter)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 90.0, width: 110.0, height: 80.0)))

//        bView.pin.vCenter(to: aView.edge.bottom)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 120.0, width: 110.0, height: 80.0)))

//        bViewChild.pin.vCenter(to: aView.edge.vCenter)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 60.0, height: 20.0)))

//        bView.pin.hCenter(to: aView.edge.left)
//        expect(bView.frame).to(equal(CGRect(x: -15.0, y: 120.0, width: 110.0, height: 80.0)))

//        bView.pin.hCenter(to: aView.edge.hCenter)
//        expect(bView.frame).to(equal(CGRect(x: 35.0, y: 120.0, width: 110.0, height: 80.0)))

//        bView.pin.hCenter(100)
        
//        aView.pin.top(to: bView.edge.top).hCenter(to: bView.edge.hCenter).marginTop(10)
        
//        expect(bView.frame).to(equal(CGRect(x: 85.0, y: 120.0, width: 110.0, height: 80.0)))
//        let name = anchorsList[index].0
//        let anchor = anchorsList[index].1
//        print("aViewChild.pin.topCenter(to: bView.anchor.\(name))")
//        aViewChild.pin.topCenter(to: anchor)
//        printViewFrame(aViewChild, name: "aViewChild")

//        aView.pin.left(0).right(0).top(0).bottom(0).margin(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 380.0, height: 380.0)))

//        aView.pin.topLeft().bottomRight().margin(10)

//         topLeft
//        aViewChild.pin.topLeft(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 180.0, width: 50.0, height: 30.0)))

//        topCenter
//        aViewChild.pin.topCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 180.0, width: 50.0, height: 30.0)))

//        topRight
//        aViewChild.pin.topRight(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 180.0, width: 50.0, height: 30.0)))

//        leftCenter
//        aViewChild.pin.leftCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 165.0, width: 50.0, height: 30.0)))

//        center
//        aViewChild.pin.center(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 165.0, width: 50.0, height: 30.0)))

//        rightCenter
//        aViewChild.pin.rightCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 165.0, width: 50.0, height: 30.0)))

//        bottomLeft
//        aViewChild.pin.bottomLeft(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 150.0, width: 50.0, height: 30.0)))

//        bottomCenter
//        aViewChild.pin.bottomCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 50.0, height: 30.0)))

//        bottomRight
//        aViewChild.pin.bottomRight(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)))

        //////////////////////////////////////////////
//        aView.pin.margin(t: 0, l: 0, b: 0, r: 0)

//        bView.pin.above(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 110.0, width: 40.0, height: 40.0)))
        
//        bView.pin.above(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.above(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 190.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 190.0, width: 40.0, height: 40.0)))

//        bView.pin.above(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 200.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 200.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 200.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 200.0, width: 40.0, height: 40.0)))

        // MARGINS
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
//        let label = UILabel()
//        label.text = "clafsdj lfkd asdkjkd lkjlksfjd daljs df flkjdslkjf lksfjlkj jaslkj ljdfaj lkajdsfl k asdlkd jassd adskjfksad laksdj fds;alkj l"
//        label.numberOfLines = 0
//        let toto = label.sizeThatFits(CGSize(width: 20, height: CGFloat.greatestFiniteMagnitude))
//        let toto2 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 20))
//        let toto3 = label.sizeThatFits(CGSize(width: 20, height: 20))
//        
//        let toto4 = label.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
//        let toto5 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100))
//        let toto6 = label.sizeThatFits(CGSize(width: 100, height: 100))
//        
//        let toto7 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        //
        // sizeThatFits
        //
//        aView.sizeThatFitsExpectedArea = 40 * 40
//        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 160)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        

        //
        // above
        //
        
//        bViewChild.pin.above(of: [])
//         👉 PinLayout Warning: above(allViews: [...]) won't be applied, At least one view must be specified
   
//        let unatachedView = UIView()
//        bViewChild.pin.above(of: unatachedView)
//        👉 PinLayout Warning: above(of: ...) won't be applied, the reference view "<UIView: 0x7ff2cd619010; frame = (0 0; 0 0); layer = <CALayer: 0x6100000396a0>>" is invalid. UIViews must be added as a sub-view before being used as a reference.

//        👉 PinLayout Warning: above(of: ...) won't be applied, no valid references

//        bViewChild.pin.above(of: aView, unatachedView)
//        👉 PinLayout Warning: above(of: ...) won't be applied, the reference view "<UIView: 0x7fa3e76189e0; frame = (0 0; 0 0); layer = <CALayer: 0x618000031c60>>" is invalid. UIViews must be added as a sub-view before being used as a reference.
        
        // Should warn, but the view should be anyway layouted above 'aView'
//        bViewChild.pin.above(of: unatachedView, aView, aligned: .left)
//        👉 PinLayout Warning: above(of: ..., aligned: left) won't be applied, the reference view "<UIView: 0x7f8044f109d0; frame = (0 0; 0 0); layer = <CALayer: 0x61800003f6c0>>" is invalid. UIViews must be added as a sub-view before being used as a reference.
//        expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView, aligned: .left)
//        expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView, aligned: .right)
//        expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: -40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView, aligned: .right).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aView, bView, aligned: .left).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: -50.0, width: 60.0, height: 20.0)))

        //
        // below
        //
//        bViewChild.pin.below(of: aView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 80.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .left)
//        expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: 80.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .right)
//        expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: 80.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: 40.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 80.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .right).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 90.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .left).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: 90.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.below(of: aView, bView, aligned: .center).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 90.0, width: 60.0, height: 20.0)))

        //
        // left
        //
//        bViewChild.pin.left(of: aView)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: bView, bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: -60.0, y: 10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .top)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: -20.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .bottom)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 60.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 0.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 15.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .bottom).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 50.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .top).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: -10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.left(of: aView, bView, aligned: .center).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 15.0, width: 60.0, height: 20.0)))

        //
        // right
        //
//        bViewChild.pin.right(of: aView)
//        expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .top)
//        expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: -20.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .bottom)
//        expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 60.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 0.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .center)
//        expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 15.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .bottom).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 50.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .top).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: -10.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.right(of: aView, bView, aligned: .center).margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 15.0, width: 60.0, height: 20.0)))

//        bViewChild.pin.above(of: aViewChild, aView, aligned: .left)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -120.0, width: 60.0, height: 20.0)))
//        bViewChild.pin.above(of: bView)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -20.0, width: 60.0, height: 20.0)))

        //
        // pin coordinate
        //
//        aViewChild.pin.top(.top, of: aView) //CGRect(x: 10.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.top(.top, of: bView)      // CGRect(x: 10.0, y: 100.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeft(to: bView.anchor.bottomRight)
//        bViewChild.pin.top(.top, of: aViewChild) //CGRect(x: 40.0, y: -80.0, width: 60.0, height: 20.0)

//        aViewChild.pin.top(.bottom, of: aView)      //CGRect(x: 10.0, y: 60.0, width: 50.0, height: 30.0)
//        aViewChild.pin.top(.bottom, of: bView)      //CGRect(x: 10.0, y: 180.0, width: 50.0, height: 30.0)
//        bViewChild.pin.top(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)
        
//        aViewChild.pin.bottom(to: aView.edge.top)
//        expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: -30.0, width: 50.0, height: 30.0)))

//        aViewChild.pin.bottom(to: bView.edge.top)
//        expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 70.0, width: 50.0, height: 30.0)))

//        bViewChild.pin.bottom(to: aViewChild.edge.top)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -100.0, width: 60.0, height: 20.0)))

        // TO DO
//        aViewChild.pin.bottom(to: aView.edge.bottom)
//        expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 30.0, width: 50.0, height: 30.0)))

//        aViewChild.pin.bottom(to: bView.edge.bottom)
//        expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 150.0, width: 50.0, height: 30.0)))

//        bViewChild.pin.bottom(to: aViewChild.edge.bottom)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -70.0, width: 60.0, height: 20.0)))

//        aViewChild.pin.left(to: aView.edge.left)
//        aViewChild.pin.left(.left, of: bView)
//        bViewChild.pin.left(.left, of: aViewChild)
//
//        aViewChild.pin.left(to: aView.edge.right)
//        aViewChild.pin.left(.right, of: bView)
//        bViewChild.pin.left(.right, of: aViewChild)

//        aViewChild.pin.right(to: aView.edge.left)
//        expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 20.0, width: 50.0, height: 30.0)))

//        aViewChild.pin.right(to: bView.edge.left)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 20.0, width: 50.0, height: 30.0)))

//        bViewChild.pin.right(to: aViewChild.edge.left)
//        expect(bViewChild.frame).to(equal(CGRect(x: -70.0, y: 10.0, width: 60.0, height: 20.0)))

//        aViewChild.pin.right(to: aView.edge.right)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 20.0, width: 50.0, height: 30.0)))

//        aViewChild.pin.right(to: bView.edge.right)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 20.0, width: 50.0, height: 30.0)))

//        bViewChild.pin.right(to: aViewChild.edge.right)
//        expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)))

        //
        // pin point
        //
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        // topLeft
//        aView.pin.topLeft()                    // CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.pin.topLeft.topLeft, of: aView)  //(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeftof: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeftof: aView).bottomRight()
//        aViewChild.pin.topLeft(of: bView)      // CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.pin.topLeft(of: aViewChild)      // CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.pin.topLeftto: aViewChild)< // CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)
        
//        bView.pin.bottomRight().topLeftto: .zero).below(of: bViewChild)
        
        // topCenter
//        aView.pin..topCenter.()                      // CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.pin.topCenter(to: aView)        //CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topCenter(to: bView)        //CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.pin.topCenter(to: aViewChild)        //CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.pin.topCenter(to: aViewChild)   //CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)
 
        // topRight
//        aView.pin.topRight()
//        aViewChild.pin.topRight(to: aView)
//        aViewChild.pin.topRight(to: bView)
//        bView.pin.topRight(to: aViewChild)
//        bViewChild.pin.topRight(to: aViewChild)
        
        // leftCenter
//        aView.pin.leftCenter()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))

//        aViewChild.pin.leftCenter(to: aView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
//        bView.pin.leftCenter(to: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
//        bViewChild.pin.leftCenter(to: aViewChild)
//        expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))

//        let aViewAnchors = getAnchorList(forView: aView)
//        aViewAnchors.forEach { (tuples) in
//            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//
//            let name = tuples.0
//            let anchor = tuples.1
//            print("aViewChild.pin.topLeft(to: aView.anchor.\(name))")
//
//            aViewChild.pin.topLeft(to: anchor)
//            printViewFrame(aViewChild, name: "aViewChild")
//        }

        // center
//        aView.pin.center()
//        aViewChild.pin.center(to: aView.anchor.center)
//        aViewChild.pin.center(to: bView.anchor.center)
//        bView.pin.center(to: aViewChild.anchor.center)
//        bViewChild.pin.center(to: aViewChild.anchor.center)

//        aView.pin.center()
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
//        aViewChild.pin.center(to: aView)
//        aViewChild.pin.center(to: bView)
//        bView.pin.center(to: aViewChild)
//        bViewChild.pin.center(to: aViewChild)
    
        // rightCenter
//        aView.pin.rightCenter()
//        aViewChild.pin.rightCenter(to: aView)
//        aViewChild.pin.rightCenter(to: bView)
//        bView.pin.rightCenter(to: aViewChild)
//        bViewChild.pin.rightCenter(to: aViewChild)

        // bottomLeft
//        aView.pin.bottomLeft()
//        aViewChild.pin.bottomLeft(to: aView)
//        aViewChild.pin.bottomLeft(to: bView)
//        bView.pin.bottomLeft(to: aViewChild)
//        bViewChild.pin.bottomLeft(to: aViewChild)

        // bottomCenter
//        aView.pin.bottomCenter()
//        aViewChild.pin.bottomCenter(to: aView)
//        aViewChild.pin.bottomCenter(to: bView)
//        bView.pin.bottomCenter(to: aViewChild)
//        bViewChild.pin.bottomCenter(to: aViewChild)

        // bottomRight
//        aView.pin.bottomRight()
//        aViewChild.pin.bottomRight(of: aView)
//        aViewChild.pin.bottomRight(of: bView)
//        bView.pin.bottomRight(of: aViewChild)
//        bViewChild.pin.bottomRight(of: aViewChild) 
        
        //////////////////////////////////////////////
        // min/max width/height
//        rootView.frame = CGRect(x: 0, y: 64, width: 400, height: 400)
//        aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        //
        // minWidth
        //
//        aView.pin.left().minWidth(50)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 60.0)))
//        aView.pin.left().width(100).minWidth(150) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
//        aView.pin.left().width(100).minWidth(50) // width > minWidth
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))

//        aView.pin.left(100).right(100)//.minWidth(250) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))

//        aView.pin.left(100).right(100).minWidth(250) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.left(100).right(100).marginLeft(100).minWidth(250) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 125.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.left(100).right(100).marginRight(100).minWidth(250) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 25.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.right(100).minWidth(300) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 300.0, height: 60.0)))

//        aView.pin.left().right().minWidth(500) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 400.0, height: 60.0)))

        //
        // maxWidth
        //
//        aView.pin.left().maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left().maxWidth(150).marginLeft(50)
//        expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left().right().maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 125.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left().width(200).maxWidth(150) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
        
//        aView.pin.right().width(200).maxWidth(150) // width < minWidth
//        expect(aView.frame).to(equal(CGRect(x: 250.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left(0).right(0).maxWidth(250)marginLeft(100). //
//        expect(aView.frame).to(equal(CGRect(x: 125.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.left(0).maxWidth(250).marginLeft(100) //
//        expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.left(0).width(100%).maxWidth(250).marginLeft(100) //
//        expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))

//        aView.pin.left(0).right(0).marginRight(100).maxWidth(250) //
        
//        aView.pin.left().minWidth(50).maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 60.0)))

//        aView.pin.left().width(20).minWidth(50).maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 60.0)))

//        aView.pin.left().width(200).minWidth(50).maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left().right().minWidth(50).maxWidth(150)
//        expect(aView.frame).to(equal(CGRect(x: 125.0, y: 100.0, width: 150.0, height: 60.0)))

//        aView.pin.left().right().width(200)
        
//        aView.pin.left().minWidth(150).maxWidth(50)  // warn: minWidth cannot be greater than maxWidth
//        aView.pin.left().maxWidth(50).minWidth(150)  // warn: maxWidth cannot be smaller than maxWidth
//        aView.pin.left().width(10).maxWidth(150)
//        aView.pin.left().width(200).maxWidth(150)
//        aView.pin.left().width(100).minWidth(500) // bigger than parent
        
        //////////////////////////////////////////////

//        aView.pin.left().width(100%).maxWidth(250).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().width(100%).maxWidth(250).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().width(100%).maxWidth(250).justify(.right)
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.right().width(100%).maxWidth(250).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.right().width(100%).maxWidth(250).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.right().width(100%).maxWidth(250).justify(.right)
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().maxWidth(250).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 95.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.hCenter().width(20).minWidth(250)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.hCenter().width(100%).maxWidth(250)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
//
        
//        aView.pin.left().right().width(250)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().width(250).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().width(250).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().right().width(250).justify(.right)
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
        
//        aView.pin.left().width(250).justify(.center)
        
        // TO BE ADDED TO UNIT TEST
        
        //
        // minHeight
        //
//        describe("the result of the minHeight(...)") {
//            it("should adjust the height of aView") {
//                aView.pin.top().minHeight(50)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 30)
//
//                aView.pin.top().minHeight(50)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 25.0, height: 50.0)))
//            }
        
//            it("should adjust the height of aView") {
//                aView.pin.top().height(100).minHeight(150) // height < minHeight
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
//            }
        
//            it("should adjust the height of aView") {
//                aView.pin.top().height(100).minHeight(50) // height > minHeight
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(100).bottom(100)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))
//            }
        
//            it("should adjust the height of aView") {
//                aView.pin.top(100).bottom(100).minHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(100).bottom(100).marginTop(100).minHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(100).bottom(100).marginBottom(100).minHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.bottom(100).minHeight(300)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 300.0)))
//            }
//
//            it("should adjust the height to 500 and keep the view in the center") {
//                aView.pin.top().bottom().minHeight(500)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 500.0)))
//            }
//
//            it("should adjust the height when using hCenter") {
//                aView.pin.vCenter().height(20).minHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height when using hCenter") {
//                aView.pin.vCenter().height(20).minHeight(250).align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["align(top)", "won't be applied", "justification is not applied when vCenter has been set"]))
//            }
//        }
        
        //
        // maxHeight
        //
//        describe("the result of the maxHeight(...)") {
//            it("should adjust the height of aView") {
//                aView.pin.top().maxHeight(150)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 200)

//                aView.pin.top().maxHeight(150)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
//            }
//
        
//        aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)

//            it("should adjust the height of aView") {
//                aView.pin.top().maxHeight(150).marginTop(50)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 60.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top().bottom().maxHeight(150)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top().height(200).maxHeight(150)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.bottom().height(200).maxHeight(150)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 250.0, width: 100.0, height: 150.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(0).bottom(0).maxHeight(250).marginTop(100)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(0).maxHeight(250).marginTop(100)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 300)
//                aView.pin.top(0).maxHeight(250).marginTop(100)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(0).height(100%).maxHeight(250).marginTop(100)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height of aView") {
//                aView.pin.top(0).bottom(0).marginBottom(100).maxHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().height(100%).maxHeight(250).align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["align(top)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().height(100%).maxHeight(250).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["justify(center)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().height(100%).maxHeight(250).align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["justify(right)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.bottom().height(100%).maxHeight(250).align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 150.0, width: 250.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["justify(top)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.bottom().height(100%).maxHeight(250).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["justify(center)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.bottom().height(100%).maxHeight(250).align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
//                expect(_pinlayoutUnitTestLastWarning).to(contain(["justify(center)", "won't be applied", "top and bottom coordinates"]))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 20.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().bottom().maxHeight(250).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 85.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
//            }
//
//            it("should adjust the height using align") {
//                aView.pin.top().bottom().marginTop(20).marginBottom(20).maxHeight(250).align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 130.0, width: 100.0, height: 60.0)))
//            }
//
//            it("should adjust the height when using hCenter") {
//                aView.pin.vCenter().height(100%).maxHeight(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
//            }
//        }
        
        //
        // minHeight/maxHeight & sizeToFit()
        //
//        describe("the result of the minHeight/maxWidth & sizeToFit()") {
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().height(100%).maxHeight(200).sizeToFit()
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().height(100%).maxHeight(200).sizeToFit().align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().bottom().height(100%).maxHeight(200).sizeToFit().align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().bottom().maxHeight(200).sizeToFit().align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().height(10).minHeight(200).sizeToFit()
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().bottom().height(10).minHeight(200).sizeToFit().align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().bottom().height(10).minHeight(200).marginTop(10).sizeToFit().align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 8.0, height: 200.0)))
//            }
//            
//            it("should adjust the height when using sizeToFit") {
//                aView.sizeThatFitsExpectedArea = 40 * 40
//                aView.pin.top().bottom().height(200).marginTop(10).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 100.0, height: 200.0)))
//            }
//        }

        // Add these tests
        
        //        it("should adjust the size ") {
//        aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).align(.center)
//        expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 190.0)))
//        }
        
//        it("should adjust the size with sizeToFit()") {
//        aView.sizeThatFitsExpectedArea = 40 * 40

//        aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit().align(.center)
//        aView.pin.top(20).bottom(180).width(180).marginTop(10).sizeToFit().align(.center)
//        expect(aView.frame).to(equal(CGRect(x: 40.0, y: 120.66, width: 180.0, height: 9.0)))

//            expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
//        }
//        
//        it("should adjust the size with sizeToFit()") {
//            aView.pin.top(20).left(20).bottom(80).right(180).marginLeft(15).marginRight(5).marginTop(10).sizeToFit().align(.bottom)
//        expect(aView.frame).to(equal(CGRect(x: 35.0, y: 311.0, width: 180.0, height: 9.0)))

//            expect(aView.frame).to(equal(CGRect(x: 35.0, y: 30.0, width: 180.0, height: 9)))
//        }
        
        //aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
        
//        aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
        
        //
        // align + height
        //
//        describe("the result of the height(...) with align") {
//            it("should adjust the height and justify left aView") {
//                aView.pin.top().bottom().height(250)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
//            }
//            
//            it("should adjust the height and justify left aView") {
//                aView.pin.top().bottom().height(250).align(.top)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
//            }
//            
//            it("should adjust the width and align center aView") {
//                aView.pin.top().bottom().height(250).align(.center)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
//            }
//            
//            it("should adjust the width and align right aView") {
//                aView.pin.top().bottom().height(250).align(.bottom)
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
//            }
//            
//            it("should adjust the width and align left aView") {
//                aView.pin.top(50).bottom(50).height(200).align(.top)
//                let rect1 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 200.0)))
//
//                aView.pin.top().bottom().marginVertical(50).height(200).align(.top)
//                let rect2 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 200.0)))
//
//                expect(rect1).to(equal(rect2))
//            }
//            
//            it("should adjust the height and align center aView") {
//                aView.pin.top(50).bottom(50).height(200).align(.center)
//                let rect1 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))
//
//                aView.pin.top().bottom().marginVertical(50).height(200).align(.center)
//                let rect2 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))
//
//                expect(rect1).to(equal(rect2))
//            }
//            
//            it("should adjust the height and align bottom aView") {
//                aView.pin.top(50).bottom(50).height(200).align(.bottom)
//                let rect1 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 200.0)))
//
//                aView.pin.top().bottom().marginVertical(50).height(200).align(.bottom)
//                let rect2 = aView.frame
//                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 200.0)))
//
//                expect(rect1).to(equal(rect2))
//            }

        //////////////////////////////////////////////
        // Negative width
//        aView.pin.left(300).right(300)
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))
//(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["computed width (-200.0)", "greater than or equal to zero", "view will keep its current width"]))

        //////////////////////////////////////////////
        // Negative height??
        
//        aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
//        aView.pin.top(300).bottom(300)
//        expect(aView.frame).to(equal(CGRect(x: 40.0, y: 300.0, width: 100.0, height: 60.0)))
        //        expect(_pinlayoutUnitTestLastWarning).to(contain(["computed height (-200.0)", "greater than or equal to zero", "view will keep its current height"]))

        //////////////////////////////////////////////
        // TEST with the sizeToFit()!!!
        
//        aView.pin.left(50).right(50).width(200).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 200.0, height: 60.0)))
        
//        aView.pin.left(50).right(50).width(200).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
        
//        aView.pin.left(50).right(50).width(200).justify(.right)
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 200.0, height: 60.0)))
        
//        aView.pin.left().right().marginHorizontal(50).width(200).justify(.left)
//        expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 200.0, height: 60.0)))
        
//        aView.pin.left().right().marginHorizontal(50).width(200).justify(.center)
//        expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
        
//        aView.pin.left().right().marginHorizontal(50).width(200).justify(.right)
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 200.0, height: 60.0)))
        
        //////////////////////////////////////////////

//        start(to edge: HorizontalEdge
        
        //////////////////////////////////////////////

//        Pin.layoutDirection(.ltr)
//        aView.pin.start()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))
        
        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.end()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.end()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.start(20)
//        expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start(20)
//        expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.end(20)
//        expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.end(20)
//        expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.start(20%)
//        expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start(20%)
//        expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.end(20%)
//        expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.end(20%)
//        expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))
        
        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.start().end().marginStart(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 390.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start().end().marginStart(10)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 390.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.start().end().marginEnd(10)
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 390.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start().end().marginEnd(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 390.0, height: 60.0)))
        
        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.after(of: bView)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.after(of: bView)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.after(of: bView, aligned: .top)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))
        
//        Pin.layoutDirection(.rtl)
//        aView.pin.after(of: bView, aligned: .top)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.after(of: [bView])
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.after(of: [bView])
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.after(of: [bView], aligned: .bottom)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 140.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.after(of: [bView], aligned: .bottom)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 140.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.before(of: bView)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.before(of: bView)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.before(of: [bView])
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.before(of: [bView])
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.before(of: [bView], aligned: .top)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.before(of: [bView], aligned: .top)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.before(of: [bView], aligned: .bottom)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 140.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.before(of: [bView], aligned: .bottom)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 140.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.below(of: bView, aligned: .start)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 200.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.below(of: bView, aligned: .start)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 200.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.below(of: bView, aligned: .end)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 200.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.below(of: bView, aligned: .end)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 200.0, width: 100.0, height: 60.0)))
        
        //////////////////////////////////////////////
        // EDGES
        
//        Pin.layoutDirection(.ltr)
//        aView.pin.start(to: bView.edge.start)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start(to: bView.edge.start)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.start(to: bView.edge.end)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.start(to: bView.edge.end)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.end(to: bView.edge.start)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.end(to: bView.edge.start)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))

        //////////////////////////////////////////////
        // ANCHORS
//        Pin.layoutDirection(.ltr)
//        aView.pin.topStart()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.topStart()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.topEnd()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.topEnd()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))

//////////////////////////////////////////////
//        Pin.layoutDirection(.ltr)
//        aView.pin.centerStart()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.centerStart()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.centerEnd()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.centerEnd()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.bottomStart()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.bottomStart()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.bottomEnd()
//        expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.bottomEnd()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.topStart(to: bView.anchor.topStart)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 120.0, width: 100.0, height: 60.0)))
//
//        Pin.layoutDirection(.rtl)
//        aView.pin.topStart(to: bView.anchor.topStart)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.topStart(to: bView.anchor.topEnd)
//        expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.topStart(to: bView.anchor.topEnd)
//        expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.topEnd(to: bView.anchor.topEnd)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.topEnd(to: bView.anchor.topEnd)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 120.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.centerStart(to: bView.anchor.centerStart)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 130.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.centerStart(to: bView.anchor.centerStart)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 130.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.centerEnd(to: bView.anchor.centerEnd)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 130.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.centerEnd(to: bView.anchor.centerEnd)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 130.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.bottomStart(to: bView.anchor.bottomStart)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 140.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.bottomStart(to: bView.anchor.bottomStart)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 140.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.ltr)
//        aView.pin.bottomEnd(to: bView.anchor.bottomEnd)
//        expect(aView.frame).to(equal(CGRect(x: 170.0, y: 140.0, width: 100.0, height: 60.0)))

//        Pin.layoutDirection(.rtl)
//        aView.pin.bottomEnd(to: bView.anchor.bottomEnd)
//        expect(aView.frame).to(equal(CGRect(x: 160.0, y: 140.0, width: 100.0, height: 60.0)))

//        printViewFrame(aViewChild, name: "aViewChild")
//
//        printViewFrame(bView, name: "bView")
//        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func testMarginInsets() {
        rootView.frame = CGRect(x: 0, y: 64, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
        bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        aView.pin.top().bottom().left().right().margin(UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
        expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))

        if #available(iOS 11.0, *) {
            Pin.layoutDirection(.ltr)
            aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
            expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
            
            Pin.layoutDirection(.rtl)
            aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
            expect(aView.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 340.0, height: 360.0)))

            Pin.layoutDirection(.auto)
            aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
            expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
        }
        
        printViewFrame(aView, name: "aView")
    }
    
    func testFitWidthFitHeight() {
        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
        aView.sizeThatFitsExpectedArea = 40 * 40
        
        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)

        // fitWidth
//        aView.pin.fitWidth()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.width(50).fitWidth()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))
//
//        aView.pin.width(50).fitWidthHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 40.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.size(CGSize(width: 20, height: 100)).fitWidth()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 10.0, height: 160.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.size(CGSize(width: 20, height: 100)).fitWidthHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 160.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.fitHeight()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.fitHeightHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 60.0)))

//        aView.pin.width(50).fitSize()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.width(50).fitSizeHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 40.0)))

//        aView.sizeThatFitSizeOffset = 10
//        aView.pin.width(50).fitSize()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6666666666667)))

//        aView.sizeThatFitSizeOffset = 10
//        aView.pin.width(50).fitSizeHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6666666666667)))

//        aView.pin.height(50).fitSize()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.height(50).fitSize()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))

//        aView.sizeThatFitSizeOffset = -10
//        aView.pin.height(50).fitSizeHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 50.0)))
        
//        aView.sizeThatFitSizeOffset = 10
//        aView.pin.height(30).fitSize()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 30.0)))
//
//        aView.sizeThatFitSizeOffset = 10
//        aView.pin.height(30).fitSizeHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 30.0)))

//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6666666666667)))

//        aView.sizeThatFitSizeOffset = 10
//        aView.pin.width(50).fitSizeHard()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6666666666667)))

        printViewFrame(aView, name: "aView")
    }
    
    func testPinAll() {
        rootView.frame = CGRect(x: 0, y: 100, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
        bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)

//        aView.pin.all()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 400.0, height: 400.0)))

//        aView.pin.all().margin(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 380.0, height: 380.0)))

//        bViewChild.pin.all()
//        expect(bViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 110.0, height: 80.0)))

//        bViewChild.pin.all().margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 60.0)))

//        aView.pin.horizontally()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))

//        aView.pin.horizontally().margin(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 380.0, height: 100.0)))

//        bViewChild.pin.horizontally()
//        expect(bViewChild.frame).to(equal(CGRect(x: 0.0, y: 10.0, width: 110.0, height: 20.0)))

//        bViewChild.pin.horizontally().margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 20.0)))

//        aView.pin.vertically()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 200.0, height: 400.0)))

//        aView.pin.vertically().margin(10)
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 10.0, width: 200.0, height: 380.0)))

//        bViewChild.pin.vertically()
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 60.0, height: 80.0)))

//        bViewChild.pin.vertically().margin(10)
//        expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 60.0, height: 60.0)))

//        aView.pin.top(20).all()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["all() top coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.left(20).all()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["all() left coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.right(20).all()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["all() right coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.bottom(20).all()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["all() bottom coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.left(20).horizontally()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["horizontally() left coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.right(20).horizontally()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["horizontally() right coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.top(20).vertically()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["vertically() top coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.bottom(20).vertically()
//        expect(_pinlayoutUnitTestLastWarning).to(contain(["vertically() bottom coordinate", "won't be applied", "already been set to 20.0"]))

//        aView.pin.center(to: bView.anchor.topCenter).margin(100)//.width(containerWidth  - 2 * 5).fitSize()

//        aView.pin.vCenter(to: bView.edge.top).hCenter(to: bView.edge.hCenter)//.marginTop(20)
//        expect(aView.frame).to(equal(CGRect(x: 115.0, y: 70.0, width: 200.0, height: 100.0)))

//        aView.pin.center(to: bView.anchor.topCenter)
//        expect(aView.frame).to(equal(CGRect(x: 115.0, y: 70.0, width: 200.0, height: 100.0)))

//        aView.pin.vCenter(to: bView.edge.top).hCenter(to: bView.edge.hCenter).marginTop(40)
//        expect(aView.frame).to(equal(CGRect(x: 115.0, y: 110.0, width: 200.0, height: 100.0)))

//        aView.pin.center(to: bView.anchor.topCenter).marginTop(40)
//        expect(aView.frame).to(equal(CGRect(x: 115.0, y: 110.0, width: 200.0, height: 100.0)))

//        aView.pin.center(to: bView.anchor.topCenter).margin(20)//.width(containerWidth  - 2 * 5).fitSize()
        
        printViewFrame(aView, name: "aView")
//        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate class FakeExpectation {
        func to(_ value: Any) {
        }
    }
    fileprivate func expect(_ value: Any) -> FakeExpectation {
        return FakeExpectation()
    }
    
    fileprivate func equal(_ value: Any) {
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("expect(\(name).frame).to(equal(CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))))")
    }

    fileprivate func getAnchorList(forView view: UIView) -> [(String, Anchor)] {
        return [
            ("topLeft", view.anchor.topLeft),
            ("topCenter", view.anchor.topCenter),
            ("topRight", view.anchor.topRight),
            ("leftCenter", view.anchor.centerLeft),
            ("center", view.anchor.center),
            ("rightCenter", view.anchor.centerRight),
            ("bottomLeft", view.anchor.bottomLeft),
            ("bottomCenter", view.anchor.bottomCenter),
            ("bottomRight", view.anchor.bottomRight)
        ]
    }
}
