//
//  SCCTestAppDelegate.m
//  SquareRegisterSDK Test App
//
//  Created by Kyle Van Essen on 12/13/2013.
//  Copyright (c) 2013 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "SCCTestAppDelegate.h"
#import "SquareRegisterSDK.h"


@implementation SCCTestAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];

    // Always set the client ID before creating your first API request.
    // Replace this with the Application ID found in the Square Application Dashboard [https://connect.squareup.com/apps].
    [SCCAPIRequest setClientID:@"YOUR_APPLICATION_ID"];

    // Replace with your app's callback URL.
    // You must also declare this URL scheme in SquareRegisterSDK Test App-Info.plist, under URL types.
    NSURL *const callbackURL = [NSURL URLWithString:@"register-sdk-testapp://myCallback"];

    // Specify the amount of money to charge.
    SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

    // Specify which forms of tender the merchant can accept
    SCCAPIRequestTenderTypes const supportedTenderTypes = SCCAPIRequestTenderTypeAll;

    // Specify whether default fees in Square Register are cleared from this transaction
    // (Default is NO, they are not cleared)
    BOOL const clearsDefaultFees = YES;

    // Replace with the ID of the location that should be able to take payments (if desired).
    NSString *const merchantID = nil;

    // Replace with any string you want returned from Square Register.
    NSString *const userInfoString = @"Useful information";

    // Replace with notes to associate with the transaction.
    NSString *const notes = @"Notes";

    // Initialize the request.
    NSError *error = nil;
    SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                  amount:amount
                                                          userInfoString:userInfoString
                                                              merchantID:merchantID
                                                                   notes:notes
                                                    supportedTenderTypes:supportedTenderTypes
                                                       clearsDefaultFees:clearsDefaultFees
                                         returnAutomaticallyAfterPayment:YES
                                                                   error:&error];

    // Perform the request.
    [SCCAPIConnection performRequest:request error:&error];

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)URL options:(NSDictionary<NSString *,id> *)options;
{
    NSString *const sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    // Make sure the URL comes from Square Register, fail if it doesn't.
    if (![sourceApplication hasPrefix:@"com.squareup.square"]) {
        return NO;
    }

    // The response data is encoded in the URL and can be decoded as an SCCAPIResponse.
    NSError *decodeError = nil;
    SCCAPIResponse *const response = [SCCAPIResponse responseWithResponseURL:URL error:&decodeError];

    NSString *message = nil;
    NSString *title = nil;

    // Process the response as desired.
    if (response.isSuccessResponse) {
        title = @"Success!";
        message = [NSString stringWithFormat:@"Payment creation succeeded with transaction ID %@", response.transactionID];
    } else {
        title = @"Error!";

        // An invalid response message error is distinct from a successfully decoded error.
        NSError *const errorToPresent = response ? response.error : decodeError;
        message = [NSString stringWithFormat:@"Payment creation failed with error %@", [errorToPresent localizedDescription]];
    }

    UIAlertController *const alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:NULL];

    return YES;
}

@end
