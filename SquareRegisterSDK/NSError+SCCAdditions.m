//
//  NSError+SCCAdditions.m
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

#import "NSError+SCCAdditions.h"


NSString *__nonnull const SCCErrorDomain = @"SCCErrorDomain";


@implementation NSError (SCCAdditions)

#pragma mark - Class Methods - Money Errors

+ (nonnull NSError *)SCC_missingCurrencyCodeError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingCurrencyCode
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_unsupportedCurrencyCodeError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeUnsupportedCurrencyCode
                           userInfo:@{}];
}

#pragma mark - Class Methods - Request Errors

+ (nonnull NSError *)SCC_missingRequestClientIDError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingRequestClientID
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_invalidRequestCallbackURLError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeInvalidRequestCallbackURL
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_invalidRequestAmountError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeInvalidRequestAmount
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_cannotPerformRequestError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeCannotPerformRequest
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_unableToGenerateRequestJSONError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeUnableToGenerateRequestJSON
                           userInfo:@{}];
}

#pragma mark - Class Methods - Response Errors

+ (nonnull NSError *)SCC_missingOrInvalidResponseDataError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseData
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseJSONDataError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseJSONData
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseStatusError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseStatus
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponsePaymentIDError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponsePaymentID
                           userInfo:@{}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseErrorCodeError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseErrorCode
                           userInfo:@{}];
}

@end
