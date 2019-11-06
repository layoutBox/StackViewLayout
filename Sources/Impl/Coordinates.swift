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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

public func _setUnitTestDisplayScale(scale: CGFloat) {
    Coordinates.displayScale = scale
}

class Coordinates {
    internal static var displayScale: CGFloat = UIScreen.main.scale
    internal static var onePixelLength: CGFloat = 1 / UIScreen.main.scale

    static func adjustRectToDisplayScale(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.origin.x.roundUsingDisplayScale(),
                      y: rect.origin.y.roundUsingDisplayScale(),
                      width: rect.size.width.roundUsingDisplayScale(),
                      height: rect.size.height.roundUsingDisplayScale())
    }
    
    static func setUntransformedViewRect(_ view: UIView, toRect rect: CGRect) {
        /*
         To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
         view's transform (UIView.transform).
         By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
         the view's transform. So view's transforms won't be affected/altered by PinLayout.
         */
        let adjustedRect = Coordinates.adjustRectToDisplayScale(rect)

        // NOTE: The center is offset by the layer.anchorPoint, so we have to take it into account.
        view.center = CGPoint(x: adjustedRect.origin.x + (adjustedRect.width * view.layer.anchorPoint.x),
                              y: adjustedRect.origin.y + (adjustedRect.height * view.layer.anchorPoint.y))
        // NOTE: We must set only the bounds's size and keep the origin.
        view.bounds.size = adjustedRect.size
    }

    static func getUntransformedViewRect(_ view: UIView) -> CGRect {
        /*
         To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
         view's transform (UIView.transform).
         By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
         the view's transform. So view's transforms won't be affected/altered by PinLayout.
         */
        let size = view.bounds.size
        // See setUntransformedViewRect(...) for details about this calculation.
        let origin = CGPoint(x: view.center.x - (size.width * view.layer.anchorPoint.x),
                             y: view.center.y - (size.height * view.layer.anchorPoint.y))

        return CGRect(origin: origin, size: size)
    }
}

extension CGFloat {
    func roundUsingDisplayScale() -> CGFloat {
        return (self * Coordinates.displayScale).rounded(.toNearestOrAwayFromZero) / Coordinates.displayScale
    }

    func ceilUsingDisplayScale() -> CGFloat {
        return (self * Coordinates.displayScale).rounded(.up) / Coordinates.displayScale
    }

    func floorUsingDisplayScale() -> CGFloat {
        return (self * Coordinates.displayScale).rounded(.down) / Coordinates.displayScale
    }
}

func minValueOptional(_ value1: CGFloat, _ value2: CGFloat?) -> CGFloat {
    return min(value1, value2 ?? .greatestFiniteMagnitude)
}

#endif
