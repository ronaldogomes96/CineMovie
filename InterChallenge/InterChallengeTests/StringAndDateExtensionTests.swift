//
//  StringAndDateExtensionTests.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import XCTest
@testable import InterChallenge

class StringAndDateExtensionTests: XCTestCase {
    func test_stringConvertToDate_invalidStrign_shouldBeNil() {
        // When
        let convertToDate = "Not a date".convertToDate()
        
        // Then
        XCTAssertNil(convertToDate)
    }
    
    func test_dateConvertToString_valueDate_notNil() {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        // When
        let convertToString = formatter.date(from: "20/08/2021")!.convertToString()
        
        // Then
        XCTAssertNotNil(convertToString)
    }
}
