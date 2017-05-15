//
//  AppDelegate.m
//  HelloCharge
//
//  Created by Joseph Hankin on 9/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

#import "HelloChargeAppDelegate.h"

@import SquarePointOfSaleSDK;


@implementation HelloChargeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
{
    NSString *const sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    // Make sure the URL comes from Square Register; fail if it doesn't.
    if (![sourceApplication hasPrefix:@"com.squareup.square"]) {
        return NO;
    }
    
    // The response data is encoded in the URL and can be decoded as an SCCAPIResponse.
    NSError *decodeError = nil;
    SCCAPIResponse *const response = [SCCAPIResponse responseWithResponseURL:url error:&decodeError];
    
    NSString *message = nil;
    NSString *title = nil;
    
    // Process the response as desired.
    if (response.isSuccessResponse && !decodeError) {
        title = @"Success!";
        message = [NSString stringWithFormat:@"Request succeeded: %@", response];
    } else {
        title = @"Error!";
        
        // An invalid response message error is distinct from a successfully decoded error.
        NSError *const errorToPresent = response ? response.error : decodeError;
        message = [NSString stringWithFormat:@"Request failed: %@", [errorToPresent localizedDescription]];
    }
    
    UIAlertController *const alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:NULL];
    
    return YES;
}

@end
