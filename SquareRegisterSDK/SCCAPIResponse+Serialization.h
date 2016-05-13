//
//  SCCAPIResponse+Serialization.h
//  SquareRegisterSDK
//
//  Created by Martin Mroz on 3/28/16.
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

#import <SquareRegisterSDK/SCCAPIResponse.h>


typedef NS_ENUM(NSUInteger, SCCAPIResponseStatus) {
    SCCAPIResponseStatusUnknown = 0,
    SCCAPIResponseStatusOK,
    SCCAPIResponseStatusError
};


/**
 @param statusString The status string.
 @return The SCCAPIResponseStatus corresponding to the status string, or Unknown if invalid.
 */
SCCAPIResponseStatus SCCAPIResponseStatusFromString(NSString *__nullable statusString);


extern NSString *__nonnull const SCCAPIResponseDataKey;
extern NSString *__nonnull const SCCAPIResponseStatusKey;
extern NSString *__nonnull const SCCAPIResponseErrorCodeKey;
extern NSString *__nonnull const SCCAPIResponsePaymentIDKey;
extern NSString *__nonnull const SCCAPIResponseTransactionIDKey;
extern NSString *__nonnull const SCCAPIResponseClientTransactionIDKey;
extern NSString *__nonnull const SCCAPIResponseOfflinePaymentIDKey;
extern NSString *__nonnull const SCCAPIResponseStateKey;

extern NSString *__nonnull const SCCAPIResponseStatusStringOK;
extern NSString *__nonnull const SCCAPIResponseStatusStringError;

