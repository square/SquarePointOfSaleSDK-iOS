//
//  NSError+SCCAPIAdditions.m
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

#import "NSError+SCCAPIAdditions.h"
#import "NSError+SCCAPISerializationAdditions.h"


NSString *__nonnull const SCCAPIErrorStringPaymentCanceled = @"payment_canceled";
NSString *__nonnull const SCCAPIErrorStringPayloadMissingOrInvalid = @"data_invalid";
NSString *__nonnull const SCCAPIErrorStringAppNotLoggedIn = @"not_logged_in";
NSString *__nonnull const SCCAPIErrorStringLocationIDMismatch = @"location_id_mismatch";
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
NSString *__nonnull const SCCAPIErrorStringCustomerManagementNotSupported = @"customer_management_not_supported";
NSString *__nonnull const SCCAPIErrorStringInvalidCustomerID = @"invalid_customer_id";

NSString *__nonnull const SCCAPIErrorDomain = @"SCCAPIErrorDomain";

NSString *__nonnull const SCCAPIErrorUserInfoCodeStringKey = @"error_code";

// deprecated errors
NSString *__nonnull const SCCAPIErrorStringMerchantIDMismatch = @"location_id_mismatch";
NSString *__nonnull const SCCAPIErrorStringClientNotAuthorizedForUser = @"client_not_authorized_for_user";


@implementation NSError (SCCAPIAdditions)

+ (nonnull NSError *)SCC_APIErrorWithErrorCodeString:(nonnull NSString *)errorCodeString;
{
    SCCAPIErrorCode code = SCCAPIErrorCodeFromString(errorCodeString);
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if (errorCodeString.length > 0) {
        userInfo[SCCAPIErrorUserInfoCodeStringKey] = errorCodeString;
    }

    NSString *const description = [self SCC_localizedDescriptionForErrorCodeString:errorCodeString];
    if (description.length > 0) {
        userInfo[NSLocalizedDescriptionKey] = description;
    }

    return [[NSError alloc] initWithDomain:SCCAPIErrorDomain code:code userInfo:[userInfo copy]];
}

+ (nullable NSString *)SCC_localizedDescriptionForErrorCodeString:(nonnull NSString *)errorCodeString;
{
    if (errorCodeString.length == 0) {
        return nil;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringPaymentCanceled]) {
        return @"Payment canceled.  Retry the request to complete the payment.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringPayloadMissingOrInvalid]) {
        return @"Payload missing or invalid.  Check that you have a valid amount_money dictionary and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAppNotLoggedIn]) {
        return @"App not logged in.  Ensure that you are logged in to Square Point of Sale and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringLocationIDMismatch]) {
        return @"Location ID mismatch.  The ID for the location selected in Square Point of Sale does not match the location_id parameter in the request.  Check the location_id parameter and the selected location and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUserNotActivated]) {
        return @"User not activated. Please visit https://squareup.com/activate. The logged-in account cannot take credit card payments.  This could be because the account is from a country where Square does not process payments, because the account did not complete the initial activation flow, or because it has been deactivated for security reasons.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyMissingOrInvalid]) {
        return @"Currency missing or invalid.  Ensure that your amount_money dictionary contains a code from the set of supported ISO 4217 currency codes found in SCCMoney and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyUnsupported]) {
        return @"Currency unsupported.  Ensure that your amount_money dictionary contains a code from the set of supported ISO 4217 currency codes found in SCCMoney and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCurrencyMismatch]) {
        return @"Currency code mismatch.  The currency code in your amount_money dictionary does not match the currency code for the logged-in account.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountMissingOrInvalid]) {
        return @"Amount missing or invalid.  Ensure that the amount specified in the amount_money dictionary is an integer of the minimum denomination of that currency (e.g. cents).";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountTooSmall]) {
        return @"Amount too small.  Ensure the amount is greater than the minimum credit card amount (e.g., $1.00) or add a non-card tender type to your request.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringAmountTooLarge]) {
        return @"Amount too large.  Ensure the amount is less than the maximum credit card amount (e.g., $50,000) or add a non-card tender type to your request.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidTenderType]) {
        return @"Invalid tender type.  A string in the supported_tender_types array was not recognized by Point of Sale.  Check your tender types and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUnsupportedTenderType]) {
        return @"Unsupported tender type.  One of the tender types in your supported_tender_types array is not supported by this version of Square Point of Sale.  Ensure that you are on the most recent version of Square Point of Sale and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCouldNotPerform]) {
        return @"Could not perform.  This error is most likely due to a previous Point of Sale API transaction that was started but not completed.  Open Square Point of Sale and finish the transaction before retrying your request.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringNoNetworkConnection]) {
        return @"No network connection.  Before processing payments, Square Point of Sale must be able to reach the Internet to validate the calling application.  Please connect to the Internet and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUnsupportedAPIVersion]) {
        return @"Unsupported API version.  The API version specified in the request is not supported by this version of Square Point of Sale.  Ensure that you are on the most recent version of Square Point of Sale and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidVersionNumber]) {
        return @"Invalid version number.  The specified API version is not in a form that Square Point of Sale recognizes.  Ensure that the version parameter you are passing is in standard decimal form (e.g., 1.1) and try again.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCustomerManagementNotSupported]) {
        return @"Customer management not supported. This account does not have customer management enabled and therefore cannot associate transactions with customers.";
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidCustomerID]) {
        return @"Invalid customer ID. The customer_id specified does not correspond to a merchant's customer.";
    }

    return nil;
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

    if ([errorCodeString isEqualToString:SCCAPIErrorStringLocationIDMismatch]) {
        return SCCAPIErrorCodeLocationIDMismatch;
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

    if ([errorCodeString isEqualToString:SCCAPIErrorStringUnsupportedAPIVersion]) {
        return SCCAPIErrorCodeUnsupportedAPIVersion;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidVersionNumber]) {
        return SCCAPIErrorCodeInvalidVersionNumber;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringCustomerManagementNotSupported]) {
        return SCCAPIErrorCodeCustomerManagementNotSupported;
    }

    if ([errorCodeString isEqualToString:SCCAPIErrorStringInvalidCustomerID]) {
        return SCCAPIErrorCodeInvalidCustomerID;
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
        case SCCAPIErrorCodeLocationIDMismatch:
            return SCCAPIErrorStringLocationIDMismatch;
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
        case SCCAPIErrorCodeCustomerManagementNotSupported:
            return SCCAPIErrorStringCustomerManagementNotSupported;
        case SCCAPIErrorCodeInvalidCustomerID:
            return SCCAPIErrorStringInvalidCustomerID;
    }

    return nil;
}
