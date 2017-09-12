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

To use the SDK you need an IngresseClient, you can create one like this:
```swift
let client = IngresseClient(publicKey: "YOUR_PUBLIC_KEY", privateKey: "YOUR_PRIVATE_KEY")
```

## IngresseService

After creating your IngresseClient you can use it to create your IngresseService
```swift
let service = IngresseService(client: client)
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
