//
//  Day.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation

enum Day: String {
    case sunday = "sunday"
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
}

class Days {
    
    static var get: Days = Days()
    
    var weekdays: [Day] = [.monday, .tuesday, .wednesday, .thursday, .friday]
    var weekend: [Day] = [.saturday, .sunday]
    var sevenDays: [Day] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    func isSevenDays(daysString: [String]) -> Bool {
        let foundList = sevenDays.filter { (elements) -> Bool in
            return daysString.map { $0.lowercased() }.contains(elements.rawValue)
        }
        print(daysString, foundList)
        return foundList.count == sevenDays.count
    }
    
    func isWeekdays(daysString: [String]) -> Bool {
        let foundList = weekdays.filter { (elements) -> Bool in
            return daysString.map { $0.lowercased() }.contains(elements.rawValue)
        }
        print(daysString, foundList)
        return foundList.count == weekdays.count
    }
    
    func isWeekend(daysString: [String]) -> Bool {
        let foundList = weekend.filter { (elements) -> Bool in
            return daysString.map { $0.lowercased() }.contains(elements.rawValue)
        }
        print(daysString, foundList)
        return foundList.count == weekend.count
    }
    
}

