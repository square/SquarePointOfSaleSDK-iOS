//
//  SCAPIURLConversionTests.m
//  SquareRegisterSDK Tests
//
//  Created by Mike Silvis on 3/20/2020.
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


#import <XCTest/XCTest.h>
#import <SquarePointOfSaleSDK/SCAPIURLConversion.h>

@interface SCAPIURLConversionTests : XCTestCase

@end

@implementation SCAPIURLConversionTests

- (void)test_encode_convertingURLIntoRequest;
{
    for (NSArray *urls in [self _urlsToConvert]) {
        NSURL *urlToConvert = [NSURL URLWithString:urls[0]];
        NSURL *expectedURL = [NSURL URLWithString:urls[1]];
        NSURL *encodedURL = [SCAPIURLConversion encode:urlToConvert];

        XCTAssertTrue([encodedURL isEqual:expectedURL]);
    }
}

- (void)test_decode_convertingURLIntoRequest;
{
    for (NSArray *urls in [self _urlsToConvert]) {
        NSURL *urlToConvert = [NSURL URLWithString:urls[1]];
        NSURL *expectedURL = [NSURL URLWithString:urls[0]];
        NSURL *decodedURL = [SCAPIURLConversion decode:urlToConvert];

        XCTAssertTrue([decodedURL isEqual:expectedURL]);
    }
}

- (void)test_encode_decode_convertingURL; {
    for (NSArray *urls in [self _urlsToConvert]) {
        NSURL *urlToConvert = [NSURL URLWithString:urls[0]];
        NSURL *encodedURL = [SCAPIURLConversion encode:urlToConvert];
        NSURL *decodedURL = [SCAPIURLConversion decode:encodedURL];

        XCTAssertTrue([urlToConvert isEqual:decodedURL]);
    }
}

- (void)test_isEncoded; {
    for (NSArray *urls in [self _urlsToConvert]) {
        NSURL *decodedURL = [NSURL URLWithString:urls[0]];
        NSURL *encodedURL = [NSURL URLWithString:urls[1]];

        XCTAssertTrue([SCAPIURLConversion isEncoded:encodedURL]);
        XCTAssertFalse([SCAPIURLConversion isEncoded:decodedURL]);
    }
}

- (NSArray *)_urlsToConvert;
{
    return @[
        @[@"my-app://", @"my-app://square_request"],
        @[@"my-app://?hello=world", @"my-app://square_request?hello=world"],
        @[@"my-app://request", @"my-app://request/square_request"],
        @[@"my-app://request/with/info", @"my-app://request/with/info/square_request"],
        @[@"my-app://request?hello=world", @"my-app://request/square_request?hello=world"]
    ];
}

@end
