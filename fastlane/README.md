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
or alternatively using `brew install fastlane`

# Available Actions
## iOS
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
### ios create_pod_release
```
fastlane ios create_pod_release
```
Create new pod release
### ios changelog_from_master
```
fastlane ios changelog_from_master
```
Get changelog from master
### ios push_to_cocoapods
```
fastlane ios push_to_cocoapods
```
Push sdk to cocoapods
### ios notify_slack
```
fastlane ios notify_slack
```
Send message to slack

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
