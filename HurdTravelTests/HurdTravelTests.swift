//
//  HurdTravelTests.swift
//  HurdTravelTests
//
//  Created by clydies freeman on 5/6/23.
//

import XCTest
@testable import HurdTravel


final class HurdTravelTests: XCTestCase {
    
   

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PhoneFormatter_With_Correct_Number() {
        let phoneFormatter = PhoneNumberFormatter()
        let mockNumber = 6172331242
        let expectedValue = "(617) 233-1242"
        
        let formattedMockNumber = phoneFormatter.string(forObjectValue: mockNumber)
        
        XCTAssert(formattedMockNumber == expectedValue)
    }
    
    func test_Days_Between_Dates() {
      let start_date = Date(timeIntervalSince1970: 1657228800.0)
      let end_date = Date(timeIntervalSince1970: 1657232400.0)
      let expectedDays = 3
      let actualDays = daysBetweenDates(start: start_date, end: end_date)
      XCTAssertEqual(actualDays, expectedDays)
    }
    
    func test_Countdown_Timer() {
      let start_date = Date(timeIntervalSince1970: 1657228800.0)
      let end_date = Date(timeIntervalSince1970: 1657232400.0)
      let expectedCountdown = [
        "days": 3,
        "hours": 0,
        "minutes": 4,
        "seconds": 0,
      ]
      let actualCountdown = countdownTimer(start: start_date, end: end_date)
      XCTAssertEqual(actualCountdown, expectedCountdown)
    }

}
