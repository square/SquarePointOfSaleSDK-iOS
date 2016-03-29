//
//  SCCAPIRequest+Serialization.h
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

#import <SquareRegisterSDK/SCCAPIRequest.h>


extern NSString *__nonnull const SCCAPIRequestClientIDKey;
extern NSString *__nonnull const SCCAPIRequestAmountMoneyKey;
extern NSString *__nonnull const SCCAPIRequestCallbackURLKey;
extern NSString *__nonnull const SCCAPIRequestLoginCodeKey;
extern NSString *__nonnull const SCCAPIRequestStateKey;
extern NSString *__nonnull const SCCAPIRequestMerchantIDKey;
extern NSString *__nonnull const SCCAPIRequestNotesKey;
extern NSString *__nonnull const SCCAPIRequestOptionsKey;
extern NSString *__nonnull const SCCAPIRequestOptionsClearDefaultFeesKey;
extern NSString *__nonnull const SCCAPIRequestOptionsSupportedTenderTypesKey;
extern NSString *__nonnull const SCCAPIRequestOptionsAutoReturnKey;
extern NSString *__nonnull const SCCAPIRequestOptionsTenderTypeStringCard;


/**
 @param tenderTypes Combination of API Request Tender Types.
 @return An array of API strings corresponding to the tender types specified.
 */
NSArray *__nonnull NSArrayOfTenderTypeStringsFromSCCAPIRequestTenderTypes(SCCAPIRequestTenderTypes tenderTypes);


@interface SCCAPIRequest (Serialization)

/**
 Generates the URL that the request would use to communicate with Square Register, based on current property values.
 @param error Stores an error (domain SCCErrorDomain) in the event the URL could not be generated.
 @return The URL corresponding to the API request, or `nil`.
 */
- (nullable NSURL *)APIRequestURLWithError:(out NSError *__nullable *__nullable)error;

@end
