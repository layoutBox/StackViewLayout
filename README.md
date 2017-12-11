<p align="center">
  <a href="https://github.com/layoutBox/StackLayout"><img src="docs_markdown/images/stacklayout_logo_text.png" width="260"/></a>
</p>

 
<p align="center">
  <a href=""><img src="https://img.shields.io/cocoapods/p/StackLayout.svg?style=flat" /></a>
  <a href="https://travis-ci.org/layoutBox/StackLayout"><img src="https://travis-ci.org/layoutBox/StackLayout.svg?branch=dev" /></a>
 <a href='https://coveralls.io/github/layoutBox/StackLayout?branch=dev'><img src='https://coveralls.io/repos/github/layoutBox/StackLayout/badge.svg?branch=dev' alt='Coverage Status' /></a>
  <a href='https://img.shields.io/cocoapods/v/StackLayout.svg'><img src="https://img.shields.io/cocoapods/v/StackLayout.svg" /></a>
  <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a>
  <a href="https://raw.githubusercontent.com/layoutBox/StackLayout/master/LICENSE"><img src="https://img.shields.io/badge/license-New%20BSD-blue.svg?style=flat" /></a>
</p>

<br>

StackLayout is a UIStackView replacement.


### Requirements
* iOS 9.0+
* Xcode 8.0+ / Xcode 9.0
* Swift 3.0+ / Swift 4.0

### Content

