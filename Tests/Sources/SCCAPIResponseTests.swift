//
//  SCCAPIResponseTests.swift
//  SquareRegisterSDK Tests
//
//  Created by Martin Mroz on 3/14/16.
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


class SCCAPIResponseTests: SCCTestCase {

    // MARK: - Tests - Valid Responses

    func test_responseWithResponseURLError_parsesSuccessfulPaymentResponse() {
        let responseDictionary: [AnyHashable: Any] = [
            "payment_id" : "PAYMENT_ID",
            "offline_payment_id" : "OFFLINE_PAYMENT_ID",
            "transaction_id" : "TRANSACTION_ID",
            "status" : "ok",
            "error_code" : "0",
            "state" : "PASS_ME_BACK"
        ]

        let responseData = self.queryString(forData: responseDictionary)
        let callbackURL = URL(string: "my-app://callback?data=\(responseData)")!

        do {
            let response = try SCCAPIResponse(responseURL: callbackURL)
            XCTAssertNil(response.error)
            XCTAssertEqual(response.userInfoString, "PASS_ME_BACK")
            XCTAssertEqual(response.transactionID, "TRANSACTION_ID")
            XCTAssertTrue(response.isSuccessResponse)
        } catch _ {
            XCTFail()
        }
    }

    func test_responseWithResponseURLError_parsesResponseWithUnknownError() {
        let responseDictionary: [AnyHashable: Any] = [
            "status" : "error",
            "error_code" : "UNKNOWN_ERROR_INVALID_CODE",
            "state" : "PASS_ME_BACK"
        ]

        let responseData = self.queryString(forData: responseDictionary)
        let callbackURL = URL(string: "my-app://callback?data=\(responseData)")!

        do {
            let response = try SCCAPIResponse(responseURL: callbackURL)
            if let error = response.error as NSError? {
                XCTAssertNotNil(error)
                XCTAssertEqual(error.domain, SCCAPIErrorDomain)
                XCTAssertEqual(SCCAPIErrorCode(rawValue: UInt(error.code)), .unknown)
                XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, "UNKNOWN_ERROR_INVALID_CODE")
                XCTAssertEqual(response.userInfoString, "PASS_ME_BACK")
                XCTAssertNil(response.transactionID)
                XCTAssertFalse(response.isSuccessResponse)
            } else {
                XCTFail()
            }
        } catch _ {
            XCTFail()
        }
    }

    func test_responseWithResponseURLError_parsesResponseWithUserNotActivatedError() {
        let responseDictionary: [AnyHashable: Any] = [
            "status" : "error",
            "error_code" : "user_not_active",
            "state" : "PASS_ME_BACK"
        ]

        let responseData = self.queryString(forData: responseDictionary)
        let callbackURL = URL(string: "my-app://callback?data=\(responseData)")!

        do {
            let response = try SCCAPIResponse(responseURL: callbackURL)
            if let error = response.error as NSError? {
                XCTAssertNotNil(error)
                XCTAssertEqual(error.domain, SCCAPIErrorDomain)
                XCTAssertEqual(SCCAPIErrorCode(rawValue: UInt(error.code)), .userNotActivated)
                XCTAssertEqual(response.userInfoString, "PASS_ME_BACK")
                XCTAssertNil(response.transactionID)
                XCTAssertFalse(response.isSuccessResponse)
            } else {
                XCTFail()
            }
        } catch _ {
            XCTFail()
        }
    }

    // MARK: - Tests - Invalid Responses

    func test_responseWithResponseURLError_handlesMissingOrInvalidDataParameter() {
        do {
            let callbackURL = URL(string: "my-app://callback?foo=bar")!
            _ = try SCCAPIResponse(responseURL: callbackURL)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingOrInvalidResponseData)
        }
    }

    func test_responseWithResponseURLError_handlesMissingOrInvalidJSONInDataParameter() {
        do {
            let callbackURL = URL(string: "my-app://callback?data=%5B%5D")!
            _ = try SCCAPIResponse(responseURL: callbackURL)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingOrInvalidResponseJSONData)
        }
    }

    func test_responseWithResponseURLError_handlesMissingOrInvalidStatus() {
        do {
            let responseDictionary: [AnyHashable: Any] = [ "status" : "INVALID_STATUS" ]
            let responseData = self.queryString(forData: responseDictionary)
            let callbackURL = URL(string: "my-app://callback?data=\(responseData)")!
            _ = try SCCAPIResponse(responseURL: callbackURL)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingOrInvalidResponseStatus)
        }
    }

    func test_responseWithResponseURLError_handlesMissingOrInvalidErrorCode() {
        do {
            let responseDictionary: [AnyHashable: Any] = [
                "status" : "error",
                "state" : "PASS_ME_BACK"
            ]

            let responseData = self.queryString(forData: responseDictionary)
            let callbackURL = URL(string: "my-app://callback?data=\(responseData)")!

            _ = try SCCAPIResponse(responseURL: callbackURL)
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain)
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingOrInvalidResponseErrorCode)
        }
    }

}
