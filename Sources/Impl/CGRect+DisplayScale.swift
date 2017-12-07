//
//  CGRect+DisplayScale.swift
//  StackLayout
//
//  Created by DION, Luc (MTL) on 2017-12-07.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

internal let displayScale: CGFloat = UIScreen.main.scale

extension CGRect {
    func adjustToDisplayScale() -> CGRect {
        return CGRect(x: floorFloatToDisplayScale(origin.x),
                      y: floorFloatToDisplayScale(origin.y),
                      width: ceilFloatToDisplayScale(size.width),
                      height: ceilFloatToDisplayScale(size.height))
    }
    
    private func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(ceilf(Float(pointValue * displayScale))) / displayScale
    }
    
    private func floorFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(floorf(Float(pointValue * displayScale))) / displayScale
    }
}