* [Introduction examples](#intro_usage_example)
* [StackLayout principles and philosophy](#introduction)
* [Performance](#performance)
* [Documentation](#documentation)
	* [Creation, modification and definition of flexbox containers](#create_modify_define_containers)
	* [Flexbox containers properties](#containers_properties)
	* [Flexbox items properties](#intems_properties)
	* [Absolute positioning](#absolute_positioning)
	* [Adjusting the size](#adjusting_size)
		* [Width, height and size](#width_height_size)
		* [minWidth, maxWidth, minHeight, maxHeight](#minmax_width_height_size)
		* [Aspect Ratio](#aspect_ratio)
	* [Margins](#margins)
	* [Paddings](#paddings)
	* [Borders](#borders)
* [API Documentation](#api_documentation)
* [Examples App](#examples_app)
* [FAQ](#faq)
* [Comments, ideas, suggestions, issues, ....](#comments)
* [Installation](#installation)

<br>

:pushpin: StackLayout is actively updated. So please come often to see latest changes. You can also **Star** it to be able to retrieve it easily later.

<br>

### StackLayout + PinLayout + FlexLayout

<a href="https://github.com/mirego/PinLayout"><img src="docs_markdown/images/flexlayout_plus_pinlayout_small.png" width="250"/></a>

**FlexLayout** is a companion of **[PinLayout](https://github.com/mirego/PinLayout)**. They share a similar syntax and method names. PinLayout is a layout framework greatly inspired by CSS absolute positioning, it is particularly useful for greater fine control and animations. It gives you full control by layouting one view at a time (simple to code and debug).

* A view can be layouted using FlexLayout, PinLayout, or both!
* PinLayout can layout anything, but in situations where you need to layout many views but don't require PinLayout's finest control nor complex animations, FlexLayout is best fitted. 
* A view layouted using PinLayout can be embedded inside a FlexLayout's container and reversely. You choose the best layout framework for your situation. 

<br>
 
## StackLayout Introduction examples <a name="intro_usage_example"></a>
###### Example 1:


```swift
fileprivate let stactLayout = StackLayoutView()

init() {
   super.init(frame: .zero)
   
   addSubview(stactLayout)
   ...

   label1 = UILabel()
    label1.backgroundColor = .red
    label1.font = UIFont.systemFont(ofSize: 17)
    label1.text = "Label 1"
    
    label2 = UILabel()
    label2.font = UIFont.systemFont(ofSize: 17)
    label2.backgroundColor = .green
    label2.text = "Label longuer"
    
    label3 = UILabel()
    label3.font = UIFont.systemFont(ofSize: 17)
    label3.backgroundColor = .blue
    label3.text = "Label much longuer"
        
    stackLayoutView.direction(.column).justifyContent(.spaceAround)
    stackLayoutView.addItem(label1)
    stackLayoutView.addItem(label2)
    stackLayoutView.addItem(label3)
}

override func layoutSubviews() {
    super.layoutSubviews() 

    // 1) Layout the StackLayoutView. This example use PinLayout for that purpose, but it could be done 
    //    also by setting the rootFlexContainer's frame:
    //       stackLayoutView.pin.top.frame = CGRect(x: 0, y: topLayoutGuide, 
    //                                        width: frame.width, height: 
    stackLayoutView.pin.top(80).left().width(400).height(600)
}
``` 

:pushpin: This example is available in the [Examples App](#examples_app). See complete [source code](https://github.com/layoutBox/StackLayout/blob/master/Example/StackLayoutSample/UI/Examples/Intro/IntroView.swift)

</br>


## StackLayout principles and philosophy <a name="introduction"></a>

TO BE DOCUMENTED

<br>

# StackLayout's Performance <a name="performance"></a>

TO BE DOCUMENTED

<br/>
	
### StackLayout default properties

| Property     | StackLayout default value |
|--------------|--------------------------|
| **`direction`** | column |
| **`justifyContent`** | start |
| **`alignItems`** | stretch |
| **`alignSelf`** | auto |
| **`grow`** | 0 |
| **`shrink`** | 0 |
| **`basis`** | 0 |

<br>

# Documentation <a name="documentation"></a>

TO BE DOCUMENTED

<br>

## 1. Creation, modification and definition of flexbox items <a name="create_modify_define_containers"></a>


TO BE DOCUMENTED

<br>

## 2. StackLayoutView properties  <a name="containers_properties"></a>
This section describes all flex container's properties.

### direction() 
- Values: `column` / `row`
- Default value: `column`

**Method:**

* **`direction(_: SDirection)`**  
The `direction` property establishes the main-axis, thus defining the direction items are placed in the StackLayoutView.

TO BE DOCUMENTED

| Value | Result | Description |
|---------------------|:------------------:|---------|
| **column** (default) 	| <img src="docs_markdown/images/flexlayout-direction-column.png" width="100"/>| Top to bottom |
| **row** | <img src="docs_markdown/images/flexlayout-direction-row.png" width="190"/>| Same as text direction |


###### Usage examples:
```swift
  stackLayoutView.direction(.column)  // Not required, defaut value. 
  stackLayoutView.direction(.row)
```

###### Example 1:

TODO

<br/>

### justifyContent()
- Values: `start` / `end` / `center` / `spaceBetween` / `spaceAround`
- Default value: `start`

**Method:**

* **`justifyContent(_: JustifyContent)`**  
The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container. It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum size. For example, if children are flowing vertically, `justifyContent` controls how they align vertically. 

|                     	| direction(.column) | direction(.row) | |
|---------------------	|:------------------:|:---------------:|:--|
| **start** (default) 	| <img src="docs_markdown/images/flexlayout-justify-column-flexstart.png" width="140"/>| <img src="docs_markdown/images/flexlayout-justify-row-flexstart.png" width="160"/>| Items are packed at the beginning of the main-axis. |
| **end**	| <img src="docs_markdown/images/flexlayout-justify-column-flexend.png" width="140"/>| <img src="docs_markdown/images/flexlayout-justify-row-flexend.png" width="160"/>| Items are packed at the end of the main-axis. |
| **center** 	| <img src="docs_markdown/images/flexlayout-justify-column-center.png" width="140"/>| <img src="docs_markdown/images/flexlayout-justify-row-center.png" width="160"/>| items are centered along the main-axis. |
| **spaceBetween** 	| <img src="docs_markdown/images/flexlayout-justify-column-spacebetween.png" width="140"/>| <img src="docs_markdown/images/flexlayout-justify-row-spacebetween.png" width="160"/> | Items are evenly distributed in the main-axis; first item is at the beginning, last item at the end. |
| **spaceAround** 	| <img src="docs_markdown/images/flexlayout-justify-column-spacearound.png" width="140"/> | <img src="docs_markdown/images/flexlayout-justify-row-spacearound.png" width="160"/> | Items are evenly distributed in the main-axis with equal space around them. |
| **evenly** 	| <img src="docs_markdown/images/flexlayout-justify-column-evenly.png" width="140"/> | <img src="docs_markdown/images/flexlayout-justify-row-evenly.png" width="160"/> |  |

###### Usage examples:
```swift
  stackLayoutView.justifyContent(.start)  // defaut value. 
  stackLayoutView.justifyContent(.center)
```
<br/>

### alignItems()
- Values: `stretch` / `start` / `end` / `center`
- Default value: `stretch `

**Method:**

* **`alignItems(_: AlignItems)`**  
The `alignItems` property defines how flex items are laid out along the cross axis on the current line. Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, if children are flowing vertically, `alignItems` controls how they align horizontally. 


|                     	| direction(.column) | direction(.row) |
|---------------------	|:------------------:|:---------------:|
| **stretch** (default) 	| <img src="docs_markdown/images/flexlayout-align-column-stretch.png" width="140"/>| <img src="docs_markdown/images/flexlayout-align-row-stretch.png" width="160"/>|
| **start**	| <img src="docs_markdown/images/flexlayout-align-column-flexStart.png" width="140"/>| <img src="docs_markdown/images/flexlayout-align-row-flexStart.png" width="160"/>|
| **end**	| <img src="docs_markdown/images/flexlayout-align-column-flexEnd.png" width="140"/>| <img src="docs_markdown/images/flexlayout-align-row-flexEnd.png" width="160"/>|
| **center** 	| <img src="docs_markdown/images/flexlayout-align-column-center.png" width="140"/>| <img src="docs_markdown/images/flexlayout-align-row-center.png" width="160"/>|

<br/>

## 3. StackLayoutView items property <a name="containers_properties"></a>
This section describes all StackLayoutView's items properties.

### alignSelf()
- Values: `auto` / `stretch` / `start` / `end` / `center`
- Default value: `auto`

**Method:**

* **`alignSelf(_: AlignSelf)`**  
The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems` of the parent. For example, if children are flowing vertically, `alignSelf` will control how the flex item will align horizontally. 

The `auto` value means use the stack view `alignItems` property. See `alignItems` for documentation of the other values.

<br/>


## 5. Adjusting the size  <a name="adjusting_size"></a> 

### Width and height and size <a name="width_height_size"></a>

FlexLayout has methods to set the view’s height and width.

**Methods:**

* **`width(_ width: CGFloat?)`**  
The value specifies the view's width in pixels. The value must be non-negative. Call `width(nil)` to reset the property.
* **`width(_ percent: FPercent)`**  
The value specifies the view's width in percentage of its container width. The value must be non-negative. Call `width(nil)` to reset the property.
* **`height(_ height: CGFloat?)`**  
The value specifies the view's height in pixels. The value must be non-negative. Call `height(nil)` to reset the property.
* **`height(_ percent: FPercent)`**  
The value specifies the view's height in percentage of its container height. The value must be non-negative. Call `height(nil)` to reset the property.
* **`size(_ size: CGSize?)`**  
The value specifies view's width and the height in pixels. Values must be non-negative. Call `size(nil)` to reset the property.
* **`size(_ sideLength: CGFloat?)`**  
The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative. Call `size(nil)` to reset the property.


###### Usage examples:
```swift
  view.item.width(100)	
  view.item.width(50%)	
  view.item.height(200)
	
  view.item.size(250)
```
<br>

### minWidth(), maxWidth(), minHeight(), maxHeight() <a name="minmax_width_height_size"></a>

FlexLayout has methods to set the view’s minimum and maximum width, and minimum and maximum height. 

Using minWidth, minHeight, maxWidth, and maxHeight gives you increased control over the final size of items in a layout. By mixing these properties with `grow`, `shrink`, and `alignItems(.stretch)`, you are able to have items with dynamic size within a range which you control.

An example of when Max properties can be useful is if you are using `alignItems(.stretch)` but you know that your item won’t look good after it increases past a certain point. In this case, your item will stretch to the size of its parent or until it is as big as specified in the Max property.

Same goes for the Min properties when using `shrink`. For example, you may want children of a container to shrink to fit on one row, but if you specify a minimum width, they will break to the next line after a certain point (if you are using `wrap(.wrap)`.

Another case where Min and Max dimension constraints are useful is when using `aspectRatio`.


**Methods:**

* **`minWidth(_ width: CGFloat?)`**  
The value specifies the view's minimum width of the view in pixels. The value must be non-negative. Call `minWidth(nil)` to reset the property.
* **`minWidth(_ percent: FPercent)`**  
The value specifies the view's minimum width of the view in percentage of its container width. The value must be non-negative. Call `minWidth(nil)` to reset the property..
* **`maxWidth(_ width: CGFloat?)`**  
The value specifies the view's maximum width of the view in pixels. The value must be non-negative. Call `maxWidth(nil)` to reset the property.
* **`maxWidth(_ percent: FPercent)`**  
The value specifies the view's maximum width of the view in percentage of its container width. The value must be non-negative. Call `maxWidth(nil)` to reset the property.
* **`minHeight(_ height: CGFloat?)`**  
The value specifies the view's minimum height of the view in pixels. The value must be non-negative. Call `minHeight(nil)` to reset the property.
* **`minHeight(_ percent: FPercent)`**  
The value specifies the view's minimum height of the view in percentage of its container height. The value must be non-negative. Call `minHeight(nil)` to reset the property.
* **`maxHeight(_ height: CGFloat?)`**  
The value specifies the view's maximum height of the view in pixels. The value must be non-negative. Call `maxHeight(nil)` to reset the property.
* **`maxHeight(_ percent: FPercent)`**  
The value specifies the view's maximum height of the view in percentage of its container height. The value must be non-negative. Call `maxHeight(nil)` to reset the property.
   
###### Usage examples:
```swift
  view.item.maxWidth(200)
  view.item.maxWidth(50%)
  view.item.width(of: view1).maxWidth(250)
	
  view.item.maxHeight(100)
  view.item.height(of: view1).maxHeight(30%)
```
<br>

### aspectRatio() <a name="aspect_ratio"></a>

NOT IMPLEMENTED

<br/>


## 6. Margins <a name="margins"></a>

NOT IMPLEMENTED


<br>

## 7. Paddings <a name="paddings"></a>

NOT IMPLEMENTED

<br>

## 8. Differences with flexbox

* Top and bottom margins using percentages  
	* StackLayout resolve percentages in margin-top and margin-bottom against the **height of the container**.
	* FlexLayout/flexbox resolve percentages in margin-top and margin-bottom against the **width of the container**.

* Row direction
	* StackLayout use the **container's height** to adjust the item's size if the item's width or haven't been specified.
	* FlexLayout/flexbox use the **container's width** to adjust the item's size if the item's width or haven't been specified.

<br>

## StackLayout API Documentation <a name="api_documentation"></a>
The [**complete StackLayout API is available here**](https://layoutBox.github.io/FlexLayout/1.1/Classes/Flex.html). 

<br>

## Example App <a name="examples_app"></a>

NOT IMPLEMENTED

<br>


## FAQ <a name="faq"></a>

NOT IMPLEMENTED

<br/>

## Contributing, comments, ideas, suggestions, issues, .... <a name="comments"></a>
For any **comments**, **ideas**, **suggestions**, simply open an [issue](https://github.com/layoutBox/StackLayout/issues). 

For **issues**, please have a look at [Yoga's issues](https://github.com/facebook/yoga/issues). Your issue may have been already reported. If not, it may be a StackLayout issue. In this case open an issue and we'll let you know if the issue is related to Yoga's implementation. 

If you find StackLayout interesting, thanks to **Star** it. You'll be able to retrieve it easily later.

If you'd like to contribute, you're welcome!

<br>


## Installation <a name="installation"></a>

NOT DONE YET

## Changelog
StackLayout recent history is available in the are documented in the [CHANGELOG](CHANGELOG.md).

<br>

## License
BSD 3-Clause License 
