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
    
    
class Container {
    var width: CGFloat?
    var height: CGFloat?
    var items: [ItemInfo] = []
}
    
//class ParentInfo {
//    var width: CGFloat
//    var height: CGFloat
//}
    
class ItemInfo {
    var view: UIView
    var stackItem: StackItemImpl
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?

    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
//    var parent: ParentInfo?
    
    init(_ stackItem: StackItemImpl, container: Container) {
        self.stackItem = stackItem
        self.view = stackItem.view
//        self.parent = parent
        
        if let stackItem = view.item as? StackItemImpl {
            self.width = resolveWidthValue(stackItem.width, container: container)
            self.minWidth = resolveWidthValue(stackItem.minWidth, container: container)
            self.maxWidth = resolveWidthValue(stackItem.maxWidth, container: container)
            
            self.height = resolveHeightValue(stackItem.height, container: container)
            self.minHeight = resolveHeightValue(stackItem.minHeight, container: container)
            self.maxHeight = resolveHeightValue(stackItem.maxHeight, container: container)
        }
    }
}
    
extension StackLayoutView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let container = Container()
        container.width = frame.size.width
        container.height = frame.size.height
        layoutItems(container: container, measure: false)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let container = Container()
        container.width = size.width == CGFloat.greatestFiniteMagnitude ? nil : size.width
        container.height = size.height == CGFloat.greatestFiniteMagnitude ? nil : size.height
        let size = layoutItems(container: container, measure: true)
        return size
    }
    
    @discardableResult
    private func layoutItems(container: Container, measure: Bool) -> CGSize {
        
        measuresItems(container: container)
        
        let totalHeight = container.items.reduce(0, { (result, item) -> CGFloat in
            return result + (item.height != nil ? item.height! : 0)
        })
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0
        var startEndSpacing: CGFloat = 0
        var betweenSpacing: CGFloat = 0
        
        switch justifyContent {
        case .start:
            yOffset = 0
        case .center:
            if let containerHeight = container.height {
                yOffset = (containerHeight - totalHeight) / 2
            }
        case .end:
            if let containerHeight = container.height {
                yOffset = containerHeight - totalHeight
            }
        case .spaceBetween:
            if let containerHeight = container.height {
                betweenSpacing = (containerHeight - totalHeight) / CGFloat(container.items.count - 1)
            }
        case .spaceAround:
            if let containerHeight = container.height {
                betweenSpacing = (containerHeight - totalHeight) / CGFloat(container.items.count)
                startEndSpacing = betweenSpacing / 2
            }
        case .spaceEvenly:
            if let containerHeight = container.height {
                betweenSpacing = (containerHeight - totalHeight) / CGFloat(container.items.count + 1)
                startEndSpacing = betweenSpacing
            }
        }
        
        let itemCount = container.items.count
        for (index, item) in container.items.enumerated() {
            var x = xOffset
            var width = item.width!
            
            if let containerWidth = container.width {
                switch resolveStackItemAlign(item) {
                case .stretch: width = containerWidth
                case .start:   /* nop */ break
                case .center:  x = (containerWidth - item.width!) / 2
                case .end:     x = containerWidth - item.width!
                }
            }
            
            if index == 0 || index == itemCount {
                yOffset += startEndSpacing
            } else {
                yOffset += betweenSpacing
            }
            
            item.view.frame = CGRect(x: x, y: yOffset, width: width, height: item.height!)
            
            if item.view.frame.maxX > maxX {
                maxX = item.view.frame.maxX
            }
            if item.view.frame.maxY > maxY {
                maxY = item.view.frame.maxY
            }
            
            yOffset = item.view.frame.maxY
        }
        
        return CGSize(width: maxX, height: maxY)
    }
    
    private func measuresItems(container: Container) {
        stackItems.forEach{ (stackItem) in
            let view = stackItem.view
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let item = ItemInfo(stackItem, container: container)
            
            if self.direction == .column {
                if let containerWidth = container.width {
                    if item.width ==  nil {
                        item.width = containerWidth
                    }
                }
                
                if container.height != nil {
                    if let itemHeight = stackItem.height?.value {
                        item.height = itemHeight
                    }
                }
                
                // Measure the view
                if item.width != nil && item.height == nil {
                    let newSize = view.sizeThatFits(CGSize(width: item.width!, height: .greatestFiniteMagnitude))
                    item.width = newSize.width
                    item.height = newSize.height
                } else if item.width == nil && item.height != nil {
                    let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: item.height!))
                    item.width = newSize.width
                    item.height = newSize.height
                }
                
                if alignItems == .stretch, let containerWidth = container.width {
                    item.width = containerWidth
                }
                
                item.width = applyWidthMinMax(item)
                item.height = applyHeightMinMax(item)
                
                container.items.append(item)
            }
        }
    }
    
    func resolveStackItemAlign(_ item: ItemInfo) -> SAlignItems {
        let align: SAlignItems
        
        if let selfAlign = item.stackItem.alignSelf {
            switch selfAlign {
            case .auto:    align = alignItems
            case .stretch: align = .stretch
            case .start:   align = .start
            case .center:  align = .center
            case .end:     align = .end
            }
        } else {
            align = alignItems
        }
        
        return align
    }
}
    
private func resolveWidthValue(_ value: Value?, container: Container) -> CGFloat? {
    guard let value = value else { return nil }
    switch value.unit {
    case .point:   return value.value
    case .percent: return container.width != nil ? (container.width! * value.value / 100) : nil
    }
}

private func resolveHeightValue(_ value: Value?, container: Container) -> CGFloat? {
    guard let value = value else { return nil }
    switch value.unit {
    case .point:   return value.value
    case .percent: return container.height != nil ? (container.height! * value.value / 100) : nil
    }
}
    
private func applyWidthMinMax(_ item: ItemInfo) -> CGFloat? {
    var result = item.width
    //        var stackItem = itemInfo.view.item
    
    // Handle minWidth
    if let minWidth = item.minWidth, minWidth > (result ?? 0) {
        result = minWidth
    }
    
    // Handle maxWidth
    if let maxWidth = item.maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxWidth
    }
    
    return result
}
    
private func applyHeightMinMax(_ item: ItemInfo) -> CGFloat? {
    var result = item.height
    //        var stackItem = item.view.item
    // Handle minHeight
    if let minHeight = item.minHeight, minHeight > (result ?? 0) {
        result = minHeight
    }
    
    // Handle maxHeight
    if let maxHeight = item.maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude) {
        result = maxHeight
    }
    
    return result
}

#endif
