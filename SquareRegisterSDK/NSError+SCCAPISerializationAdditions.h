//
//  NSError+SCCAPISerializationAdditions.h
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


extern NSString *__nonnull const SCCAPIErrorStringPaymentCanceled;
extern NSString *__nonnull const SCCAPIErrorStringPayloadMissingOrInvalid;
extern NSString *__nonnull const SCCAPIErrorStringAppNotLoggedIn;
extern NSString *__nonnull const SCCAPIErrorStringLoginCodeInvalidOrExpired;
extern NSString *__nonnull const SCCAPIErrorStringMerchantIDMismatch;
extern NSString *__nonnull const SCCAPIErrorStringClientNotAuthorizedForUser;
extern NSString *__nonnull const SCCAPIErrorStringUserNotActivated;
extern NSString *__nonnull const SCCAPIErrorStringCurrencyMissingOrInvalid;
extern NSString *__nonnull const SCCAPIErrorStringCurrencyUnsupported;
extern NSString *__nonnull const SCCAPIErrorStringCurrencyMismatch;
extern NSString *__nonnull const SCCAPIErrorStringAmountMissingOrInvalid;
extern NSString *__nonnull const SCCAPIErrorStringAmountTooSmall;
extern NSString *__nonnull const SCCAPIErrorStringAmountTooLarge;
extern NSString *__nonnull const SCCAPIErrorStringInvalidTenderType;
extern NSString *__nonnull const SCCAPIErrorStringUnsupportedTenderType;
extern NSString *__nonnull const SCCAPIErrorStringCouldNotPerform;
extern NSString *__nonnull const SCCAPIErrorStringNoNetworkConnection;


/**
 @param errorCodeString The string value of the API error code.
 @return The SCCAPIErrorCode corresponding to the error code string, or Unknown if invalid.
 */
SCCAPIErrorCode SCCAPIErrorCodeFromString(NSString *__nullable errorCodeString);

/**
 @param errorCode The error code.
 @return The API error code string corresponding to the error code.
 */
NSString *__nullable NSStringFromSCCAPIErrorCode(SCCAPIErrorCode errorCode);
