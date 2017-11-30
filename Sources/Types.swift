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
    case columnReverse
    /// The flexible items are displayed horizontally, as a row.
    case row
    /// Same as row, but in reverse order
    case rowReverse
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
    /// Items are positioned with space between the lines
    case spaceBetween
    /// Items are positioned with space before, between, and after the lines
    case spaceAround
}

/**
 */
public enum SAlignContent {
    /// Default value. Lines stretch to take up the remaining space
    case stretch
    /// Lines are packed toward the start of the flex container
    case start
    /// Lines are packed toward the center of the flex container
    case center
    /// Lines are packed toward the end of the flex container
    case end
    /// Lines are evenly distributed in the flex container
    case spaceBetween
    /// Lines are evenly distributed in the flex container, with half-size spaces on either end    Play it »
    case spaceAround
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
    /// Items are positioned at the baseline of the container
    case baseline
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
