//
//  NSDictionary+SCCAdditions.h
//  SquareRegisterSDK
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

#import <Foundation/Foundation.h>


@interface NSDictionary (SCCAdditions)

/**
 @param key Key into the receiver.
 @return The value in the receiver associated with `key` if that value is an NSString instance, or nil.
 */
- (nullable NSString *)SCC_stringForKey:(nonnull id)key;

/**
 @param key Key into the receiver.
 @return The value in the receiver associated with `key` if that value is an NSNumber instance, or nil.
 */
- (nullable NSNumber *)SCC_numberForKey:(nonnull id)key;

@end


@interface NSMutableDictionary (SCCAdditions)

/**
 Sets the `object` associated with `key` in the receiver if both are non-nil.
 @param object The object to associate with the key in the receiver, or nil.
 @param key The key to associate the object with in the receiver, or nil.
 */
- (void)SCC_setSafeObject:(nullable id)object forKey:(nullable id)key;

@end
