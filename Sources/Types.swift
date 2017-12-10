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

/**
 */
public enum SDirection {
    /// Default value. The flexible items are displayed vertically, as a column.
    case column
    /// Same as column, but in reverse order
//    case columnReverse
    /// The flexible items are displayed horizontally, as a row.
    case row
    /// Same as row, but in reverse order
//    case rowReverse
}

/**
 */
public enum SJustifyContent {
    /// Default value. Items are positioned at the beginning of the container.
    case start
    /// Items are positioned at the center of the container
    case center
    /// Items are positioned at the end of the container
    case end
    /// Items are positioned with space between items
    case spaceBetween
    /// Items are positioned with space before, between, and after items
    case spaceAround
    /// Items are positioned with space before, between, and after items
    case spaceEvenly
}

/**
 */
public enum SAlignItems {
    /// Default. Items are stretched to fit the container
    case stretch
    /// Items are positioned at the beginning of the container
    case start
    /// Items are positioned at the center of the container
    case center
    /// Items are positioned at the end of the container
    case end
}

public enum SAlignSelf {
    /// Default. The element inherits its parent container's align-items property, or "stretch" if it has no parent container
    case auto
    /// The element is positioned to fit the container
    case stretch
    /// The element is positioned at the beginning of the container
    case start
    /// The element is positioned at the center of the container
    case center
    /// The element is positioned at the end of the container
    case end
    /// The element is positioned at the baseline of the container
    //        case baseline
}

/**
 Defines how the `layout(mode:)` method layout its flex items.
 */
public enum SLayoutMode {
    /// This is the default mode when no parameter is specified. Children are layouted **inside** the container's size (width and height).
    case fitContainer
    /// In this mode, children are layouted **using only the container's width**. The container's height will be adjusted to fit the flexbox's children
    case adjustHeight
    /// In this mode, children are layouted **using only the container's height**. The container's width will be adjusted to fit the flexbox's children
    case adjustWidth
}
