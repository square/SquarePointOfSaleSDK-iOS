# Square Register SDK

The Square Register SDK lets you quickly and easily add support to your application for completing in-store payments using Square Register.

## Getting started
#### Git Submodules
Or manually checkout the submodule with `git submodule add git@github.com:Square/SquareRegisterSDK.git`, drag SquareRegisterSDK.xcodeproj to your project, and add SquareRegisterSDK as a build dependency.

## Usage
Integrating Square Register SDK into your app takes just a couple of minutes. Once you've calculated how much you'd like to charge your customer, bundle up the relevant details into an API Request.

```objc
// Replace with your app's callback URL.
NSURL *const callbackURL = [NSURL URLWithString:@"your-url-scheme://myCallback"];

// Specify the amount of money to charge.
SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

// Note: You only need to set your client ID once, before creating your first request.
[SCCAPIRequest setClientID:@"YOUR_CLIENT_ID"];
[SCCAPIRequest requestWithCallbackURL:callbackURL
                               amount:amount
                       userInfoString:nil
                           merchantID:nil
                                notes:@"Coffee"
                 supportedTenderTypes:SCCAPIRequestTenderTypeCard
                    clearsDefaultFees:NO
      returnAutomaticallyAfterPayment:NO
                                error:&error];
```

When you're ready to charge the customer, use our API Connection object to bring Register into the foreground to complete the payment.

```objc
[SCCAPIConnection performRequest:request error:&error];
```

Finally, implement the relevant UIApplication delegate.

```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
{
	if ([sourceApplication hasPrefix:@"com.squareup.square"]) {
        SCCAPIResponse *const response = [SCCAPIResponse responseWithResponseURL:URL error:&decodeError];
        ...
        return YES;
    }
    return NO;
}
```

You'll need to make two quick changes to your app Info.plist file, one to declare that you'll be looking for Square Register, and one declaring that Register can call you back when it's finished.

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

Check out the Square Register SDK Test App for a complete example and don't forget to check out our [API Documentation](https://docs.connect.squareup.com/).

## Requirements
* Xcode 6.3 or later.
* iOS 8 or later.

## Contributing
We’re glad you’re interested in Square Register SDK, and we’d love to see where you take it. Please read our [contributing guidelines](Contributing.md) prior to submitting a Pull Request.

## License
Copyright 2016 Square, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.