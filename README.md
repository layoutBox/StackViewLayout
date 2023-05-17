<p align="center">
  <a href="https://github.com/layoutBox/StackViewLayout"><img src="docs_markdown/images/stacklayout_logo_text.png" width="260"/></a>
</p>

 
<p align="center">
  <a href=""><img src="https://img.shields.io/cocoapods/p/StackViewLayout.svg?style=flat" /></a>
  <a href="https://travis-ci.org/layoutBox/StackViewLayout"><img src="https://travis-ci.org/layoutBox/StackViewLayout.svg?branch=dev" /></a>
  <a href="https://codecov.io/gh/layoutBox/StackViewLayout"><img src="https://codecov.io/gh/layoutBox/StackViewLayout/branch/dev/graph/badge.svg"/></a>
  <a href='https://cocoapods.org/pods/StackViewLayoutView'><img src="https://img.shields.io/cocoapods/v/StackViewLayout.svg" /></a>
  <!--a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a-->
  <a href="https://github.com/layoutBox/StackViewLayout/issues"><img src="https://img.shields.io/github/issues/layoutBox/StackViewLayout.svg?style=flat" /></a>
</p>
</p>
<p align="center">
  <a href='https://cocoapods.org/pods/StackViewLayout'><img src="https://img.shields.io/cocoapods/v/StackViewLayout.svg" /></a>
  <a href='https://cocoapods.org/pods/StackViewLayout'><img src="https://img.shields.io/cocoapods/dm/StackViewLayout.svg" /></a>
  <a href='https://cocoapods.org/pods/StackViewLayout'><img src="https://img.shields.io/cocoapods/dt/StackViewLayout.svg" /></a>
</p>

<br>

Fast StackView, Concise syntax, intuitive, readable & chainable. Stacks easily many views horizontally or vertically. Greatly inspired by Flexbox.


### Features
* StackView can be used with **manual layout**, **Autolayout** and **Storyboards/XIB**.
* **Compare to UIStackView, StackView is a real UIView**, it layout all sub-views from `UIView.subviews`, no `UIStackView.arrangedSubviews`. This give you access to **backgroundColor**, **transparency**, **round corners**, **animations**, **transforms**, ... 
* StackView's items can be layouted using one of the **48 positions**.  
  <img src="docs_markdown/images/stackview_all_animated.gif" width="120"/>
* **Margins** can be applied on each item individually, giving you full control.
* **Width**, **height**, **min/max width** and **min/max height** can be applied on each items.
* An **aspect ratio** can applied on items, particularly useful for images.
* **Paddings** can be applied to the StackView.


### Requirements
* iOS 9.0+ / tvOS 9.0+
* Xcode 8.0+ / Xcode 9.0
* Swift 3.0+ / Swift 4.0

### Content

