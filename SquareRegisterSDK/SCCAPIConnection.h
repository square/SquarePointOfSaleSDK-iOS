//
//  SCCAPIConnection.h
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

#import <Foundation/Foundation.h>


@class SCCAPIRequest;


/**
 Validates and executes Register API requests.
 */
@interface SCCAPIConnection : NSObject

/**
 @param request Request to validate.
 @param error Stores an error when available to indicate the request cannot be performed.
 @return YES if the request can be performed.
 */
+ (BOOL)canPerformRequest:(nonnull SCCAPIRequest *)request error:(out NSError *__nullable *__nullable)error;

/**
 @param request Request to perform.
 @param error Stores an error when available to indicate the request cannot be performed.
 @return YES if the request was successfully performed.
 */
+ (BOOL)performRequest:(nonnull SCCAPIRequest *)request error:(out NSError *__nullable *__nullable)error;

@end


@interface SCCAPIConnection ()

+ (nonnull instancetype)new  NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
