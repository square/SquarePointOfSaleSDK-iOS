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

- (void)test_initializerSetsAllProperties;
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
    XCTAssertTrue([request.userInfoString isEqualToString:@"user-info-string"]);
    XCTAssertTrue([request.locationID isEqualToString:@"location-id"]);
    XCTAssertTrue([request.notes isEqualToString:@"notes"]);
    XCTAssertTrue([request.customerID isEqualToString:@"customer-id"]);
    XCTAssertTrue([request.apiVersion isEqualToString:@"1.3"]);
    XCTAssertTrue([request.sdkVersion isEqualToString:@"3.4.1"]);
    XCTAssertEqual(request.supportedTenderTypes, SCCAPIRequestTenderTypeCard);
    XCTAssertEqual(request.clearsDefaultFees, YES);
    XCTAssertEqual(request.returnsAutomaticallyAfterPayment, YES);
    XCTAssertEqual(request.disablesKeyedInCardEntry, YES);
    XCTAssertEqual(request.skipsReceipt, YES);
}

@end
