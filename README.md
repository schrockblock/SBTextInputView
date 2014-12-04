# SBTextInputView

[![CI Status](http://img.shields.io/travis/schrockblock/SBTextInputView.svg?style=flat)](https://travis-ci.org/schrockblock/SBTextInputView)
[![Version](https://img.shields.io/cocoapods/v/SBTextInputView.svg?style=flat)](http://cocoadocs.org/docsets/SBTextInputView)
[![License](https://img.shields.io/cocoapods/l/SBTextInputView.svg?style=flat)](http://cocoadocs.org/docsets/SBTextInputView)
[![Platform](https://img.shields.io/cocoapods/p/SBTextInputView.svg?style=flat)](http://cocoadocs.org/docsets/SBTextInputView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

To install SBTextInputView, simply add the following line to your Podfile:

pod "SBTextInputView", :git => 'https://github.com/schrockblock/SBTextInputView'

## Usage

There are a couple options for using this view: 

1. Include it right in your xib/storyboard
2. Use the specialized init method

The first option is pretty self explanatory. For the second, just do something like:

`[[SBTextInputView alloc] initWithFrame:CGRectMake(x, y, width, height) superView:self.view delegate:self];`

(You can check out the Example folder for more.)

Then, when you want to show the keyboard, just call `becomeFirstResponder` on the instance. To hide it, `resignFirstResponder`.

If you'd like to make this an inputAccessoryView of something else, just pass in `nil` for the superView param in the constructor, and treat it like any other view.

All the subviews are exposed properties, so you can style them any way you'd like. The background is a lightweight subclass of `UIToolbar` which overrides some of its more annoying behavior.

## Author

Elliot Schrock

## License

SBTextInputView is available under the MIT license. See the LICENSE file for more info.

