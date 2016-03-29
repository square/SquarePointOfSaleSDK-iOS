//
//  SCCMoney+Serialization.h
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

#import <SquareRegisterSDK/SCCMoney.h>


/// The key associated with cents amount number in a dictionary representation of a money object.
extern NSString *__nonnull const SCCMoneyRequestDictionaryAmountKey;

/// The key associated with ISO currency code string in a dictionary representation of a money object.
extern NSString *__nonnull const SCCMoneyRequestDictionaryCurrencyCodeKey;


@interface SCCMoney (Serialization)

/**
 @return The dictionary representation of the value amount suitable for use in an API request.
 */
- (nonnull NSDictionary *)requestDictionaryRepresentation;

@end
