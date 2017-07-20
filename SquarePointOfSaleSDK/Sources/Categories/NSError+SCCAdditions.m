//
//  NSError+SCCAdditions.m
//  SquarePointOfSaleSDK
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
                           userInfo:@{NSLocalizedDescriptionKey : @"Currency code was missing.  Please provide a valid currency code."}];
}

#pragma mark - Class Methods - Request Errors

+ (nonnull NSError *)SCC_missingRequestClientIDError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingRequestClientID
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing Client ID.  You must call +[SCCAPIRequest setClientID:] with the Application ID found in your Square Application Dashboard before making a request."}];
}

+ (nonnull NSError *)SCC_invalidRequestCallbackURLError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeInvalidRequestCallbackURL
                           userInfo:@{NSLocalizedDescriptionKey : @"Invalid Callback URL.  Your callback URL must begin with a valid scheme (i.e., \"some-string://\")"}];
}

+ (nonnull NSError *)SCC_invalidRequestAmountError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeInvalidRequestAmount
                           userInfo:@{NSLocalizedDescriptionKey : @"Invalid Request Amount.  You must provide a valid SCCMoney object with a cents amount greater than zero."}];
}

+ (nonnull NSError *)SCC_cannotOpenApplicationError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeCannotOpenApplication
                           userInfo:@{NSLocalizedDescriptionKey : @"Cannot Open Point of Sale.  Ensure that you have added an LSApplicationQueriesSchemes array to your Info.plist containing the value \"square-commerce-v1\" and that Square Point of Sale is installed on your device."}];
}

+ (nonnull NSError *)SCC_unableToGenerateRequestJSONError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeUnableToGenerateRequestJSON
                           userInfo:@{NSLocalizedDescriptionKey : @"Unable to Generate Request JSON.  Please report this error to developers@squareup.com with an example of your request object."}];
}

#pragma mark - Class Methods - Response Errors

+ (nonnull NSError *)SCC_missingOrInvalidResponseDataError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseData
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing or Invalid Response Data.  Please report this error to developers@squareup.com with your request URL, the response URL and the version of Square Point of Sale you are running."}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseJSONDataError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseJSONData
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing or Invalid Response JSON.  Please report this error to developers@squareup.com with your request URL, the response URL and the version of Square Point of Sale you are running."}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseStatusError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseStatus
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing or Invalid Response Status.  Please report this error to developers@squareup.com with your request URL, the response URL and the version of Square Point of Sale you are running."}];
}

+ (nonnull NSError *)SCC_missingOrInvalidResponseErrorCodeError;
{
    return [NSError errorWithDomain:SCCErrorDomain
                               code:SCCErrorCodeMissingOrInvalidResponseErrorCode
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing or Invalid Error Code.  Please report this error to developers@squareup.com with your request URL, the response URL and the version of Square Point of Sale you are running."}];
}

@end
