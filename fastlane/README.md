fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios to_dev
```
fastlane ios to_dev
```
Push to Dev branch
### ios release
```
fastlane ios release
```
Release new version
### ios tests
```
fastlane ios tests
```
Run Tests with coverage
### ios test
```
fastlane ios test
```
Run Tests
### ios increment_major
```
fastlane ios increment_major
```
Increment Major Version
### ios increment_minor
```
fastlane ios increment_minor
```
Increment Minor Version
### ios increment_patch
```
fastlane ios increment_patch
```
Increment Patch Version
### ios pod_push_sdk
```
fastlane ios pod_push_sdk
```
Push IngresseSDK to CocoaPods

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
