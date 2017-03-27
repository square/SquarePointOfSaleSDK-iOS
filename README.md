# Square Point of Sale SDK

[![CI Status](https://travis-ci.org/square/SquarePointOfSaleSDK-iOS.svg?branch=master)](https://travis-ci.org/square/SquarePointOfSaleSDK-iOS)
[![Carthage Compatibility](https://img.shields.io/badge/carthage-✓-e2c245.svg)](https://github.com/Carthage/Carthage/)
[![Version](https://img.shields.io/cocoapods/v/SquarePointOfSaleSDK.svg)](http://cocoadocs.org/docsets/SquarePointOfSaleSDK)
[![License](https://img.shields.io/cocoapods/l/SquarePointOfSaleSDK.svg)](http://cocoadocs.org/docsets/SquarePointOfSaleSDK)
[![Platform](https://img.shields.io/cocoapods/p/SquarePointOfSaleSDK.svg)](http://cocoadocs.org/docsets/SquarePointOfSaleSDK)

The Square Point of Sale SDK lets you quickly and easily add support to your application for completing in-store payments using Square Point of Sale.

## Requirements
* The following information about your app is required from the [Square Developer Portal](https://connect.squareup.com/apps):
    * **Square application ID.** Follow the [Square APIs getting started guide](https://docs.connect.squareup.com/articles/getting-started) if you need to register your app.
    * **Custom URL scheme**. This allows Square Point of Sale to send a callback to your app when the transaction is finished.  The URL scheme must be registered for your app in the [Square Developer Portal](https://connect.squareup.com/apps).
* Xcode 8.0 or later.
* iOS 9 or later.

## Getting started

### Add the SDK to your project

#### [CocoaPods](https://cocoapods.org)
```
platform :ios, '9.0'
pod 'SquarePointOfSaleSDK'
```

Be sure to call `pod update` and use `pod install --repo-update` to ensure you have the most recent version of the SDK installed.

#### [Carthage](https://github.com/Carthage/Carthage)
```
github "Square/SquarePointOfSaleSDK-iOS"
```

#### Git Submodules
Checkout the submodule with `git submodule add git@github.com:Square/SquarePointOfSaleSDK-iOS.git`, drag SquarePointOfSaleSDK.xcodeproj to your project, and add SquarePointOfSaleSDK as a build dependency.

#### Clone-and-Copy
You can always just clone this repository and copy the source files from the SquarePointOfSaleSDK directory into your project, but when using this approach, you must manually keep the SDK up-to-date yourself.

## Usage
Integrating Square Point of Sale SDK into your app takes just a couple of minutes. Once you've calculated how much you'd like to charge your customer, bundle up the relevant details into an API Request.

Check out the HelloCharge and HelloCharge-Swift apps in the project for a complete example and don't forget to check out our [API Documentation](https://docs.connect.squareup.com/).

### Configuration

You'll need to make two quick changes to your app Info.plist file, one to declare that you'll be looking for Square Point of Sale, and one declaring that Point of Sale can call you back when it's finished.

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>square-commerce-v1</string>
</array>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>Callback</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>your-url-scheme</string>
    </array>
  </dict>
</array>
```

### Swift
**Import Declaration:** `import SquarePointOfSaleSDK`

```swift
/**
 * Your callback URL and client ID (application ID) can be found and/or configured
 * in the Square Developer Portal: https://connect.squareup.com/apps
 */

// Replace with your app's callback URL.
let yourCallbackURL = URL(string: "your-url-scheme://myCallback")!

// Your client ID is the same as your Square Application ID.
// Note: You only need to set your client ID once, before creating your first request.
SCCAPIRequest.setClientID("YOUR_CLIENT_ID")

do {
    let money = try SCCMoney(amountCents: 300, currencyCode: "USD")

    let sccRequest =
        try SCCAPIRequest(
            callbackURL: yourCallbackURL,
            amount: money,
            userInfoString: nil,
            merchantID: nil,
            notes: "Coffee",
            customerID: nil,
            supportedTenderTypes: .all,
            clearsDefaultFees: false,
            returnAutomaticallyAfterPayment: false
        )
} catch let error as NSError {
    print(error.localizedDescription)
}
```

When you're ready to charge the customer, use our API Connection object to bring Point of Sale into the foreground to complete the payment.

```swift
do {
    try SCCAPIConnection.perform(sccRequest)
} catch let error as NSError {
    print(error.localizedDescription)
}
```

Finally, implement the relevant UIApplication delegate.

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    guard let sourceApplication = options[.sourceApplication] as? String,
        let window = window,
        let rootViewController = window.rootViewController,
        sourceApplication.hasPrefix("com.squareup.square") else {

        return false
    }

    do {
        let response = try SCCAPIResponse(responseURL: url)

        if response.isSuccessResponse {
            // Handle successful requests.
        } else if let error = response.error {
            // Handle failed requests.
            print(error.localizedDescription)
        } else {
            fatalError("We should never have received a response with neither a successful status nor an error message.")
        }
    } catch let error as NSError {
        // Handle unexpected errors.
        print(error.localizedDescription)
    }

    return true
}
```

### Objective C
**Import Declarations:**
* `@import SquarePointOfSaleSDK`
* `#import SquarePointOfSaleSDK.h`

```objc
/**
 * Your callback URL and client ID (application ID) can be found and/or configured
 * in the Square Developer Portal: https://connect.squareup.com/apps
 */

// Replace with your app's callback URL.
NSURL *const callbackURL = [NSURL URLWithString:@"your-url-scheme://myCallback"];

// Specify the amount of money to charge.
SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

// Your client ID is the same as your Square Application ID.
// Note: You only need to set your client ID once, before creating your first request.
[SCCAPIRequest setClientID:@"YOUR_CLIENT_ID"];

SCCAPIRequest *request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                        amount:amount
                                                userInfoString:nil
                                                    merchantID:nil
                                                         notes:@"Coffee"
                                                    customerID:nil
                                          supportedTenderTypes:SCCAPIRequestTenderTypeAll
                                             clearsDefaultFees:NO
                               returnAutomaticallyAfterPayment:NO
                                                         error:&error];
```

When you're ready to charge the customer, use our API Connection object to bring Point of Sale into the foreground to complete the payment.

```objc
[SCCAPIConnection performRequest:request error:&error];
```

Finally, implement the relevant UIApplication delegate.

```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL options:(NSDictionary<NSString *,id> *)options;
{
    NSString *const sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
	if ([sourceApplication hasPrefix:@"com.squareup.square"]) {
        SCCAPIResponse *const response = [SCCAPIResponse responseWithResponseURL:URL error:&decodeError];
        ...
        return YES;
    }
    return NO;
}
```

## Contributing
We’re glad you’re interested in Square Point of Sale SDK, and we’d love to see where you take it. Please read our [contributing guidelines](Contributing.md) prior to submitting a Pull Request.

## Support
If you are having trouble with using this SDK in your project, please create a question on [Stack Overflow](https://stackoverflow.com/questions/tagged/square-connect) with the `square-connect` tag. Our team monitors that tag and will be able to help you. If you think there is something wrong with the SDK itself, please create an issue.

## License
Copyright 2016 Square, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
