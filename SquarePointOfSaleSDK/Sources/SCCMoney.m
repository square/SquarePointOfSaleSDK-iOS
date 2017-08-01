//
//  SCCMoney.m
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

#import "SCCMoney.h"
#import "SCCMoney+Serialization.h"

#import "NSError+SCCAdditions.h"


NSString *__nonnull const SCCMoneyRequestDictionaryAmountKey = @"amount";
NSString *__nonnull const SCCMoneyRequestDictionaryCurrencyCodeKey = @"currency_code";


@implementation SCCMoney

#pragma mark - Class Methods

+ (nullable instancetype)moneyWithAmountCents:(NSInteger)amountCents
                                 currencyCode:(nonnull NSString *)currencyCode
                                        error:(out NSError *__nullable *__nullable)error;
{
    if (!currencyCode.length) {
        if (error) {
            *error = [NSError SCC_missingCurrencyCodeError];
        }
        return nil;
    }

    return [[self alloc] initWithAmountCents:amountCents currencyCode:currencyCode];
}

#pragma mark - Initialization

- (instancetype)initWithAmountCents:(NSInteger)amount currencyCode:(nonnull NSString *)currencyCode;
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _amountCents = amount;
    _currencyCode = [currencyCode copy];

    return self;
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
{
    // As an immutable value type, self may be returned in place of a copy.
    return self;
}

#pragma mark - NSObject

- (NSUInteger)hash;
{
    return (NSUInteger)self.amountCents ^ self.currencyCode.hash;
}

- (BOOL)isEqual:(nullable id)object;
{
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[SCCMoney class]]) {
        return NO;
    }

    return [self isEqualToSCCMoney:(SCCMoney *)object];
}

- (nonnull NSString *)description;
{
    return [NSString stringWithFormat:@"<%@: %p> { cents: %@, currency: %@ }",
        NSStringFromClass(self.class),
        self,
        @(self.amountCents),
        self.currencyCode];
}

#pragma mark - Public Methods

- (BOOL)isEqualToSCCMoney:(nullable SCCMoney *)money;
{
    if (!money) {
        return NO;
    }

    if (self.amountCents != money.amountCents) {
        return NO;
    }

    if (![self.currencyCode isEqualToString:(NSString *__nonnull)money.currencyCode]) {
        return NO;
    }

    return YES;
}

@end


@implementation SCCMoney (Serialization)

- (nonnull NSDictionary *)requestDictionaryRepresentation;
{
    return @{
        SCCMoneyRequestDictionaryAmountKey : @(self.amountCents),
        SCCMoneyRequestDictionaryCurrencyCodeKey : self.currencyCode
    };
}

@end
