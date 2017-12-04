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
        var mainAxisOffset: CGFloat = 0
        let containerMainAxisLength = direction == .column ? container.height : container.width
        let containerCrossAxisLength = direction == .column ? container.width : container.height
        
        var startEndSpacing: CGFloat = 0
        var betweenSpacing: CGFloat = 0
        
        var maxX: CGFloat = 0
        var maxY: CGFloat = 0

        measuresItems(container: container)
    
        let mainAxisItemsLength = container.items.reduce(0, { (result, item) -> CGFloat in
            if direction == .column {
                return result + (item.height != nil ? item.height! : 0)
            } else {
                return result + (item.width != nil ? item.width! : 0)
            }
        })
        
        if let mainAxisLength = containerMainAxisLength {
            switch justifyContent {
            case .start:
                mainAxisOffset = 0
            case .center:
                mainAxisOffset = (mainAxisLength - mainAxisItemsLength) / 2
            case .end:
                mainAxisOffset = mainAxisLength - mainAxisItemsLength
            case .spaceBetween:
                betweenSpacing = (mainAxisLength - mainAxisItemsLength) / CGFloat(container.items.count - 1)
            case .spaceAround:
                betweenSpacing = (mainAxisLength - mainAxisItemsLength) / CGFloat(container.items.count)
                startEndSpacing = betweenSpacing / 2
            case .spaceEvenly:
                betweenSpacing = (mainAxisLength - mainAxisItemsLength) / CGFloat(container.items.count + 1)
                startEndSpacing = betweenSpacing
            }
        }
        
        let itemCount = container.items.count
        for (index, item) in container.items.enumerated() {
            var crossAxisPos: CGFloat = 0
            let itemMainAxisLength = direction == .column ? item.height! : item.width!
            var itemCrossAxisLength = direction == .column ? item.width! : item.height!
            
            if let crossAxisLength = containerCrossAxisLength {
                switch resolveStackItemAlign(item) {
                case .stretch: itemCrossAxisLength = crossAxisLength
                case .start:   /* nop */ break
                case .center:  crossAxisPos = (crossAxisLength - itemCrossAxisLength) / 2
                case .end:     crossAxisPos = crossAxisLength - itemCrossAxisLength
                }
            }
            
            if index == 0 || index == itemCount {
                mainAxisOffset += startEndSpacing
            } else {
                mainAxisOffset += betweenSpacing
            }
        
            if direction == .column {
                item.view.frame = CGRect(x: crossAxisPos, y: mainAxisOffset, width: itemCrossAxisLength, height: itemMainAxisLength)
            } else {
                item.view.frame = CGRect(x: mainAxisOffset, y: crossAxisPos, width: itemMainAxisLength, height: itemCrossAxisLength)
            }
            
            mainAxisOffset = direction == .column ? item.view.frame.maxY :  item.view.frame.maxX
            
            maxX = max(item.view.frame.maxX, maxX)
            maxY = max(item.view.frame.maxY, maxY)
        }
        
        return CGSize(width: maxX, height: maxY)
    }
    
    private func measuresItems(container: Container) {
        stackItems.forEach{ (stackItem) in
            let view = stackItem.view
            guard !view.isHidden else { return }
            guard let stackItem = view.item as? StackItemImpl else { return }
            
            let item = ItemInfo(stackItem, container: container)
            var fitWidth: CGFloat?
            var fitHeight: CGFloat?

            if let containerHeight = container.height, item.height ==  nil {
                fitHeight = containerHeight
            }
            
            if let containerWidth = container.width, item.width ==  nil {
                fitWidth = containerWidth
            }
            
            // Measure the view using sizeThatFits(:CGSize)
            if let fitWidth = fitWidth, item.width == nil {
                let newSize = view.sizeThatFits(CGSize(width: fitWidth, height: .greatestFiniteMagnitude))
                item.width = newSize.width
                item.height = newSize.height
            } else if let fitHeight = fitHeight, item.height != nil {
                let newSize = view.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: fitHeight))
                item.width = newSize.width
                item.height = newSize.height
            }
            
            item.width = applyWidthMinMax(item)
            item.height = applyHeightMinMax(item)
            
            container.items.append(item)
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
