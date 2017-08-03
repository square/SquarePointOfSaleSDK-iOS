//
//  SCCAPIRequestTests.swift
//  SquareRegisterSDK Tests
//
//  Created by Martin Mroz on 3/7/16.
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

import Foundation
import SquarePointOfSaleSDK
import XCTest


class SCCAPIRequestTests: SCCTestCase {

    // MARK: - Class Methods

    static let defaultTestClientID = "8M4Qn6MyR4BZDeS0c41L3g"

    // MARK: - Set Up

    override func setUp() {
        super.setUp()

        SCCAPIRequest.setClientID(SCCAPIRequestTests.defaultTestClientID)
    }

    override func tearDown() {
        SCCAPIRequest.setClientID(nil)

        super.tearDown()
    }

    // MARK: - Tests

    func test_requestWithCallbackURL_propagatesAllParametersWhenValid() {
        do {
            let notes = "Notes"
            let locationID = "7074ME2C077ZB"
            let customerID = "YT6ZX064G97X12NVED31CJJK34"
            let userInfoString = "User Info"
            let amount = try! SCCMoney(amountCents: 100, currencyCode: "USD")
            let callbackURL = URL(string: "register-sdk-testapp://myCallback")!
            let supportedTenderTypes = SCCAPIRequestTenderTypes.card
            let clearsDefaultFees = true
            let autoreturn = true

            let completeRequest = try SCCAPIRequest(
                callbackURL: callbackURL,
                amount: amount,
                userInfoString: userInfoString,
                locationID: locationID,
                notes: notes,
                customerID: customerID,
                supportedTenderTypes: supportedTenderTypes,
                clearsDefaultFees: clearsDefaultFees,
                returnAutomaticallyAfterPayment: autoreturn)

            XCTAssertEqual(completeRequest.clientID, SCCAPIRequestTests.defaultTestClientID)
            XCTAssertEqual(completeRequest.notes, notes)
            XCTAssertEqual(completeRequest.locationID, locationID)
            XCTAssertEqual(completeRequest.customerID, customerID)
            XCTAssertEqual(completeRequest.userInfoString, userInfoString)
            XCTAssertEqual(completeRequest.amount, amount)
            XCTAssertEqual(completeRequest.callbackURL, callbackURL)
            XCTAssertEqual(completeRequest.supportedTenderTypes, supportedTenderTypes)
            XCTAssertEqual(completeRequest.clearsDefaultFees, clearsDefaultFees)
            XCTAssertEqual(completeRequest.returnsAutomaticallyAfterPayment, autoreturn)
        } catch _ {
            XCTFail()
        }
    }

