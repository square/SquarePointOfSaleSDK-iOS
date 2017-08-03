//
//  SCCAPIConnectionTests.m
//  SquareRegisterSDK Tests
//
//  Created by Martin Mroz on 3/8/2016.
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

@import SquarePointOfSaleSDK;

#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>
#import "SCCAPIConnection_Testing.h"

@interface SCCAPIConnectionTests : XCTestCase
@end


@implementation SCCAPIConnectionTests

#pragma mark - Tests

- (void)test_canPerformRequestError_isYESWhenApplicationCanOpenURL;
{
    NSURL *const callbackURL = [NSURL URLWithString:@"my-app://perform-callback"];
    SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

    XCTAssertNotNil(callbackURL);
    XCTAssertNotNil(amount);

    [SCCAPIRequest setClientID:@"my-app-client-id"];
    SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                  amount:amount
                                                          userInfoString:nil
                                                              locationID:nil
                                                                   notes:nil
                                                              customerID:nil
                                                    supportedTenderTypes:SCCAPIRequestTenderTypeCard
                                                       clearsDefaultFees:NO
                                         returnAutomaticallyAfterPayment:NO
                                                                   error:NULL];

    id const bundleMock = OCMPartialMock([NSBundle mainBundle]);
    NSArray *validURLSchemes = @[@"square-commerce-v1"];
    OCMStub([bundleMock objectForInfoDictionaryKey:[OCMArg isNotNil]]).andReturn(validURLSchemes);

    id const appMock = OCMClassMock([UIApplication class]);
    OCMStub([appMock canOpenURL:[OCMArg isNotNil]]).andReturn(YES);

    NSError *error = nil;
    BOOL const canPerformRequest = [SCCAPIConnection _canPerformRequest:request error:&error application:appMock];
    XCTAssertTrue(canPerformRequest);
    XCTAssertNil(error);
}

- (void)test_canPerformRequestError_isNOWhenApplicationCannotOpenURL;
{
    NSURL *const callbackURL = [NSURL URLWithString:@"my-app://perform-callback"];
    SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

    XCTAssertNotNil(callbackURL);
    XCTAssertNotNil(amount);

    [SCCAPIRequest setClientID:@"my-app-client-id"];
    SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                  amount:amount
                                                          userInfoString:nil
                                                              locationID:nil
                                                                   notes:nil
                                                              customerID:nil
                                                    supportedTenderTypes:SCCAPIRequestTenderTypeCard
                                                       clearsDefaultFees:NO
                                         returnAutomaticallyAfterPayment:NO
                                                                   error:NULL];

    id const bundleMock = OCMPartialMock([NSBundle mainBundle]);
    NSArray *validURLSchemes = @[];
    OCMStub([bundleMock objectForInfoDictionaryKey:[OCMArg isNotNil]]).andReturn(validURLSchemes);

    NSError *error = nil;
    BOOL const canPerformRequest = [SCCAPIConnection canPerformRequest:request error:&error];
    XCTAssertFalse(canPerformRequest);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, SCCErrorDomain);
    XCTAssertEqual(error.code, SCCErrorCodeCannotOpenApplication);
}

@end
