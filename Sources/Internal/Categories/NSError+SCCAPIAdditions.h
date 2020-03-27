//
//  NSError+SCCAPIAdditions.h
//  SquarePointOfSaleSDK
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
    SCCAPIErrorCodeUnused,
    SCCAPIErrorCodeLocationIDMismatch,
    SCCAPIErrorCodeMerchantIDMismatch __deprecated_enum_msg("Starting with Point of Sale API version 1.3, this error code has been replaced by SCCAPIErrorCodeLocationIDMismatch.") = SCCAPIErrorCodeLocationIDMismatch,
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
    SCCAPIErrorCodeClientNotAuthorizedForUser __deprecated_enum_msg("Starting with Point of Sale API version 1.2, the OAuth authorization flow is no longer required for Point of Sale API, and this error will never be returned."),
    SCCAPIErrorCodeUnsupportedAPIVersion,
    SCCAPIErrorCodeInvalidVersionNumber,
    SCCAPIErrorCodeCustomerManagementNotSupported,
    SCCAPIErrorCodeInvalidCustomerID
};


@interface NSError (SCCAPIAdditions)

/**
 @param errorCodeString A Point of Sale API error code string.
 @return A new Point of Sale API error with an appropriate numeric code in the `SCCAPIErrorDomain`.
 The user info dictionary associated with the error will include, if available,
 the error code string associated with the `SCCAPIErrorUserInfoCodeStringKey`.
 
 Note that this string is intended to be seen by developers only.  Developers should present 
 their own error messaging to merchants as appropriate.
 */
+ (nonnull NSError *)SCC_APIErrorWithErrorCodeString:(NSString *_Nonnull)errorCodeString;

/**
 @param errorCodeString A Point of Sale API error code string.
 @return A human-readable description of the error represented by the error code string.
 
 Note that this string is intended to be seen by developers only.  Developers should present 
 their own error messaging to merchants as appropriate.
 */
+ (nullable NSString *)SCC_localizedDescriptionForErrorCodeString:(nonnull NSString *)errorCodeString;

@end