* [Introduction examples](#intro_usage_example)
* [StackViewLayout principles and philosophy](#introduction)
* [Performance](#performance)
* [Documentation](#documentation)
	* [StackView class](#stackview) 
	* [How to layout StackViews](#stackview_layout)
	* [Managing StackView's items](#managing_items)
	* [StackView properties](#StackView_properties)
	* [Items properties](#items_properties)
		* [Adjusting item's width, height and size](#adjusting_size)
		* [Margins](#margins)
	* [Visual properties](#visual_properties)
	* [Using with Autolayout and Storyboards](#autolayout)
* [API Documentation](#api_documentation)
* [Examples App](#examples_app)
* [FAQ](#faq)
* [Comments, ideas, suggestions, issues, ....](#comments)
* [Installation](#installation)

<br>

:pushpin: StackViewLayout is actively updated. So please come often to see latest changes. You can also **Star** it to be able to retrieve it easily later.

<br>

### StackViewLayout + PinLayout

<a href="https://github.com/mirego/PinLayout"><img src="docs_markdown/images/flexlayout_plus_pinlayout_small.png" width="250"/></a>

Three layout frameworks to rule them all:

* **StackViewLayout**: Stack easily views horizontally or vertically. 
* **[PinLayout](https://github.com/mirego/PinLayout)**: PinLayout is a layout framework greatly inspired by CSS absolute positioning, it is particularly useful for greater fine control and animations, and works perfectly with StactViews. It gives you full control by layouting one view at a time (simple to code and debug).
* **[FlexLayout](https://github.com/layoutBox/FlexLayout)**: FlexLayout is a full-blown flexbox implementation. Use the same engine as ReactNative. 

They all share a similar syntax and method names. Also...

* A view can be layouted using one or many of these frameworks.
* A view layouted using one framework can be embedded inside a view layouted using other frameworks. You choose the best layout framework for your situation. 

<br>
 
<a name="intro_usage_example"></a>
## StackViewLayout Introduction examples 

### Example: Display 4 buttons in a row
**You**: I would like to display 4 buttons horizontally using a StackView. These buttons contains an image. 
**Answer**: Easy, just adds these buttons (items) using either `addItem(:UIView)` or `addSubviews`. StackView layout all views from its `UIView.subviews` array. And set the direction to `.row` using [`direction(:Direction)`](#direction)

##### Variation 1: Row using `direction(.row)`

```swift
  stackView.direction(.row).define { (stackView) in
     stackView.addItem(button1)  // or stackView.addSubviews(button1)
     stackView.addItem(button2)  // or stackView.addSubviews(button2)
     stackView.addItem(button3)  // or stackView.addSubviews(button3)
     stackView.addItem(button4)  // or stackView.addSubviews(button4)
  }
``` 

Result: 

<img src="docs_markdown/images/examples/stackview_intro.png" width="400"/>

**You**: Nice, but how can we add some margins between items?  
**Answer**: You can set item's margin using [margins methods](#margins).

##### Variation 2: Add margins

```swift
  stackView.direction(.row).define { (stackView) in
     stackView.addItem(button1)
     stackView.addItem(button2).marginLeft(10)
     stackView.addItem(button3).marginLeft(10)
     stackView.addItem(button4).marginLeft(10)
  }
``` 

Result: 

<img src="docs_markdown/images/examples/stackview_intro_margin.png" width="400"/>

**You**: Good, but how can we distribute the remaining space around items?  
**Answer**: You can use StackView's method [`justifyContent(:)`](#justifyContent) to distribute extra free space.

##### Variation 3: Distribute space using `justifyContent(.spaceBetween)`

```swift
  stackView.direction(.row).justifyContent(.spaceBetween).define { (stackView) in
     stackView.addItem(button1)
     stackView.addItem(button2).marginLeft(10)
     stackView.addItem(button3).marginLeft(10)
     stackView.addItem(button4).marginLeft(10)
  }
``` 

Result: 

<img src="docs_markdown/images/examples/stackview_intro_justifyContent.png" width="400"/>

**You**: But what if the available screen width available is too narrow to display the 4 buttons?  

Result: 

<img src="docs_markdown/images/examples/stackview_intro_narrow.png" width="270"/>

**You**: Oups, buttons overflow on each other, what can we do to fix it?  
**Answer**: You need to specify which items should shrink and in which ratio using [`shrink(:CGFloat)`](#shrink). Here we want all buttons to shrink equally, so we use the same shrink factor on all items.

```swift
  stackView.direction(.row).justifyContent(.spaceBetween).define { (stackView) in
     stackView.addItem(button1).shrink(1)
     stackView.addItem(button2).marginLeft(10).shrink(1)
     stackView.addItem(button3).marginLeft(10).shrink(1)
     stackView.addItem(button4).marginLeft(10).shrink(1)
  }
``` 

Result: 

<img src="docs_markdown/images/examples/stackview_intro_shrink.png" width="270"/>

**You**: Ahh, much better, but buttons aspect ratio is not right, how can we fix that?  
**Answer**: You can specify the aspectRatio for each items using [aspectRatio methods](#aspect_ratio).

```swift
  stackView.direction(.row).justifyContent(.spaceBetween).define { (stackView) in
     stackView.addItem(button1).shrink(1).aspectRatio(imageRatio)
     stackView.addItem(button2).marginLeft(10).shrink(1).aspectRatio(imageRatio)
     stackView.addItem(button3).marginLeft(10).shrink(1).aspectRatio(imageRatio)
     stackView.addItem(button4).marginLeft(10).shrink(1).aspectRatio(imageRatio)
  }
``` 

Result: 

<img src="docs_markdown/images/examples/stackview_intro_aspectRatio.png" width="270"/>

**You**: Perfect! Now suppose I want a second row of buttons.
**Answer**: 

**You**: Perfect! Now we have buttons that layout correctly on any screen size!

Complete source code:

```swift
fileprivate let stackView = StackView()

init() {
   super.init(frame: .zero)
   
   stackView.direction(.row).justifyContent(.spaceBetween).define { (stackView) in
      stackView.addItem(button1).shrink(1).aspectRatio(imageRatio)
      stackView.addItem(button2).marginLeft(10).shrink(1).aspectRatio(imageRatio)
      stackView.addItem(button3).marginLeft(10).shrink(1).aspectRatio(imageRatio)
      stackView.addItem(button4).marginLeft(10).shrink(1).aspectRatio(imageRatio)
   }
   addSubview(stackView)
}

override func layoutSubviews() {
    super.layoutSubviews() 

    // Layout the StackView. This example use PinLayout for that purpose, but it could be done 
    //    also by setting the StackView's frame or using autolayout.
    stackView.pin.top(safeArea.top).horizontally(10).sizeToFit(.width)
}
``` 

:pushpin: This example is available in the [Examples App](#examples_app). See complete [source code](https://github.com/layoutBox/StackViewLayout/blob/master/Example/StackViewLayoutSample/UI/Examples/Intro/IntroView.swift)

</br>


<a name="introduction"></a>
## StackViewLayout principles and philosophy 

* StackViewLayout layouting is simple, powerful and fast.
* StackViewLayout syntax is concise and chainable.
* StackViewLayout share the same exact API as [FlexLayout](https://github.com/layoutBox/FlexLayout). But its usage is easier in most situations. 
* StackViewLayout is incredibly fast compared to UIStackView. See [Performance](#performance).
* Fine items spacing adjustment using margins. 
* Not intrusive. StackViewLayout only adds one property to existing iOS classes: `UIView.item`.
* Method's name match [PinLayout](https://github.com/mirego/PinLayout) and [FlexLayout](https://github.com/layoutBox/FlexLayout).
* StackView inherits from UIView, so it supports all visual tweaks, including backgroundColor, layer borders, round corners, animations, .... Which is not the case for UIStackView.
* StackView doesn't have an internal list of items (as [`UIStackView.arrangedSubviews`](https://developer.apple.com/documentation/uikit/uistackview/1616232-arrangedsubviews)), it simply layout all views from its `UIView.subviews` array. 

<br>

<a name="performance"></a>
# StackViewLayout's Performance 
TO BE DOCUMENTED

<br/>
	


# Documentation 

The defining aspect of StackView is the ability to alter its items, width, height to best fill the available space on any display device. A StackView expands its items to fill the available free space or shrinks them to prevent overflow.

The StackViewLayout is constituted of the `StackView` class and its immediate children which are called **items**. 

<a name="axes"></a>
##### Axes 

When working with StackViews you need to think in terms of two axes — the main axis and the cross axis. The main axis is defined by StackView's `direction` property, and the cross axis runs perpendicular to it.

| StackView direction | Axes |
|---------------------|:------------------:|
| **column** | <img src="docs_markdown/images/axis-column.png" width="200"/> |
| **row** | <img src="docs_markdown/images/axis-row.png" width="200"/>|


##### Sections	
In the following sections we will see:

* [StackView class](#stackview) 
* [How to layout StackViews](#stackview_layout)
* [Managing StackView's items](#managing_items)
* [StackView properties](#StackView_properties)
* [Items properties](#items_properties)

TODO: :pushpin: This document is a guide that explains how to use StackViewLayout. You can also checks the [**StackViewLayout API documentation**](https://layoutBox.github.io/StackViewLayout/1.1/Classes/StackViewLayout.html).

<br>

<a name="stackview"></a>
## StackView class 

* StackView class **inherits from UIView**:
	* So, it can be added has a subview and layouted has any other UIView. 
	* It also means it supports all visual tweaks, including backgroundColor, layer borders, rounded corners, .... Which is not the case for an UIStackView.
* StackView **doesn't have an internal list of items** (as [`UIStackView.arrangedSubviews`](https://developer.apple.com/documentation/uikit/uistackview/1616232-arrangedsubviews)), it simply layout all views from its `UIView.subviews` array. 
* StackView layout all visible views (`isHidden = false`) from its `UIView.subviews` array. 


<a name="stackview_layout"></a>
## StackView layout

When you use a StackView, you are responsible for the layout (position and size) of the StackView in its container (superview). Then, the StackView manages the layout and size of its content. Views contained in the StackView are called items.

StackView attempts to fill the space along the main-axis with its items. It sizes each item via its sizeThatFits returned value and if there is a leftover or a lack of space, it uses item's `grow` and `shrink` properties to determine which items to grow or shrink. StackView also takes into account item's margins. See [grow](#grow) and [shrink](#shrink) properties for more details.

###### Usage examples:
```swift
private let stackview = StackView()

init() {
   super.init(frame: .zero)
   
   stackview.define { (stack) in
      stack.addItem(button1)
      stack.addItem(button2)
   }
   addSubView(stackView)
}
  
override func layoutSubviews() {
   super.layoutSubviews() 
   stackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
}
```
<br>

### Layouting StackViews
This section explain how to control the size of a StackView and how it is possible to adjust the StackView's size to match its items.

You must define at least one dimension (width or height) to layout a StackView. 

Two options when layouting StackView:
1. Fixed size
2. StackView adjust its size to match its items 

#### Fixed size
StackView's size can be set to a specific width and height, in this situation the StackView will adjust the size and the position of all its items to fill the available space. You can control how items are layouted using [StackView's properties](#StackView_properties) and [item's properties](#items_properties).

StackView should be layouted either from `UIView.layoutSubviews()` or `UIViewController.viewWillLayoutSubviews()`.

###### Example:
In this example the StackView will be layouted to fill completely its parent. 

Using [PinLayout](https://github.com/mirego/PinLayout):

```swift
init() {
	...   
   stackview.define { (stack) in
      stack.addItem(button1)
      stack.addItem(button2).marginTop(10)
      stack.addItem(button3).marginTop(10)
   }
   addSubView(stackView)
}
  
override func layoutSubviews() {
   super.layoutSubviews() 
   stackView.pin.all()
}
```

Using `UIView.frame` property:

```swift
override func layoutSubviews() {
   super.layoutSubviews() 
   stackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
}
```

Result:

<img src="docs_markdown/images/example-size-fixed-size.png" width="160"/>

<a name="adjust_size_to_items"></a>
#### Adjusting size to match its items
StackView can be layouted by specifying only one dimension and letting the StackView compute the other dimension. In this situation StackLayout set its dimension to fit all its items. 

:pushpin: If the StackView adjust its size to match its items, the [`justifyContent`](#justifyContent) property will have no effect.

###### Example:
This example layout a StackView at the top and fill the parent horizontally. The StackView's height will be computed to fit nicely its items. Here is the result:

Using [PinLayout](https://github.com/mirego/PinLayout):

```swift
override func layoutSubviews() {
   super.layoutSubviews() 
   // Use PinLayout sizeToFit(.width) method to adjust the StackView's size.
   stackView.pin.top().left().width(100%).sizeToFit(.width)
}
```

Using `UIView.frame` property:

```swift
override func layoutSubviews() {
   super.layoutSubviews() 
   let adjustedSize = stackView.sizeThatFits(CGSize(width: frame.width, 
                                                    height: .greatestFiniteMagnitude))
   stackView.frame = CGRect(x: 0, y: 0, width: adjustedSize.width, height: adjustedSize.height)
}
```

Result: The StackView height as been adjusted to contain all its items.

<img src="docs_markdown/images/example-size-adjust-height.png" width="160"/>

<br/>

<a name="managing_items"></a>
## 2. Managing StackView's items 

<a name="addItem"></a>
### Adding items to a StackView 
- Applies to: `StackView`
- Returns: StackItem interface of the newly added item.

StackView layout all visible views (`isHidden = false`) in the `UIView.subviews` array. 

Here is the list methods to add or insert items to a StackView.

:pushpin: Since StackView layout all views in the `UIView.subviews` array, it is also possible to add or insert views using:

* `addSubview(_ view: UIView)`
* `insertSubview(_ view: UIView, at index: Int)`
* `insertSubview(_ view: UIView, aboveSubview: UIView)`
* `insertSubview(_ view: UIView, belowSubview: UIView)`

**Methods:**

* **`addItem(_: UIView) -> StackItem`**  
This method adds an item (UIView) to a StackView. The item is added as the last item. Internally this method adds the UIView as a subview. Note that you can also use.
* **`insertItem(_ view: UIView, at index: Int) -> StackItem`**  
This method adds an item (UIView) at the specified index. Note that you can also use `insertSubview(_ view: UIView, at index: Int)`.
* **`insertItem(_ view: UIView, before refItem: UIView) -> StackItem?`**  
This method adds an item (UIView) before the specified reference item. Note that you can also use `insertSubview(_ view: UIView, aboveSubview: UIView)`.
* **`insertItem(_ view: UIView, after refItem: UIView) -> StackItem?`**  
This method adds an item (UIView) after the specified reference item. Note that you can also use `insertSubview(_ view: UIView, belowSubview: UIView)`.

###### Usage examples:
```swift
  stackview.addItem(imageView)
  stackview.addItem(titleLabel, after: imageView)
```
<br>

<a name="addStackView"></a>
### addStackView()

TODO: Document addStackView()


### Removing items 
- Applies to: `StackView`

**Method:**

* **`removeItem(_ view: UIView)`**  
Removes the specified item from the StackView. You can also use the view's `UIView.removeFromSuperview()` method to achieve the exact same result. This method just exist to be consistent with `addItem(:UIView)`. 

###### Usage example:
```swift
  stackview.removeItem(descriptionLabel)
  // Or, you can also use: 
  descriptionLabel.removeFromSuperview()
```

### define()
- Applies to: `StackView`

**Method:**

* **`define(_ closure: (_ stackView: StackView) -> Void)`**  
This method is used to structure your code so that it matches the view structure. The method has a closure parameter with a single parameter called `stackView`. This parameter is in fact the StackView instance. 

###### Usage examples:
```swift
  stackview.define { (stack) in
      stack.addItem(imageView)
      stack.addItem(nameLabel)
      stack.addItem(descriptionLabel)
  }
```

The same results can also be obtained without using the `define()` method.

```swift
   stackview.addItem(imageView)
   stackview.addItem(nameLabel)
   stackview.addItem(descriptionLabel)
```

**Advantages of using `define()`**:

* The source code structure matches the views structure, making it easier to understand and modify.
* Changing an item order, it's just moving up/down its line/block that defines it.
* Moving an item from one StackView to another is just moving line/block that defines it.

<br>
 
<a name="StackView_properties"></a>
## 3. StackView properties  
This section describes StackView properties that affect how items are layouted.

<a name="direction"></a>
### direction 
- Applies to: `StackView`
- Values: `column` / `row`
- Default value: `column`
- Method: **`direction(_: SDirection)`**  

The `direction` property establishes the [main-axis](#axes), thus defining the direction items are placed in the StackView. 

| Value | Result | Description |
|---------------------|:------------------:|---------|
| **column** (default) 	| <img src="docs_markdown/images/direction-column.png" width="100"/>| Top to bottom |
| **row** | <img src="docs_markdown/images/direction-row.png" width="190"/>| Same as text direction |

:pushpin: IMPORTANT NOTE: StackViewLayout determine items width by calling each item's `sizeThatFits(:CGSize)` method with the **available width**. This is particularly important to understand when using the `.row` direction, because in this direction there's a good chance that items will overflow their StackView. In these situations you'll have to use item's [`shrink`](#shrink) property to fit items inside their StackView.

###### Usage examples:
```swift
  stackView.direction(.column)  // Not required, default value. 
  stackView.direction(.row)
```

###### Example 1:
This example show a StackView of size 300x400 containing three buttons with a margin of 10 pixels between them. 

```swift
   stackView.define { (stack) in
      stack.addItem(button1)
      stack.addItem(button2).marginTop(10)
      stack.addItem(button3).marginTop(10)
    }
    
   override func layoutSubviews() {
      super.layoutSubviews() 
      stackView.width(300).height(400)
   }
``` 

<img src="docs_markdown/images/example-direction-column.png" width="160"/>

Buttons are stretched horizontally because StackView's default [`alignItems`](#alignItems) property is `.stretch`. Also, we don't need to set the [`direction`](#direction) since the default value is `.column`.


###### Example 2:
Using the same setup as the Example 1, but using the `.row` direction.

```swift
    stackview.direction(.row).define { (stack) in
       stack.addItem(button1)
       stack.addItem(button2).marginTop(10)
       stack.addItem(button3).marginTop(10)
    }
``` 

<img src="docs_markdown/images/example-direction-row-wrong.png" width="160"/>

Not really the expected result, right?! Two issues:

1. Buttons are too tall: By default StackView `alignItems` property is set to `.stretch`, which cause items to stretch in the cross axis direction. To fix that, two possible solutions:
	1. Set the `alignItems` property to `.start`. See [`alignItems`](#alignItems).  
	2. Adjust the StackView's height to match its items. See [Adjusting size to match its items](#adjust_size_to_items).

2. Buttons overflow the StackView: The reason for this is that the size of the three buttons + margins are wider than the specified StackView's width (300 pixels). To contain buttons inside the StackView, we can increase the StackView's width OR we must allow items to shrink if there is not enough available space. By default item don't shrink. To enable this we must set the item's `shrink` property. We want that all buttons shrink equitably, so we set each button the same `shrink` property. See [`shrink`](#shrink) for more details.  

```swift
   stackView.direction(.row).alignItems(.start).define { (stack) in
      stack.addItem(button1).shrink(1)
      stack.addItem(button2).marginLeft(10).shrink(1)
      stack.addItem(button3).marginLeft(10).shrink(1)
   }
``` 

<img src="docs_markdown/images/example-direction-row.png" width="160"/>

Much better! 

<br/>

<a name="justifyContent"></a>
### justifyContent 
- Applies to: `StackView`
- Values: `start` / `end` / `center` / `spaceBetween` / `spaceAround` / `spaceEvenly`
- Default value: `start`
- Method: **`justifyContent(_: JustifyContent)`** 

	The `justifyContent` property defines the alignment along the main-axis. It helps distribute extra free space leftover when either all items have reached their maximum size. For example, for a column StackView, `justifyContent` controls how items align vertically. 

This property is similar to `UIStackView.distribution` (UIStackViewDistribution)


|                     	| direction(.column) | direction(.row) | |
|---------------------	|:------------------:|:---------------:|:--|
| **start** (default) 	| <img src="docs_markdown/images/justify-column-start.png" width="140"/>| <img src="docs_markdown/images/justify-row-start.png" width="160"/>| Items are packed at the beginning of the main-axis. |
| **end**	| <img src="docs_markdown/images/justify-column-end.png" width="140"/>| <img src="docs_markdown/images/justify-row-end.png" width="160"/>| Items are packed at the end of the main-axis. |
| **center** 	| <img src="docs_markdown/images/justify-column-center.png" width="140"/>| <img src="docs_markdown/images/justify-row-center.png" width="160"/>| items are centered along the main-axis. |
| **spaceBetween** 	| <img src="docs_markdown/images/justify-column-spacebetween.png" width="95"/>| <img src="docs_markdown/images/justify-row-spacebetween.png" width="160"/> | Items are evenly distributed in the main-axis; first item is at the beginning, last item at the end. |
| **spaceAround** 	| <img src="docs_markdown/images/justify-column-spacearound.png" width="95"/> | <img src="docs_markdown/images/justify-row-spacearound.png" width="160"/> | Items are evenly distributed in the main-axis with equal space around them. Items have a half-size space on either end. |
| **spaceEvenly** 	| <img src="docs_markdown/images/justify-column-spaceevenly.png" width="95"/> | <img src="docs_markdown/images/justify-row-spaceevenly.png" width="160"/> | Items are evenly distributed in the main-axis with equal space around them. |

###### Usage examples:
```swift
  stackView.justifyContent(.start)  // default value. 
  stackView.justifyContent(.center)
```


TODO: Add an example!!!

<br>

<a name="alignItems"></a>
### alignItems 
- Applies to: `StackView`
- Values: `stretch` / `start` / `end` / `center`
- Default value: `stretch `
- Method: **`alignItems(_: AlignItems)`**  

The `alignItems` property defines how items are laid out along the cross axis. Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, for a column StackView, `alignItems` controls how they align horizontally. 

This property is similar to `UIStackView.alignment` (UIStackViewAlignment)

|                     	| direction(.column) | direction(.row) |
|---------------------	|:------------------:|:---------------:|
| **stretch** (default) 	| <img src="docs_markdown/images/align-column-stretch.png" width="140"/>| <img src="docs_markdown/images/align-row-stretch.png" width="160"/>|
| **start**	| <img src="docs_markdown/images/align-column-start.png" width="140"/>| <img src="docs_markdown/images/align-row-start.png" width="160"/>|
| **end**	| <img src="docs_markdown/images/align-column-end.png" width="140"/>| <img src="docs_markdown/images/align-row-end.png" width="160"/>|
| **center** 	| <img src="docs_markdown/images/align-column-center.png" width="140"/>| <img src="docs_markdown/images/align-row-center.png" width="160"/>|


TODO: Add an example!!!

<br/>

<a name="items_properties"></a>
## 4. Item properties 
This section describes all StackView's item properties.

### alignSelf
- Values: `auto` / `stretch` / `start` / `end` / `center`
- Default value: `auto`
- method: **`alignSelf(_: AlignSelf)`**

The `alignSelf` property controls how an item aligns in the cross direction, overriding the `alignItems` of the StackView. For example, for a column StackView, `alignSelf` will control how the item will align horizontally. 

The `auto` value means use the stack view `alignItems` property. See `alignItems` for documentation of the other values.

TODO: Add an example!!!

<br/>


<a name="grow"></a>
### grow 
- Default value: 0
- method: **`grow(_: CGFloat)`** 

The `grow` property defines the ability for an item to grow if necessary. It accepts a unitless value that serves as a proportion. It dictates what amount of the available space inside the StackView the item should take up.

A `grow` value of 0 (default value) keeps the view's size in the main-axis direction. If you want the view to use the available space set a `grow` value > 0.

For example, if all items have `grow` set to 1, every child will grow to an equal size inside the container. If you were to give one of the children a value of 2, that child would take up twice as much space as the others.

TODO: Add an example!!!

<br>

<a name="shrink"></a>
### shrink 
- Default value: 0
- Method: **`shrink(_: CGFloat)`** 

The `shrink` defines how much the item will shrink relative to the rest of items in the StackView **when there isn't enough space on the main-axis**.
  
A shrink value of 0 keeps the view's size in the main-axis direction. Note that this may cause the view to overflow its flex container.
  
Shrink is about proportions. If an item has a shrink of 3, and the rest have a shrink of 1, the item will shrink 3x as fast as the rest.

TODO: Add an example!!!

<br>

<a name="markDirty"></a>
### markDirty() 
- Method: **`markDirty()`** 
- Applies to StackView and items

StackView's items are layouted only when an item's property is changed and when the StackView size change. In the event that you want to force the StackView to update the layout of all its items, you can mark the StackView or any of it's item as dirty using `markDirty()`.

Marking an item as dirty will propagates to the direct StackView and all other parents StackViews. So if you update multiple items, calling `markDirty()` only on one item or calling it on their StackView have the same effect, the StackView will be re-layouted. 
          
###### Usage examples:
In the case where a UILabel's text is updated, it is needed to mark the label as dirty.

```swift
   // Update UILabel's text and mark the UILabel as dirty
   label.text = "I love StackViewLayout"
   label.item.markDirty()
   
   stackView.markDirty()
```

TODO: Add an example?

<br/>

<a name="adjusting_size"></a> 
### Adjusting item's width, height and size 

StackView's items size can be set manually using the following methods.

:pushpin: Note that if the width/height/size is set and the item's `shrink` or `grow` property have a value > 0, than if required the item may shrink or grow. Shrink and grow properties have an higher priority than width/height/size.

**Methods:**

* **`width(_ width: CGFloat?)`**  
The value specifies the view's width in pixels. The value must be non-negative. Call `width(nil)` to reset the property.
* **`width(_ percent: SPercent)`**  
The value specifies the view's width in percentage of its container width. The value must be non-negative. Call `width(nil)` to reset the property.
* **`height(_ height: CGFloat?)`**  
The value specifies the view's height in pixels. The value must be non-negative. Call `height(nil)` to reset the property.
* **`height(_ percent: SPercent)`**  
The value specifies the view's height in percentage of its container height. The value must be non-negative. Call `height(nil)` to reset the property.
* **`size(_ size: CGSize?)`**  
The value specifies view's width and the height in pixels. Values must be non-negative. Call `size(nil)` to reset the property.
* **`size(_ sideLength: CGFloat?)`**  
The value specifies the width and the height in pixels, creating a square view. Values must be non-negative. Call `size(nil)` to reset the property.


###### Usage examples:
```swift
  view.item.width(100)	
  view.item.width(50%)	
  view.item.height(200)
	
  view.item.size(250)
```

TODO: Add an example!!!

<br>

<a name="minmax_width_height_size"></a>
### minWidth, maxWidth, minHeight, maxHeight 

StackView's items min/max width and min/max height can be specified.

Using minWidth, minHeight, maxWidth, and maxHeight gives you increased control over the final size of items. By mixing these properties with `grow`, `shrink`, and `alignItems(.stretch)`, you are able to have items with dynamic size within a range which you control.

An example of when Max properties can be useful is if you are using `alignItems(.stretch)` but you know that your item won’t look good after it increases past a certain point. In this case, your item will stretch to the size of its parent or until it is as big as specified in the Max property.

Same goes for the Min properties when using `shrink`. For example, you may want an item to shrink, but if you specify a minimum width, the item won't be shrink past the specified value.

Another case where Min and Max dimension constraints are useful is when using `aspectRatio`.

**Methods:**

* **`minWidth(_ width: CGFloat?)`**  
The value specifies the view's minimum width in pixels. The value must be non-negative. Call `minWidth(nil)` to reset the property.
* **`minWidth(_ percent: SPercent)`**  
The value specifies the view's minimum width of the view in percentage of its container width. The value must be non-negative. Call `minWidth(nil)` to reset the property..
* **`maxWidth(_ width: CGFloat?)`**  
The value specifies the view's maximum width in pixels. The value must be non-negative. Call `maxWidth(nil)` to reset the property.
* **`maxWidth(_ percent: SPercent)`**  
The value specifies the view's maximum width of the view in percentage of its container width. The value must be non-negative. Call `maxWidth(nil)` to reset the property.
* **`minHeight(_ height: CGFloat?)`**  
The value specifies the view's minimum height in pixels. The value must be non-negative. Call `minHeight(nil)` to reset the property.
* **`minHeight(_ percent: SPercent)`**  
The value specifies the view's minimum height of the view in percentage of its container height. The value must be non-negative. Call `minHeight(nil)` to reset the property.
* **`maxHeight(_ height: CGFloat?)`**  
The value specifies the view's maximum height in pixels. The value must be non-negative. Call `maxHeight(nil)` to reset the property.
* **`maxHeight(_ percent: SPercent)`**  
The value specifies the view's maximum height of the view in percentage of its container height. The value must be non-negative. Call `maxHeight(nil)` to reset the property.
   
###### Usage examples:
```swift
  view.item.maxWidth(200)
  view.item.maxWidth(50%)
  view.item.width(of: view1).maxWidth(250)
	
  view.item.maxHeight(100)
  view.item.height(of: view1).maxHeight(30%)
```

TODO: Add an example!!!

<br>

<a name="margins"></a>
### Margins 

By applying Margin to an item you specify the offset a certain edge of the item should have from it’s closest sibling or parent (StackView).

**Methods:**

* **`marginTop(_ value: CGFloat)`, `marginTop(_ percent: FPercent)`**  
Specify the offset the top edge of the item should have from it’s closest sibling (item) or parent (StackView).
* **`marginLeft(_ value: CGFloat)`, `marginLeft(_ percent: FPercent)`**  
Specify the offset the left edge of the item should have from it’s closest sibling (item) or parent (StackView).
* **`marginBottom(_ value: CGFloat)`, `marginBottom(_ percent: FPercent)`**  
Specify the offset the bottom edge of the item should have from it’s closest sibling (item) or parent (StackView)
* **`marginRight(_ value: CGFloat)`, `marginRight(_ percent: FPercent)`**  
Specify the offset the right edge of the item should have from it’s closest sibling (item) or parent (StackView).
* **`marginStart(_ value: CGFloat)`, `marginStart(_ percent: FPercent)`**  
Set the start margin. In LTR direction, start margin specify the **left** margin. In RTL direction, start margin specify the **right** margin.
* **`marginEnd(_ value: CGFloat)`, `marginEnd(_ percent: FPercent)`**  
Set the end margin. In LTR direction, end margin specify the **right** margin. In RTL direction, end margin specify the **left** margin.
* **`marginHorizontal(_ value: CGFloat)`, `marginHorizontal(_ percent: FPercent)`**  
Set the left, right, start and end margins to the specified value.
* **`marginVertical(_ value: CGFloat)`, `marginVertical(_ percent: FPercent)`**  
Set the top and bottom margins to the specified value.
* **`margin(_ insets: UIEdgeInsets)`**
Set all margins using an UIEdgeInsets. This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
* **`margin(_ insets: NSDirectionalEdgeInsets)`**
Set all margins using an NSDirectionalEdgeInsets. This method is useful to set all margins using iOS 11 `UIView. directionalLayoutMargins` when layouting a view supporting RTL/LTR languages.
* **`margin(_ value: CGFloat) `**  
Set all margins to the specified value.
* **`margin(_ vertical: CGFloat, _ horizontal: CGFloat)`**
* **`margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat)`**
* **`margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat)`**

###### Usage examples:
```swift
  view.item.margin(20)
  view.item.marginTop(20%).marginLeft(20%)
  view.item.marginHorizontal(20)
  view.item.margin(safeAreaInsets)
  view.item.margin(10, 12, 0, 12)
  
  // Margin is defined inline
  stackview.addItem(separatorView).margin(20)
```

<br>

<a name="aspect_ratio"></a>
### aspectRatio(:CGFloat?)) / aspectRatio(of: UIView) / aspectRatio()

AspectRatio property solves the problem of knowing one dimension of an element and an aspect ratio, this is very common when it comes to images, videos, and other media types. AspectRatio accepts any floating point value > 0, the default is undefined.

* AspectRatio is defined as the ratio between the width and the height of a node e.g. if an item has an aspect ratio of 2 then its width is twice the size of its height.
* AspectRatio respects the Min and Max dimensions of an item.
* AspectRatio has higher priority than `grow`.
* If AspectRatio, Width, and Height are set then the cross dimension is overridden.
* Call `aspectRatio(nil)` to reset the property.

**Methods:**

* **`aspectRatio(: CGFloat)`**:  
Set the item's aspect ratio using a CGFloat. AspectRatio is defined as the ratio between the width and the height (width / height). 

* **`aspectRatio()`**:  
If the layouted view is an UIImageView, this method will set the aspectRatio using the UIImageView's image dimension. For other types of views, this method as no impact.

   
###### Usage examples:
```swift
  imageView.flex.aspectRatio(16/9)
```

<br/>

<a name="isIncludedInLayout"></a>
### isIncludedInLayout / isIncludedInLayout()
- Method: **`isIncludedInLayout(: Bool)`** 
- Property: **`isIncludedInLayout: Bool`** 

* **`isIncludedInLayout: Bool`** / **`isIncludedInLayout(_ value: Bool)`**  
This property controls dynamically if a StackView's item is included or not in the StackView layouting. When an item is excluded, StackView won't layout the view. Default value is true.

This can be useful if you want to layout an item manually instead of using StackView layouting.

###### Usage examples:
```swift
   label.item.isIncludedInLayout = false
```

<br>

<a name="visual_properties"></a>
### Visual properties 
StackViewLayout also adds methods to set common UIView properties. These methods are available on StackView's instances and on items.

**Methods:**

* **`backgroundColor(_ color: UIColor)`**  
Set the StackView or item's UIView background color. 
* **`alpha(_ value: CGFloat)`**  
Set the StackView or item's `alpha` property to adjust the transparency. 

###### Usage examples:
```swift
  // Create a gray column StackView and add a black horizontal line separator 
  stackView.addStackView().backgroundColor(.gray).define { (stackView) in
      stackView.addItem(UIView()).height(1).backgroundColor(.black).alpha(0.7)
  } 
```

<br>


### Nesting StackViews

TODO:
If you run into situations where multiple elements need to be arranged along multiple axes, UIStackViews can be nested inside each other. Below is the layout from the example project. Each property UILabel and UISegmentedControl are contained in a UIStackView. All of the UIStackViews are then contained in a parent UIStackView denoted on the left.

See [addStackView()](#addStackView) 

<br/>

### StackViewLayout default properties

This table resume **StackView's default properties**:

| Property     | StackView default value |
|--------------|--------------------------|
| **`direction`** | .column |
| **`justifyContent`** | .start |
| **`alignItems`** | .stretch |

This table resume **Items default properties**:

| Property     | Items default value |
|--------------|--------------------------|
| **`alignSelf`** | .auto |
| **`grow`** | 0 |
| **`shrink`** | 0 |

<br>


<a name="autolayout"></a>
## Using with Autolayout and Storyboards
StackView can be also be used with autolayout.

So it is compatible with Storyboards and NIBs.

To use StackView in a Storyboard:

1. From Interface builder:
	1. Add a UIView into your view controller's view.
	2. Set the view's class to `StackView`:  
<img src="docs_markdown/images/storyboard_class.png" width="200"/>
	3. You can either add StackView's items (sub views) from source code, or using Interface Builder. Just note that you don't need to position and size StackView's subviews in interface builder, StackView will layout them at runtime.
	4. You must set autolayout constraints to layout the StackView inside your view.
2. Add a reference to the added StackView into your UIViewController's class.
3. You can customize StackView's properties. For example to set the `justifyContent` and the `alignItems` simply add this line in your UIViewController's class:  

	```swift
	stackView.justifyContent(.spaceAround).alignItems(.center)
	``` 
	
4. You can also set the StackView's items properties from source code, simply add reference to them and customize them from source code.

See the example "Autolayout" in the [Example App](#examples_app) for a complete example.

### StackView advantage over UIStackView
* Finer control: You can control each item's margin individually (horizontally and vertically). No more needs of adding filler UIViews to add margin between items.
* More control over how items are layouted.
* Can be layouted using autolayout or not, you're not stuck with a single layout framework. StackView can be layouted with any layout frameworks!

<br>

<a name="differences_flexlayout"></a>
## Differences with FlexLayout/FlexBox

* Top and bottom margins using percentages  
	* StackViewLayout resolve percentages in marginTop and marginBottom against the **height of the container**.
	* FlexLayout/flexbox resolve percentages in marginTop and marginBottom against the **width of the container**.

<br>

<a name="api_documentation"></a>
## StackViewLayout API Documentation 
The [**complete StackViewLayout API is available here**](https://layoutBox.github.io/StackViewLayout/1.1/Classes/StackViewLayout.html). 

<br>

<a name="examples_app"></a>
## Example App 

NOT IMPLEMENTED YET. COMING SOON.

* Layout Modes: Display all StackView's layout modes (direction, justifyContent, alignItems)
* CollectionViewExample
* TableViewExample
* Autolayout

<br>


<a name="faq"></a>
## FAQ 

COMING SOON.

<br/>

<a name="comments"></a>
## Contributing, comments, ideas, suggestions, issues, .... 
For any **comments**, **ideas**, **suggestions**, simply open an [issue](https://github.com/layoutBox/StackViewLayout/issues). 

For **issues**, please have a look at [Yoga's issues](https://github.com/facebook/yoga/issues). Your issue may have been already reported. If not, it may be a StackViewLayout issue. In this case open an issue and we'll let you know if the issue is related to Yoga's implementation. 

If you find StackViewLayout interesting, thanks to **Star** it. You'll be able to retrieve it easily later.

If you'd like to contribute, you're welcome!

<br>


<a name="installation"></a>
## Installation 

### CocoaPods

To integrate StackLayoutView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
    pod 'StackLayoutView'
```

Then, run `pod install`.

### Carthage
NOT IMPLEMENTED YET. COMING SOON.

### Swift Package Manager
NOT IMPLEMENTED YET. COMING SOON.

<br>

## Coming soon

List of features that will be implement soon:

* Add aspect ratio support
* RTL (right-to-left) language support 
* Implement distribution mode as UIStackView (.fill, FillEqually, FillProportionally, ...)
* Implement directions row-reverse and column-reverse
* Support StackView padding

<br>

## Changelog
StackViewLayout recent history is available in the are documented in the [CHANGELOG](CHANGELOG.md).

<br>

## License
BSD 3-Clause License 
