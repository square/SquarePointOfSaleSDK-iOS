//
//  NSError+SCCAPIAdditions.h
//  SquareRegisterSDK
//
//  Created by Martin Mroz on 3/14/16.
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


/// The domain associated with all API errors.
extern NSString *__nonnull const SCCAPIErrorDomain;

/// The user info key associated with a string representation of the error code if applicable.
extern NSString *__nonnull const SCCAPIErrorUserInfoCodeStringKey;


typedef NS_ENUM(NSUInteger, SCCAPIErrorCode) {
    SCCAPIErrorCodeUnknown = 0,
    SCCAPIErrorCodePaymentCanceled,
    SCCAPIErrorCodePayloadMissingOrInvalid,
    SCCAPIErrorCodeAppNotLoggedIn,
    SCCAPIErrorCodeLoginCodeInvalidOrExpired,
    SCCAPIErrorCodeMerchantIDMismatch,
    SCCAPIErrorCodeUserNotActivated,
    SCCAPIErrorCodeCurrencyMissingOrInvalid,
    SCCAPIErrorCodeCurrencyUnsupported,
    SCCAPIErrorCodeCurrencyMismatch,
    SCCAPIErrorCodeAmountMissingOrInvalid,
    SCCAPIErrorCodeAmountTooSmall,
    SCCAPIErrorCodeAmountTooLarge,
    SCCAPIErrorCodeInvalidTenderType,
    SCCAPIErrorCodeUnsupportedTenderType,
    SCCAPIErrorCodeCouldNotPerform,
    SCCAPIErrorCodeNoNetworkConnection,
    SCCAPIErrorCodeClientNotAuthorizedForUser,
};


@interface NSError (SCCAPIAdditions)

/**
 @param code A Register API error code.
 @return A new register API error with `code` in the `SCCAPIErrorDomain`.
   The user info dictionary associated with the error will include, if available, 
   the error code string associated with the `SCCAPIErrorUserInfoCodeStringKey`.
 */
+ (nonnull NSError *)SCC_APIErrorWithCode:(SCCAPIErrorCode)code;

@end
