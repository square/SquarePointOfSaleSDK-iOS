//
//  NSURL+SCCAdditions.h
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


@interface NSURL (SCCAdditions)

/**
 @return A dictionary mapping GET parameters with their values after replacing percent escapes.
   Any GET parameters specifying a key, but no value ("?key") will be included in the
   parameters dictionary with a value of `[NSNull null]`.
 */
- (nonnull NSDictionary *)SCC_HTTPGETParameters;

@end
