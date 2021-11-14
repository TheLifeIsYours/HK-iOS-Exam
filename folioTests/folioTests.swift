//
//  folioTests.swift
//  folioTests
//
//  Created by Mats Daniel Larsen on 29/10/2021.
//

import XCTest
@testable import folio

class folioTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBirthdayWeek() throws {
        let api = PeopleAPI()
        
        if let people = api.data?.results {
            var birthday = people[0].dateOfBirth?.date
            
            XCTAssertFalse(birthday!.isInThisWeek)
            
            birthday = .now
            
            XCTAssertTrue(birthday!.isInThisWeek)
        }
    }

    func testPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
