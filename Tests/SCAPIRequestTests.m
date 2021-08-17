//
//  XCTestCase+SCAPIRequestTests.m
//  SquarePointOfSaleSDK-Unit-Tests
//
//  Created by Mike Silvis on 10/14/20.
//

@import SquarePointOfSaleSDK;

#import <XCTest/XCTest.h>

@interface SCAPIRequestTests : XCTestCase
@end

@implementation SCAPIRequestTests

- (void)test_initializerSetsAllProperties
{

    NSURL *const callbackURL = [NSURL URLWithString:@"my-app://perform-callback"];
    SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

    XCTAssertNotNil(callbackURL);
    XCTAssertNotNil(amount);

    [SCCAPIRequest setApplicationID:@"my-app-client-id"];

    SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                  amount:amount
                                                          userInfoString:@"user-info-string"
                                                              locationID:@"location-id"
                                                                   notes:@"notes"
                                                              customerID:@"customer-id"
                                                    supportedTenderTypes:SCCAPIRequestTenderTypeCard
                                                       clearsDefaultFees:YES
                                        returnsAutomaticallyAfterPayment:YES
                                                disablesKeyedInCardEntry:YES
                                                            skipsReceipt:YES
                                                                   error:NULL];

    XCTAssertEqual(request.amount, amount);
    XCTAssertEqual(request.userInfoString, @"user-info-string");
    XCTAssertEqual(request.locationID, @"location-id");
    XCTAssertEqual(request.notes, @"notes");
    XCTAssertEqual(request.customerID, @"customer-id");
    XCTAssertEqual(request.apiVersion, SCCAPIVersion);
    XCTAssertEqual(request.sdkVersion, SCCSDKVersion);
    XCTAssertEqual(request.supportedTenderTypes, SCCAPIRequestTenderTypeCard);
    XCTAssertEqual(request.clearsDefaultFees, YES);
    XCTAssertEqual(request.returnsAutomaticallyAfterPayment, YES);
    XCTAssertEqual(request.disablesKeyedInCardEntry, YES);
    XCTAssertEqual(request.skipsReceipt, YES);
}

- (void)test_setAPIVersion
{
    NSURL *const callbackURL = [NSURL URLWithString:@"my-app://perform-callback"];
    SCCMoney *const amount = [SCCMoney moneyWithAmountCents:100 currencyCode:@"USD" error:NULL];

    XCTAssertNotNil(callbackURL);
    XCTAssertNotNil(amount);

    [SCCAPIRequest setApplicationID:@"my-app-client-id"];

    SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                  amount:amount
                                                          userInfoString:@"user-info-string"
                                                              locationID:@"location-id"
                                                                   notes:@"notes"
                                                              customerID:@"customer-id"
                                                    supportedTenderTypes:SCCAPIRequestTenderTypeCard
                                                       clearsDefaultFees:YES
                                        returnsAutomaticallyAfterPayment:YES
                                                disablesKeyedInCardEntry:YES
                                                            skipsReceipt:YES
                                                                   error:NULL];

    XCTAssertEqual(request.apiVersion, SCCAPIVersion);

    [request setApiVersion:@"1.0.9"];

    XCTAssertEqual(request.apiVersion, @"1.0.9");
}

@end
