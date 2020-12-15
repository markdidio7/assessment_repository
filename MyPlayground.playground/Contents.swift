import Cocoa

var str = "Hello, playground"

let calendar = Calendar.current
let date = calendar.date(byAdding: .day, value: 366, to: Date())


Double(calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: date!).day!)

Double(calendar.dateComponents([.weekOfYear], from: calendar.startOfDay(for: Date()), to: date!).weekOfYear!)

Double(calendar.dateComponents([.month], from: calendar.startOfDay(for: Date()), to: date!).month!)

Double(calendar.dateComponents([.year], from: calendar.startOfDay(for: Date()), to: date!).year!)



