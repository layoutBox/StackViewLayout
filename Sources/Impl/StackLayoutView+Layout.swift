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
    
    
struct ParentInfo {
    var width: CGFloat?
    var height: CGFloat?
}
    
struct ItemInfo {
    var view: UIView
//    var stackItem: StackItemImpl
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?

    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
    var parent: ParentInfo?
    
    init(_ view: UIView, parent: ParentInfo) {
        self.view = view
        self.parent = parent
        
        if let stackItem = view.item as? StackItemImpl {
            self.width = resolveWidthValue(stackItem.width)
            self.minWidth = resolveWidthValue(stackItem.minWidth)
            self.maxWidth = resolveWidthValue(stackItem.maxWidth)
            
            self.height = resolveHeightValue(stackItem.height)
            self.minHeight = resolveHeightValue(stackItem.minHeight)
            self.maxHeight = resolveHeightValue(stackItem.maxHeight)
        }
    }
    
    func resolveWidthValue(_ value: Value?) -> CGFloat? {
        guard let value = value else { return nil }
        switch value.unit {
        case .point:   return value.value
        case .percent: return parent!.width! * value.value / 100
        }
    }
    
    func resolveHeightValue(_ value: Value?) -> CGFloat? {
        guard let value = value else { return nil }
        switch value.unit {
        case .point:   return value.value
        case .percent: return parent!.height! * value.value / 100
        }
    }
}
    
extension StackLayoutView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let parentInfo = ParentInfo(width: frame.size.width, height: frame.size.height)
        layoutItems(parent: parentInfo, measure: false)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let parentInfo = ParentInfo(width: size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width,
                                    height: size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height)
        let size = layoutItems(parent: parentInfo, measure: true)
        return size
    }

    @discardableResult
    func layoutItems(parent: ParentInfo, measure: Bool) -> CGSize {
        var items: [ItemInfo] = []
        var totalHeight: CGFloat = 0
        
        subviews.forEach{ (view) in
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            var itemInfo = ItemInfo(view, parent: parent)
            
            if self.direction == .column {
                if parent.width != nil {
                    if itemInfo.width ==  nil {
                        itemInfo.width = parent.width!
                    }
                }
                
                if parent.height != nil {
                    if let itemHeight = stackItem.height?.value {
                        itemInfo.height = itemHeight
                    }
                }
            
                // Measure the view
                if itemInfo.width != nil && itemInfo.height == nil {
                    let newSize = view.sizeThatFits(CGSize(width: itemInfo.width!, height: .greatestFiniteMagnitude))
                    itemInfo.width = newSize.width
                    itemInfo.height = newSize.height
                } else if itemInfo.width == nil && itemInfo.height != nil {
                    let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: itemInfo.height!))
                    itemInfo.width = newSize.width
                    itemInfo.height = newSize.height
                }
                
                if alignItems == .stretch {
                    itemInfo.width = parent.width!
                }
                
                itemInfo.width = resolveWidth(itemInfo)
                itemInfo.height = resolveHeight(itemInfo)
                totalHeight += (itemInfo.height != nil ? itemInfo.height! : 0)

                items.append(itemInfo)
            }
        }
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        
        switch justifyContent {
        case .start:
            yOffset = 0
        case .center:
            yOffset = (parent.height! - totalHeight) / 2
        case .end:
            yOffset = parent.height! - totalHeight
        case .spaceBetween:
            assert(false)
        case .spaceAround:
            assert(false)
        }
        
        items.forEach({ (itemInfo) in
            var x = xOffset
            var width = itemInfo.width!
            
            if let parentWidth = parent.width {
                switch alignItems {
                case .stretch: width = parentWidth
                case .start:   break
                case .center:  x = (parentWidth - itemInfo.width!) / 2
                case .end:     x = parentWidth - itemInfo.width!
                }
            }
            itemInfo.view.frame = CGRect(x: x, y: yOffset, width: width, height: itemInfo.height!)
            
            if itemInfo.view.frame.maxX > maxX {
                maxX = itemInfo.view.frame.maxX
            }
            if itemInfo.view.frame.maxY > maxY {
                maxY = itemInfo.view.frame.maxY
            }
            
            yOffset = itemInfo.view.frame.maxY
        })
        
        return CGSize(width: maxX, height: maxY)
    }
    
    private func resolveWidth(_ itemInfo: ItemInfo) -> CGFloat? {
        var result = itemInfo.width
//        var stackItem = itemInfo.view.item
        
        // Handle minWidth
        if let minWidth = itemInfo.minWidth, minWidth > (result ?? 0) {
            result = minWidth
        }
        
        // Handle maxWidth
        if let maxWidth = itemInfo.maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude) {
            result = maxWidth
        }
        
        return result
    }
    
    private func resolveHeight(_ itemInfo: ItemInfo) -> CGFloat? {
        var result = itemInfo.height
//        var stackItem = itemInfo.view.item
        
        // Handle minHeight
        if let minHeight = itemInfo.minHeight, minHeight > (result ?? 0) {
            result = minHeight
        }
        
        // Handle maxHeight
        if let maxHeight = itemInfo.maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude) {
            result = maxHeight
        }
        
        return result
    }

}

#endif
