//
//  SCCMoneyTests.swift
//  SquareRegisterSDK Tests
//
//  Created by Martin Mroz on 3/3/16.
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


class SCCMoneyTests: XCTestCase {

    // MARK: - Tests

    func test_moneyWithAmountCentsCurrencyCodeError_positiveAmount() {
        do {
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")
            XCTAssertEqual(money.amountCents, 100);
            XCTAssertEqual(money.currencyCode, "USD");
        } catch _ {
            XCTFail()
        }
    }

    func test_moneyWithAmountCentsCurrencyCodeError_zeroAmount() {
        do {
            let money = try SCCMoney(amountCents: 0, currencyCode: "USD")
            XCTAssertEqual(money.amountCents, 0);
            XCTAssertEqual(money.currencyCode, "USD");
        } catch _ {
            XCTFail()
        }
    }

    func test_moneyWithAmountCentsCurrencyCodeError_negativeAmount() {
        do {
            let money = try SCCMoney(amountCents: -100, currencyCode: "USD")
            XCTAssertEqual(money.amountCents, -100);
            XCTAssertEqual(money.currencyCode, "USD");
        } catch _ {
            XCTFail()
        }
    }

    func test_moneyWithAmountCentsDoesNotError_previouslyUnsupportedCurrency() {
        do {
            let money = try SCCMoney(amountCents: 100, currencyCode: "EUR")
            XCTAssertEqual(money.amountCents, 100);
            XCTAssertEqual(money.currencyCode, "EUR");
        } catch _ {
            XCTFail()
        }
    }

    func test_moneyWithAmountCentsCurrencyCodeError_missingCurrency() {
        do {
            _ = try SCCMoney(amountCents: 100, currencyCode: "")
            XCTFail()
        } catch let error as NSError {
            XCTAssertEqual(error.domain, SCCErrorDomain);
            XCTAssertEqual(SCCErrorCode(rawValue: UInt(error.code)), .missingCurrencyCode);
        }
    }

    func test_isEqualToSCCMoney_validatesAmountAndCurrency() {
        do {
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")
            let equivalentMoney = try SCCMoney(amountCents: 100, currencyCode: "USD")
            let moneyWithDifferentCurrency = try SCCMoney(amountCents: 100, currencyCode: "JPY")
            let moneyWithDifferentAmount = try SCCMoney(amountCents: 200, currencyCode: "USD")

            // Test direct invocation of the equality test.
            XCTAssertFalse(money.isEqual(to: nil))
            XCTAssertFalse(money.isEqual(to: moneyWithDifferentCurrency))
            XCTAssertFalse(money.isEqual(to: moneyWithDifferentAmount))
            XCTAssertTrue(money.isEqual(to: equivalentMoney))

            // Equality operator invokes isEqualToSCCMoney via -[NSObject isEqual:].
            XCTAssertFalse(money == moneyWithDifferentCurrency)
            XCTAssertFalse(money == moneyWithDifferentAmount)
            XCTAssertTrue(money == equivalentMoney)
        } catch _ {
            XCTFail()
        }
    }

    func test_copy_returnsEquivalentObject() {
        do {
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")
            let moneyCopy = money.copy() as! SCCMoney
            XCTAssertTrue(money == moneyCopy)
        } catch _ {
            XCTFail()
        }
    }

    func test_requestDictionaryRepresentation_encodesAmountAndCurrency() {
        do {
            let money = try SCCMoney(amountCents: 100, currencyCode: "USD")
            let requestDictionary = money.requestDictionaryRepresentation()
            XCTAssertEqual(requestDictionary[SCCMoneyRequestDictionaryAmountKey] as! Int, 100)
            XCTAssertEqual(requestDictionary[SCCMoneyRequestDictionaryCurrencyCodeKey] as! String, "USD")
        } catch _ {
            XCTFail()
        }
    }

}
