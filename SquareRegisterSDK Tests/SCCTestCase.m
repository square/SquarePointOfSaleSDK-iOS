//
//  SCCTestCase.m
//  SquareRegisterSDK
//
//  Created by Kyle Van Essen on 12/13/2013.
//  Copyright (c) 2013 Square, Inc.
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

#import "SCCTestCase.h"

#import "NSURL+SCCAdditions.h"


@implementation SCCTestCase

#pragma mark - XCTestCase

- (NSString *)queryStringForData:(NSDictionary *)dictData
{
    NSError *error;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictData options:0 error:&error];
    XCTAssertNil(error);

    NSString *queryStr = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    NSString *encodedStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
        kCFAllocatorDefault,
        (CFStringRef)queryStr,
        NULL,
        CFSTR(":/?#[]@!$&'()*+,;="),
        kCFStringEncodingUTF8));
    
    XCTAssertNotNil(encodedStr);
    return encodedStr;
}

- (NSDictionary *)dataForURL:(NSURL *)url
{
    NSDictionary *parameters = [url SCC_HTTPGETParameters];
    NSString *dataString = parameters[@"data"];
    XCTAssertNotEqual(dataString.length, 0);

    NSError *error = nil;
    NSObject *JSONObject = (NSObject *)[NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    XCTAssertNil(error);

    XCTAssertTrue([JSONObject isKindOfClass:[NSDictionary class]]);

    return (NSDictionary *)JSONObject;
}
@end
