//
//  Show.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation

struct Show {
    var name: String!
    var imageKey: String?
    var schedule: String!
    var premiered: String?
    var genres: String!
    var summary: String!
    var averageRating: Double?
    
    private init() { }
    
    init(name: String!, imageKey: String?, premiered: String?, schedule: String!, genres: String!, summary: String!, averageRating: Double?) {
        self.name = name
        self.imageKey = imageKey
        self.premiered = premiered
        self.schedule = schedule
        self.genres = genres
        self.summary = summary
        self.averageRating = averageRating
    }
    
    init(json: [String: AnyObject]) {
        self.init()
        let name = json["name"] as? String
        let imageKey = (json["image"] as? [String: AnyObject] ?? [:])["original"] as? String
        let premiered = getYear(premieredString: json["premiered"] as? String)
        let schedule = getReadableSchedule(showSchedule: json["schedule"] as! [String : AnyObject])
        let genres = getGenreString(genres: json["genres"] as! [String])
        let summary = (json["summary"] as? String)?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let averageRating = (json["rating"] as? [String:AnyObject] ?? [:])["average"] as? Double
        self.init(name: name, imageKey: imageKey, premiered: premiered, schedule: schedule, genres: genres, summary: summary, averageRating: averageRating)
    }
    
    
    func getYear(premieredString: String?) -> String? {
        if premieredString != nil {
            return String(premieredString![..<premieredString!.index(premieredString!.startIndex, offsetBy: 4)])
        } else {
            return nil
        }
    }
    
    func getReadableSchedule(showSchedule: [String: AnyObject]) -> String {
        let time = showSchedule["time"] as! String
        let days = showSchedule["days"] as! [String]
        
        var prefix = ""
        var dayDescriptor = ""
        var timeDescriptor = ""
        
        if !time.isEmpty {
            if let hour = Int(time[..<time.index(time.startIndex, offsetBy: 2)]) {
                prefix = hour < 6 ? "Early" : prefix
                if hour < 12 {
                    timeDescriptor = "Mornings"
                } else if hour < 18 {
                    timeDescriptor = "Afternoons"
                } else {
                    timeDescriptor = "Nights"
                }
            }
        }
        
        if Days.get.isSevenDays(daysString: days) {
            dayDescriptor = ""
        } else if Days.get.isWeekdays(daysString: days) {
            dayDescriptor = "Weekday"
        } else if Days.get.isWeekend(daysString: days) {
            dayDescriptor = "Weekend"
        } else {
            for (i, day) in days.enumerated() {
                dayDescriptor.append(String(format: "%@%@", day.capitalized, i < (days.count - 1) ? ", " : ""))
            }
        }
        
        return String(format: "%@ %@ %@", prefix, dayDescriptor, timeDescriptor).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getGenreString(genres: [String]) -> String {
        var genresString = ""
        for (i, genre) in genres.enumerated() {
            genresString.append(String(format: "%@%@", genre.capitalized, i < (genres.count - 1) ? ", " : ""))
        }
        return genresString
    }
}
