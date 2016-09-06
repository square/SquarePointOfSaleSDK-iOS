//
//  NSError+SCCAPIAdditions.m
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

#import "NSError+SCCAPIAdditions.h"
#import "NSError+SCCAPISerializationAdditions.h"


NSString *__nonnull const SCCAPIErrorStringPaymentCanceled = @"payment_canceled";
NSString *__nonnull const SCCAPIErrorStringPayloadMissingOrInvalid = @"data_invalid";
NSString *__nonnull const SCCAPIErrorStringAppNotLoggedIn = @"not_logged_in";
NSString *__nonnull const SCCAPIErrorStringMerchantIDMismatch = @"user_id_mismatch";
NSString *__nonnull const SCCAPIErrorStringClientNotAuthorizedForUser = @"client_not_authorized_for_user";
NSString *__nonnull const SCCAPIErrorStringUserNotActivated = @"user_not_active";
NSString *__nonnull const SCCAPIErrorStringCurrencyMissingOrInvalid = @"currency_code_missing";
NSString *__nonnull const SCCAPIErrorStringCurrencyUnsupported = @"unsupported_currency_code";
NSString *__nonnull const SCCAPIErrorStringCurrencyMismatch = @"currency_code_mismatch";
NSString *__nonnull const SCCAPIErrorStringAmountMissingOrInvalid = @"amount_invalid_format";
NSString *__nonnull const SCCAPIErrorStringAmountTooSmall = @"amount_too_small";
NSString *__nonnull const SCCAPIErrorStringAmountTooLarge = @"amount_too_large";
NSString *__nonnull const SCCAPIErrorStringInvalidTenderType = @"invalid_tender_type";
NSString *__nonnull const SCCAPIErrorStringUnsupportedTenderType = @"unsupported_tender_type";
NSString *__nonnull const SCCAPIErrorStringCouldNotPerform = @"could_not_perform";
NSString *__nonnull const SCCAPIErrorStringNoNetworkConnection = @"no_network_connection";
NSString *__nonnull const SCCAPIErrorStringUnsupportedAPIVersion = @"unsupported_api_version";
NSString *__nonnull const SCCAPIErrorStringInvalidVersionNumber = @"invalid_version_number";


NSString *__nonnull const SCCAPIErrorDomain = @"SCCAPIErrorDomain";

NSString *__nonnull const SCCAPIErrorUserInfoCodeStringKey = @"error_code";


@implementation NSError (SCCAPIAdditions)

+ (nonnull NSError *)SCC_APIErrorWithCode:(SCCAPIErrorCode)code;
{
    NSString *const errorCodeString = NSStringFromSCCAPIErrorCode(code);

    NSDictionary *userInfo = nil;
    if (errorCodeString.length > 0) {
        userInfo = @{
            SCCAPIErrorUserInfoCodeStringKey : errorCodeString
        };
    }

    return [[NSError alloc] initWithDomain:SCCAPIErrorDomain code:code userInfo:userInfo];
}

@end


SCCAPIErrorCode SCCAPIErrorCodeFromString(NSString *__nullable errorCodeString)
{
    if (errorCodeString.length == 0) {
        return SCCAPIErrorCodeUnknown;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringPaymentCanceled]) {
        return SCCAPIErrorCodePaymentCanceled;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringPayloadMissingOrInvalid]) {
        return SCCAPIErrorCodePayloadMissingOrInvalid;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAppNotLoggedIn]) {
        return SCCAPIErrorCodeAppNotLoggedIn;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringMerchantIDMismatch]) {
        return SCCAPIErrorCodeMerchantIDMismatch;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUserNotActivated]) {
        return SCCAPIErrorCodeUserNotActivated;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyMissingOrInvalid]) {
        return SCCAPIErrorCodeCurrencyMissingOrInvalid;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyUnsupported]) {
        return SCCAPIErrorCodeCurrencyUnsupported;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyMismatch]) {
        return SCCAPIErrorCodeCurrencyMismatch;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountMissingOrInvalid]) {
        return SCCAPIErrorCodeAmountMissingOrInvalid;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountTooSmall]) {
        return SCCAPIErrorCodeAmountTooSmall;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountTooLarge]) {
        return SCCAPIErrorCodeAmountTooLarge;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidTenderType]) {
        return SCCAPIErrorCodeInvalidTenderType;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUnsupportedTenderType]) {
        return SCCAPIErrorCodeUnsupportedTenderType;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCouldNotPerform]) {
        return SCCAPIErrorCodeCouldNotPerform;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringNoNetworkConnection]) {
        return SCCAPIErrorCodeNoNetworkConnection;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringClientNotAuthorizedForUser]) {
        return SCCAPIErrorCodeClientNotAuthorizedForUser;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUnsupportedAPIVersion]) {
        return SCCAPIErrorCodeUnsupportedAPIVersion;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidVersionNumber]) {
        return SCCAPIErrorCodeInvalidVersionNumber;
    }

    return SCCAPIErrorCodeUnknown;
}

NSString *__nullable NSStringFromSCCAPIErrorCode(SCCAPIErrorCode errorCode)
{
    switch (errorCode) {
        case SCCAPIErrorCodeUnknown:
            return nil;
        case SCCAPIErrorCodePaymentCanceled:
            return SCCAPIErrorStringPaymentCanceled;
        case SCCAPIErrorCodePayloadMissingOrInvalid:
            return SCCAPIErrorStringPayloadMissingOrInvalid;
        case SCCAPIErrorCodeAppNotLoggedIn:
            return SCCAPIErrorStringAppNotLoggedIn;
        case SCCAPIErrorCodeUnused:
            return nil;
        case SCCAPIErrorCodeMerchantIDMismatch:
            return SCCAPIErrorStringMerchantIDMismatch;
        case SCCAPIErrorCodeUserNotActivated:
            return SCCAPIErrorStringUserNotActivated;
        case SCCAPIErrorCodeCurrencyMissingOrInvalid:
            return SCCAPIErrorStringCurrencyMissingOrInvalid;
        case SCCAPIErrorCodeCurrencyUnsupported:
            return SCCAPIErrorStringCurrencyUnsupported;
        case SCCAPIErrorCodeCurrencyMismatch:
            return SCCAPIErrorStringCurrencyMismatch;
        case SCCAPIErrorCodeAmountMissingOrInvalid:
            return SCCAPIErrorStringAmountMissingOrInvalid;
        case SCCAPIErrorCodeAmountTooSmall:
            return SCCAPIErrorStringAmountTooSmall;
        case SCCAPIErrorCodeAmountTooLarge:
            return SCCAPIErrorStringAmountTooLarge;
        case SCCAPIErrorCodeInvalidTenderType:
            return SCCAPIErrorStringInvalidTenderType;
        case SCCAPIErrorCodeUnsupportedTenderType:
            return SCCAPIErrorStringUnsupportedTenderType;
        case SCCAPIErrorCodeCouldNotPerform:
            return SCCAPIErrorStringCouldNotPerform;
        case SCCAPIErrorCodeNoNetworkConnection:
            return SCCAPIErrorStringNoNetworkConnection;
        case SCCAPIErrorCodeClientNotAuthorizedForUser:
            return SCCAPIErrorStringClientNotAuthorizedForUser;
        case SCCAPIErrorCodeUnsupportedAPIVersion:
            return SCCAPIErrorStringUnsupportedAPIVersion;
        case SCCAPIErrorCodeInvalidVersionNumber:
            return SCCAPIErrorStringInvalidVersionNumber;
    }

    return nil;
}
