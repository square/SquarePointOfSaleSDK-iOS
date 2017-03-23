//
//  NSDictionary+SCCAdditions.m
//  SquarePointOfSaleSDK
//
//  Created by Mark Jen on 2/26/14.
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

#import "NSDictionary+SCCAdditions.h"


@implementation NSDictionary (SCCAdditions)

- (nullable NSString *)SCC_stringForKey:(nonnull id)key;
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    return nil;
}

- (nullable NSNumber *)SCC_numberForKey:(nonnull id)key;
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }
    return nil;
}

@end


@implementation NSMutableDictionary (SCCAdditions)

- (void)SCC_setSafeObject:(nullable id)object forKey:(nullable id)key;
{
    if (key && object) {
        [self setObject:(id __nonnull)object forKey:(id __nonnull)key];
    }
}

@end
