//
//  SCCMoney.h
//  SquarePointOfSaleSDK
//
//  Created by Mark Jen on 2/9/14.
//  Copyright (c) 2014 Square, Inc.
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

/// The key associated with cents amount number in a dictionary representation of a money object.
extern NSString *__nonnull const SCCMoneyRequestDictionaryAmountKey;

/// The key associated with ISO currency code string in a dictionary representation of a money object.
extern NSString *__nonnull const SCCMoneyRequestDictionaryCurrencyCodeKey;

/**
 An immutable value type representing a chargeable amount in a specific currency.
 */
@interface SCCMoney : NSObject <NSCopying>

/**
 @param amountCents The amount of money, in the smallest denomination of the currency specified by
                    `currencyCode`. For example, when the currency is USD, the amount is in cents,
                    and when the currency is JPY, the amount is in Yen.
 @param currencyCode ISO 4217 currency code associated with the amount.
 @param error Stores an error (domain SCCErrorDomain) in the event one or more parameters are invalid.
 @return A new money value consisting of a currency code and value or `nil` if an invalid parameter is specified.
 */
+ (nullable instancetype)moneyWithAmountCents:(NSInteger)amountCents
                                 currencyCode:(nonnull NSString *)currencyCode
                                        error:(out NSError *__nullable *__nullable)error;

/**
 The amount of money, in the smallest denomination of the currency specified by `currencyCode`. For example,
 when the currency is USD, the amount is in cents, and when the currency is JPY, the amount is in Yen.
 */
@property (nonatomic, assign, readonly) NSInteger amountCents;

/// ISO 4217 currency code associated with the amount.
@property (nonatomic, copy, readonly, nonnull) NSString *currencyCode;

/**
 @return YES if the argument is logically equal to the receiver.
 */
- (BOOL)isEqualToSCCMoney:(nullable SCCMoney *)money;

/**
 @return The dictionary representation of the value amount suitable for use in an API request.
 */
- (nonnull NSDictionary *)requestDictionaryRepresentation;

@end


@interface SCCMoney ()

/**
 @see moneyWithAmountCents:currencyCode:error
 */
+ (nonnull instancetype)new  NS_UNAVAILABLE;

/**
 @see moneyWithAmountCents:currencyCode:error
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
