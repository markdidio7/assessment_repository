//
//  FlixTests.swift
//  FlixTests
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import XCTest
@testable import Flix

class FlixTests: XCTestCase {

   //    var showSearchViewController: ShowSearchViewController!
    var show: Show!
    var earlySundayMorning: String!
    var weekends: String!
    var weekdays: String!
    var allDays: String!
    var specificDays: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        show = Show(json: [:])
        earlySundayMorning = show.getReadableSchedule(showSchedule: [
            "time": "00:00" as AnyObject,
            "days": [ "Sunday" ] as AnyObject
        ])
        weekends = show.getReadableSchedule(showSchedule: [
            "time": "23:35" as AnyObject,
            "days": [ "Saturday",
                      "Sunday"] as AnyObject
        ])
        weekdays = show.getReadableSchedule(showSchedule: [
            "time": "23:35" as AnyObject,
            "days": [ "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday" ] as AnyObject
        ])
        allDays = show.getReadableSchedule(showSchedule: [
            "time": "23:35" as AnyObject,
            "days": [ "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                "Saturday",
                "Sunday"] as AnyObject
        ])
        specificDays = show.getReadableSchedule(showSchedule: [
            "time": "23:35" as AnyObject,
            "days": [ "Monday",
                      "Tuesday"] as AnyObject
        ])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWhiteSpaces() {
        XCTAssertFalse(earlySundayMorning.first == " ")
        XCTAssertFalse(weekdays.last == " ")
    }
    
    func testContents() {
        XCTAssertTrue(earlySundayMorning == "Early Sunday Mornings")
        XCTAssertTrue(weekdays == "Weekday Nights")
        XCTAssertTrue(weekends == "Weekend Nights")
        XCTAssertTrue(allDays == "Nights")
        XCTAssertTrue(specificDays == "Monday, Tuesday Nights")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
