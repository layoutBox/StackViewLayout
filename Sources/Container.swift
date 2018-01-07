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

import UIKit

class Container {
    let direction: SDirection
    var width: CGFloat?
    var height: CGFloat?
    var items: [ItemInfo] = []
    
    var mainAxisLength: CGFloat? {
        return direction == .column ? height : width
    }
    
    var crossAxisLength: CGFloat? {
        return direction == .column ? width : height
    }
    
    var mainAxisTotalItemsLength: CGFloat = 0
    
    init(direction: SDirection) {
        self.direction = direction
    }
    
    func updateMainAxisTotalLength() {
        mainAxisTotalItemsLength = 0
        
        items.forEach({ (item) in
            mainAxisTotalItemsLength += item.mainAxisStartMargin ?? 0
            
            if direction == .column {
                mainAxisTotalItemsLength += (item.height != nil ? item.height! : 0)
            } else {
                mainAxisTotalItemsLength += (item.width != nil ? item.width! : 0)
            }
            
            mainAxisTotalItemsLength += item.mainAxisEndMargin ?? 0
        })
    }
    
    func growFactorTotal() -> CGFloat {
        return items.reduce(0, { (result, itemInfo) -> CGFloat in
            return result + itemInfo.growFactor()
        })
    }
    
    func shrinkFactorTotal() -> CGFloat {
        return items.reduce(0, { (result, itemInfo) -> CGFloat in
            return result + itemInfo.shrinkFactor()
        })
    }
}

