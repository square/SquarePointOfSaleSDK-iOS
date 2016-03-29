//
//  NSError+SCCAdditions.h
//  SquareRegisterSDK
//
//  Created by Martin Mroz on 3/3/16.
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


/// The domain associated with all errors generated within the SDK.
extern NSString *__nonnull const SCCErrorDomain;


typedef NS_ENUM(NSUInteger, SCCErrorCode) {
    /// An unknown error.
    SCCErrorCodeUnknown = 0,

    /// No currency code was specified.
    SCCErrorCodeMissingCurrencyCode,

    // An unsupported or invalid currency code was specified.
    SCCErrorCodeUnsupportedCurrencyCode,

    /// No client ID was specified to build a request.
    SCCErrorCodeMissingRequestClientID,

    /// An invalid callback URL was specified.
    SCCErrorCodeInvalidRequestCallbackURL,

    /// An invalid amount was specified.
    SCCErrorCodeInvalidRequestAmount,

    /// The request could not be performed.
    SCCErrorCodeCannotPerformRequest,

    /// The JSON body of the request could not be generated.
    SCCErrorCodeUnableToGenerateRequestJSON,

    /// The data parameter in the response URL was missing or invalid.
    SCCErrorCodeMissingOrInvalidResponseData,

    /// The JSON data in the response URL was missing or invalid.
    SCCErrorCodeMissingOrInvalidResponseJSONData,

    /// The response status field was missing or invalid.
    SCCErrorCodeMissingOrInvalidResponseStatus,

    /// The payment ID or offline payment ID field was missing or invalid.
    SCCErrorCodeMissingOrInvalidResponsePaymentID,

    /// The error code on an unsuccessful response was missing or invalid.
    SCCErrorCodeMissingOrInvalidResponseErrorCode,
};


@interface NSError (SCCAdditions)

///
/// @name Money Errors
///

/**
 @return An error indicating that no currency code was specified.
 */
+ (nonnull NSError *)SCC_missingCurrencyCodeError;

/**
 @return An error indicating that an unsupported or invalid currency code was specified.
 */
+ (nonnull NSError *)SCC_unsupportedCurrencyCodeError;

///
/// @name Request Errors
///

/**
 @return An error indicating that no client ID was specified.
 */
+ (nonnull NSError *)SCC_missingRequestClientIDError;

/**
 @return An error indicating that an invalid callback URL was specified.
 */
+ (nonnull NSError *)SCC_invalidRequestCallbackURLError;

/**
 @return An error indicating that an invalid amount was specified.
 */
+ (nonnull NSError *)SCC_invalidRequestAmountError;

/**
 @return An error indicating that the request could not be performed.
 */
+ (nonnull NSError *)SCC_cannotPerformRequestError;

/**
 @return An error indicating that the JSON body of the request could not be generated.
 */
+ (nonnull NSError *)SCC_unableToGenerateRequestJSONError;

///
/// @name Response Errors
///

/**
 @return An error indicating that the data parameter in the response URL was missing or invalid.
 */
+ (nonnull NSError *)SCC_missingOrInvalidResponseDataError;

/**
 @return An error indicating that the JSON data in the response URL was missing or invalid.
 */
+ (nonnull NSError *)SCC_missingOrInvalidResponseJSONDataError;

/**
 @return An error indicating that the response status field was missing or invalid.
 */
+ (nonnull NSError *)SCC_missingOrInvalidResponseStatusError;

/**
 @return An error indicating that the response payment ID or offline payment ID field was missing or invalid.
 */
+ (nonnull NSError *)SCC_missingOrInvalidResponsePaymentIDError;

/**
 @return An error indicating that the error code on an unsuccessful response was missing or invalid.
 */
+ (nonnull NSError *)SCC_missingOrInvalidResponseErrorCodeError;

@end
