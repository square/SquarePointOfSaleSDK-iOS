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
    XCTAssertEqual(request.userInfoString, @"user-info-string");
    XCTAssertEqual(request.locationID, @"location-id");
    XCTAssertEqual(request.notes, @"notes");
    XCTAssertEqual(request.customerID, @"customer-id");
    XCTAssertEqual(request.apiVersion, @"1.3");
    XCTAssertEqual(request.sdkVersion, @"3.4.1");
    XCTAssertEqual(request.supportedTenderTypes, SCCAPIRequestTenderTypeCard);
    XCTAssertEqual(request.clearsDefaultFees, YES);
    XCTAssertEqual(request.returnsAutomaticallyAfterPayment, YES);
    XCTAssertEqual(request.disablesKeyedInCardEntry, YES);
    XCTAssertEqual(request.skipsReceipt, YES);

    NSURL *apiRequest = [request APIRequestURLWithError:NULL];

    XCTAssertTrue([apiRequest.absoluteString isEqualToString:@"square-commerce-v1://payment/create?data=%7B%22state%22%3A%22user-info-string%22%2C%22options%22%3A%7B%22auto_return%22%3Atrue%2C%22skip_receipt%22%3Atrue%2C%22clear_default_fees%22%3Atrue%2C%22disable_cnp%22%3Atrue%2C%22supported_tender_types%22%3A%5B%22CREDIT_CARD%22%5D%7D%2C%22notes%22%3A%22notes%22%2C%22callback_url%22%3A%22my-app%3A%5C%2F%5C%2Fperform-callback%5C%2Fsquare_request%22%2C%22location_id%22%3A%22location-id%22%2C%22version%22%3A%221.3%22%2C%22amount_money%22%3A%7B%22amount%22%3A100%2C%22currency_code%22%3A%22USD%22%7D%2C%22customer_id%22%3A%22customer-id%22%2C%22client_id%22%3A%22my-app-client-id%22%2C%22sdk_version%22%3A%223.4.1%22%7D"]);
}

@end
