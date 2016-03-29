//
//  SCCAPIConnection.m
//  SquareRegisterSDK
//
//  Created by Martin Mroz on 3/7/16.
//  Copyright (c) 2016 Square, Inc.
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

#import <UIKit/UIApplication.h>

#import "SCCAPIConnection.h"

#import "NSError+SCCAdditions.h"
#import "SCCAPIRequest.h"
#import "SCCAPIRequest+Serialization.h"


@implementation SCCAPIConnection

#pragma mark - Class Methods

+ (BOOL)canPerformRequest:(nonnull SCCAPIRequest *)request error:(out NSError *__nullable *__nullable)error;
{
    NSURL *const requestURL = [request APIRequestURLWithError:error];
    if (!requestURL) {
        return NO;
    }

    return [self _canPerformRequestWithURL:requestURL error:error];
}

+ (BOOL)performRequest:(nonnull SCCAPIRequest *)request error:(out NSError *__nullable *__nullable)error;
{
    NSURL *const requestURL = [request APIRequestURLWithError:error];
    if (!requestURL) {
        return NO;
    }

    return [self _performRequestWithURL:requestURL error:error];
}

#pragma mark - Class Methods - Private

+ (BOOL)_canPerformRequestWithURL:(nonnull NSURL *)URL error:(out NSError *__nullable *__nullable)error;
{
    if (![[UIApplication sharedApplication] canOpenURL:URL]) {
        if (error != NULL) {
            *error = [NSError SCC_cannotPerformRequestError];
        }
        return NO;
    }

    return YES;
}

+ (BOOL)_performRequestWithURL:(nonnull NSURL *)URL error:(out NSError *__nullable *__nullable)error;
{
    if (![self _canPerformRequestWithURL:URL error:error]) {
        return NO;
    }

    return [[UIApplication sharedApplication] openURL:URL];
}

@end
