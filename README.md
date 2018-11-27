# ios-sdk
Ingresse iOS SDK

## Installation guide

Add this to your Podfile:
```ruby
pod 'IngresseSDK'
```

Import SDK on your Swift class
```swift
import IngresseSDK
```

## IngresseClient

### Passing device info to SDK:
This info is used to identify your app and user device for better and faster problem solving

```swift
import Foundation
import UIKit

class UserAgent {
    static func getUserAgent() -> String {
        let currentDevice = UIDevice.current
        let osDescriptor = "iOS/ \(currentDevice.systemVersion)"
        let deviceModel = currentDevice.name

        let deviceDescriptor = "\(osDescriptor) [\(deviceModel)]"

        guard let bundleDict = Bundle(for: UserAgent.self).infoDictionary,
            let appName = bundleDict["CFBundleName"] as? String,
            let appVersion = bundleDict["CFBundleShortVersionString"] as? String
            else { return deviceDescriptor }

        let appDescriptor = "\(appName)/\(appVersion)"
        return "\(appDescriptor) \(deviceDescriptor)"
    }
}
```

### Create a SDK Manager to your app
```swift
import IngresseSDK

class MySDKManager {
    static let shared = MySDKManager()

    var service: IngresseService!

    init() {
        let client = IngresseClient(
            apiKey: "<API_KEY>",
            userAgent: UserAgent.getUserAgent(),
            urlHost: "<YOUR_HOST>")

        self.service = IngresseService(client: client)
    }
}
```

## IngresseService

After creating your SDK Manager you can use it to access your IngresseService
```swift
let service = MySDKManager.shared.service
```

You can use different types of service from IngresseService

### AuthService

Used to login and get user data

```swift
let authService = service.auth
authService.loginWithEmail("example@email.com", andPassword: "******", onSuccess: (Callback block), onError: (Callback block))
```

### EntranceService

Used to make entrance related operations such as guest-list download and checkin

```swift
let entranceService = service.entrance
entranceService.getGuestListOfEvent("EVENT_ID", sessionId: "SESSION_ID", userToken: "REQUIRED_USER_TOKEN", page: 1, delegate: MyClass)
```
