//
//  SCCAPIConnection_Testing.h
//  SquarePointOfSaleSDK
//
//  Created by Sachin Patel on 8/3/16.
//  Copyright (c) 2017 Square, Inc.
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

#import "SCCAPIConnection.h"


@class SCCAPIRequest;

@interface SCCAPIConnection (Protected)

+ (BOOL)_canPerformRequest:(nonnull SCCAPIRequest *)request error:(out NSError *__nullable *__nullable)error application:(nonnull UIApplication *)application;

@end