    func test_requestWithCallbackURL_validatesPresenceOfClientID() {
        do {
            SCCAPIRequest.setClientID(nil)
            _ = try SCCAPIRequest(
                callbackURL: URL(string: "register-sdk-testapp://myCallback")!,
                amount: try! SCCMoney(amountCents: 100, currencyCode: "USD"),
                userInfoString: nil,
                locationID: nil,
                notes: nil,
                customerID: nil,
                supportedTenderTypes: SCCAPIRequestTenderTypes.all,
                clearsDefaultFees: false,
                returnAutomaticallyAfterPayment: false)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingRequestClientID);
        }
    }

    func test_requestWithCallbackURL_validatesCallbackURL() {
        do {
            _ = try SCCAPIRequest(
                callbackURL: URL(string: "//myCallback")!,
                amount: try! SCCMoney(amountCents: 100, currencyCode: "USD"),
                userInfoString: nil,
                locationID: nil,
                notes: nil,
                customerID: nil,
                supportedTenderTypes: SCCAPIRequestTenderTypes.all,
                clearsDefaultFees: false,
                returnAutomaticallyAfterPayment: false)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .invalidRequestCallbackURL);
        }
    }

    func test_requestWithCallbackURL_validatesAmount() {
        do {
            _ = try SCCAPIRequest(
                callbackURL: URL(string: "register-sdk-testapp://myCallback")!,
                amount: try! SCCMoney(amountCents: -100, currencyCode: "USD"),
                userInfoString: nil,
                locationID: nil,
                notes: nil,
                customerID: nil,
                supportedTenderTypes: SCCAPIRequestTenderTypes.all,
                clearsDefaultFees: false,
                returnAutomaticallyAfterPayment: false)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .invalidRequestAmount);
        }
    }

    func test_APIRequestURLWithError_generatesURLBasedOnSpecifiedProperties() {
        do {
            let request = try SCCAPIRequest(
                callbackURL: URL(string: "my-app://perform-callback")!,
                amount: try! SCCMoney(amountCents: 100, currencyCode: "USD"),
                userInfoString: "state-user-info",
                locationID: "abc123",
                notes: "blue shoes",
                customerID: "def456",
                supportedTenderTypes: SCCAPIRequestTenderTypes.card,
                clearsDefaultFees: false,
                returnAutomaticallyAfterPayment: true)
            let requestURL = try request.apiRequestURL()

            let expectedData: [String : Any] = [
                "client_id" : SCCAPIRequestTests.defaultTestClientID,
                "sdk_version" : "3.1",
                "version" : "1.3",
                "amount_money" : [
                    "amount" : 100,
                    "currency_code" : "USD"
                ],
                "callback_url" : "my-app://perform-callback",
                "state" : "state-user-info",
                "location_id" : "abc123",
                "customer_id": "def456",
                "notes" : "blue shoes",
                "options" : [
                    "supported_tender_types" : [ "CREDIT_CARD" ],
                    "clear_default_fees" : false,
                    "auto_return" : true
                ]
            ]

            XCTAssertEqual(NSDictionary(dictionary: expectedData), NSDictionary(dictionary: self.data(for: requestURL)));
        } catch _ {
            XCTFail()
        }
    }

    func test_isEqualToAPIRequest_comparesAllFields() {
        let notes = "Notes"
        let locationID = "7074ME2C077ZB"
        let customerID = "YT6ZX064G97X12NVED31CJJK34"
        let userInfoString = "User Info"
        let amount = try! SCCMoney(amountCents: 100, currencyCode: "USD")
        let callbackURL = URL(string: "register-sdk-testapp://myCallback")!
        let supportedTenderTypes = SCCAPIRequestTenderTypes.card
        let clearsDefaultFees = true
        let autoreturn = true

        let baseRequest = try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn)

        // Logically equivalent requests.
        XCTAssertEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different client ID.
        SCCAPIRequest.setClientID("DIFFERENT_ID")
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))
        SCCAPIRequest.setClientID(SCCAPIRequestTests.defaultTestClientID)

        // Different callback URL.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: URL(string: "http://google.com")!,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different amount.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: try! SCCMoney(amountCents: 200, currencyCode: "USD"),
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different user info string.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: "DIFFERENT_USER_INFO_STRING",
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different location ID.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: "DIFFERENT_LOCATION_ID",
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different notes.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: "DIFFERENT_NOTES",
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different customer ID.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: "DIFFERENT_CUSTOMER_ID",
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different clears default fees.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: !clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn))

        // Different autoreturn values.
        XCTAssertNotEqual(baseRequest, try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: locationID,
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: !autoreturn))
    }

    func test_backwardsCompatibility_deprecatedMerchantID() {
        let notes = "Notes"
        let customerID = "YT6ZX064G97X12NVED31CJJK34"
        let userInfoString = "User Info"
        let amount = try! SCCMoney(amountCents: 100, currencyCode: "USD")
        let callbackURL = URL(string: "register-sdk-testapp://myCallback")!
        let supportedTenderTypes = SCCAPIRequestTenderTypes.card
        let clearsDefaultFees = true
        let autoreturn = true
        
        let deprecatedRequest = try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            merchantID: "abc123",
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn)
        
        // read back specified merchantID
        XCTAssertEqual(deprecatedRequest.locationID, "abc123")
        XCTAssertEqual(deprecatedRequest.merchantID, "abc123")
        
        let anotherEqualRequest = try! SCCAPIRequest(
            callbackURL: callbackURL,
            amount: amount,
            userInfoString: userInfoString,
            locationID: "abc123",
            notes: notes,
            customerID: customerID,
            supportedTenderTypes: supportedTenderTypes,
            clearsDefaultFees: clearsDefaultFees,
            returnAutomaticallyAfterPayment: autoreturn)
        XCTAssertEqual(deprecatedRequest, anotherEqualRequest)
        
        do {
            // make sure it gets serialized correctly with location_id label
            let requestURL = try deprecatedRequest.apiRequestURL()
            
            let expectedData: [String : Any] = [
                "client_id" : SCCAPIRequestTests.defaultTestClientID,
                "sdk_version" : "3.1",
                "version" : "1.3",
                "amount_money" : [
                    "amount" : 100,
                    "currency_code" : "USD"
                ],
                "callback_url" : "register-sdk-testapp://myCallback",
                "state" : userInfoString,
                "location_id" : "abc123",
                "customer_id": customerID,
                "notes" : notes,
                "options" : [
                    "supported_tender_types" : [ "CREDIT_CARD" ],
                    "clear_default_fees" : clearsDefaultFees,
                    "auto_return" : autoreturn
                ]
            ]
            
            XCTAssertEqual(NSDictionary(dictionary: expectedData), NSDictionary(dictionary: self.data(for: requestURL)));
        } catch _ {
            XCTFail()
        }

        
    }
    
    func test_NSArrayOfTenderTypeStringsFromSCCAPIRequestTenderTypes_supportsAllTenderTypes() {
        let noTenderTypes = SCCAPIRequestTenderTypes()
        let noTenderStrings = NSArrayOfTenderTypeStringsFromSCCAPIRequestTenderTypes(noTenderTypes)
        XCTAssertEqual(noTenderStrings, [ String ]())

        let creditOnlyStrings = NSArrayOfTenderTypeStringsFromSCCAPIRequestTenderTypes(.card)
        XCTAssertEqual(creditOnlyStrings, [ SCCAPIRequestOptionsTenderTypeStringCard ])

        let allStrings = NSArrayOfTenderTypeStringsFromSCCAPIRequestTenderTypes(.all)
        XCTAssertEqual(allStrings, [
            SCCAPIRequestOptionsTenderTypeStringCard,
            SCCAPIRequestOptionsTenderTypeStringCash,
            SCCAPIRequestOptionsTenderTypeStringOther,
            SCCAPIRequestOptionsTenderTypeStringSquareGiftCard,
            SCCAPIRequestOptionsTenderTypeStringCardOnFile,
        ])
    }
}
