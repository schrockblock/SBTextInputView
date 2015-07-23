#
# Be sure to run `pod lib lint SBTextInputView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SBTextInputView"
  s.version          = "0.2.0"
  s.summary          = "SBTextInputView is a view and inputAccessoryView which auto resizes based on the amount of text."
  s.description      = <<-DESC
                        ## Usage

                        To run the example project, clone the repo, and run `pod install` from the Example directory first.

                        ## Requirements

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

                        You might also like to edit the text programmatically (perhaps reseting the text to @"") and have the view size appropriately. To do this, just set the inputTextView.text as desired, then call `notifyTextChanged` on the `SBTextInputView`.
                       DESC
  s.homepage         = "https://github.com/schrockblock/SBTextInputView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Elliot Schrock" => "elliot.schrock+pods@gmail.com" }
  s.source           = { :git => "https://github.com/schrockblock/SBTextInputView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/schrockblock'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Classes/*.xib'
  s.resource_bundles = {
    'SBTextInputView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
