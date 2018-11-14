# SPTouchID

[![CI Status](https://img.shields.io/travis/ssowri1/SPTouchID.svg?style=flat)](https://travis-ci.org/ssowri1/SPTouchID)
[![Version](https://img.shields.io/cocoapods/v/SPTouchID.svg?style=flat)](https://cocoapods.org/pods/SPTouchID)
[![License](https://img.shields.io/cocoapods/l/SPTouchID.svg?style=flat)](https://cocoapods.org/pods/SPTouchID)
[![Platform](https://img.shields.io/cocoapods/p/SPTouchID.svg?style=flat)](https://cocoapods.org/pods/SPTouchID)

![Screenshot](https://github.com/ssowri1/SPTouchID/blob/50e041697b11dbcfb8cd0517663a755354c52170/SPTouchID/Assets/touchAnimationSS.gif?raw=true)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

/// biometric class instance
var biometricAuth = SPAuthentication()
biometricAuth.delegate = self
biometricAuth.start()


// MARK:- Authentication delegates
extension SPTouchIDViewController: LocalAuthDelegate {
func authenticationFinished(string: String) {
DispatchQueue.main.async {
self.promtLabel.text = ""
self.validationPassed()
}
}
func authenticationFinishedWithError(error: String) {
DispatchQueue.main.async {
self.promtLabel.text = error
}
}
}

## Requirements

## Installation

SPTouchID is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SPTouchID','~> 0.1.7'
```

## Author

ssowri1, ssowri1@gmail.com

## License

SPTouchID is available under the MIT license. See the LICENSE file for more info.
