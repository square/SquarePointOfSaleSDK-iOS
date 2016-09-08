//
//  NSError+SCCAPIAdditionsTests.swift
//  SquareRegisterSDK Tests
//
//  Created by Joseph Hankin on 9/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import XCTest

class NSError_SCCAPIAdditionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_SCC_APIErrorWithErrorCodeString_knownError()
    {
        // Should return an appropriate error for a known error code string.
        let errorCodeString = "not_logged_in"

        let error = NSError.SCC_APIErrorWithErrorCodeString(errorCodeString)
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.AppNotLoggedIn.rawValue)
        XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, errorCodeString)
    }
    
    func test_SCC_APIErrorWithErrorCodeString_unknownError()
    {
        // For an unknown error string, should return an error with no code and the error string persisted.
        let errorCodeString = "hypothetical_future_error"

        let error = NSError.SCC_APIErrorWithErrorCodeString(errorCodeString)
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.Unknown.rawValue)
        XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, errorCodeString)
    }
}
