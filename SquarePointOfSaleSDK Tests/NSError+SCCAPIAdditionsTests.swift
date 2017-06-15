//
//  NSError+SCCAPIAdditionsTests.swift
//  SquareRegisterSDK Tests
//
//  Created by Joseph Hankin on 9/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import SquarePointOfSaleSDK
import XCTest

class NSError_SCCAPIAdditionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_SCC_APIErrorWithErrorCodeString_knownError()
    {
        // Should return an appropriate error for a known error code string.
        let errorCodeString = "not_logged_in"

        let error = NSError.scc_APIErrorWithErrorCodeString(errorCodeString) as NSError
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.appNotLoggedIn.rawValue)
        XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, errorCodeString)
        XCTAssertNotNil(error.userInfo[NSLocalizedDescriptionKey]);
    }
    
    func test_SCC_APIErrorWithErrorCodeString_locationIDError_backwardsCompatibility()
    {
        // Should return an appropriate error for a known error code string.
        let errorCodeString = "location_id_mismatch"
        
        let error = NSError.scc_APIErrorWithErrorCodeString(errorCodeString) as NSError
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.locationIDMismatch.rawValue)
        //checking against deprecated value should work too for backwards compat
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.merchantIDMismatch.rawValue)
        XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, errorCodeString)
        XCTAssertNotNil(error.userInfo[NSLocalizedDescriptionKey]);
    }
    
    func test_SCC_APIErrorWithErrorCodeString_unknownError()
    {
        // For an unknown error string, should return an error with no code and the error string persisted.
        let errorCodeString = "hypothetical_future_error"

        let error = NSError.scc_APIErrorWithErrorCodeString(errorCodeString) as NSError
        XCTAssertEqual(UInt(error.code), SCCAPIErrorCode.unknown.rawValue)
        XCTAssertEqual(error.userInfo[SCCAPIErrorUserInfoCodeStringKey] as? String, errorCodeString)
        XCTAssertNil(error.userInfo[NSLocalizedDescriptionKey])
    }
}
