//
//  Created by Honghao Zhang on 10/16/2015.
//  Copyright © 2018 ChouTi. All rights reserved.
//

import Foundation

public extension Date {

    /// Get random int from a range of Int.
    private static func randomInt(from range: Range<Int>) -> Int {
        if range.lowerBound == range.upperBound {
            return range.lowerBound
        }
        return Int.random(in: range.lowerBound..<range.upperBound)
    }

    /// Returns a random date within the specified date range.
    static func randomDate(in range: Range<Date>) -> Date? {
        guard range.lowerBound < range.upperBound else {
            return nil
        }

        return Date(year: randomInt(from: range.lowerBound.year..<range.upperBound.year),
                    month: randomInt(from: range.lowerBound.month..<range.upperBound.month),
                    day: randomInt(from: range.lowerBound.day..<range.upperBound.day),
                    hour: randomInt(from: range.lowerBound.hour..<range.upperBound.hour),
                    minute: randomInt(from: range.lowerBound.minute..<range.upperBound.minute),
                    second: randomInt(from: range.lowerBound.second..<range.upperBound.second),
                    nanosecond: randomInt(from: range.lowerBound.nanosecond..<range.upperBound.nanosecond),
                    timeZone: TimeZone.autoupdatingCurrent,
                    calendar: Calendar.autoupdatingCurrent)
    }

    /// Returns a random date within the specified date range.
    static func randomDate(in range: ClosedRange<Date>) -> Date? {
        return Date(year: Int.random(in: range.lowerBound.year...range.upperBound.year),
                    month: Int.random(in: range.lowerBound.month...range.upperBound.month),
                    day: Int.random(in: range.lowerBound.day...range.upperBound.day),
                    hour: Int.random(in: range.lowerBound.hour...range.upperBound.hour),
                    minute: Int.random(in: range.lowerBound.minute...range.upperBound.minute),
                    second: Int.random(in: range.lowerBound.second...range.upperBound.second),
                    nanosecond: Int.random(in: range.lowerBound.nanosecond...range.upperBound.nanosecond),
                    timeZone: TimeZone.autoupdatingCurrent,
                    calendar: Calendar.autoupdatingCurrent)
    }

    /// Get a random date which is after 00:00:00 UTC on 1 January 1970.
    static func randomDateSince1970() -> Date {
        return Date(timeIntervalSince1970: TimeInterval.random(in: 0..<TimeInterval(Int.max)))
    }
}

public extension Date {

    /// Era in current timezone & calendar.
    var era: Int { return era() }

    /// Year in current timezone & calendar.
    var year: Int { return year() }

    /// Month in current timezone & calendar.
    var month: Int { return month() }

    /// Day in current timezone & calendar.
    var day: Int { return day() }

    /// Hour in current timezone & calendar.
    var hour: Int { return hour() }

    /// Minute in current timezone & calendar.
    var minute: Int { return minute() }

    /// Second in current timezone & calendar.
    var second: Int { return second() }

    /// Weekday in current timezone & calendar.
    var weekday: Int { return weekday() }

    /// WeekdayOrdinal in current timezone & calendar.
    var weekdayOrdinal: Int { return weekdayOrdinal() }

    /// Quarter in current timezone & calendar.
    var quarter: Int { return quarter() }

    /// WeekOfMonth in current timezone & calendar.
    var weekOfMonth: Int { return weekOfMonth() }

    /// WeekOfYear in current timezone & calendar.
    var weekOfYear: Int { return weekOfYear() }

    /// YearForWeekOfYear in current timezone & calendar.
    var yearForWeekOfYear: Int { return yearForWeekOfYear() }

    /// Nanosecond in current timezone & calendar.
    var nanosecond: Int { return nanosecond() }

    /// Era in specified timezone & calendar.
    func era(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.era, from: self)
    }

    /// Year in specified timezone & calendar.
    func year(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.year, from: self)
    }

    /// Month in specified timezone & calendar.
    func month(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.month, from: self)
    }

    /// Day in specified timezone & calendar.
    func day(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.day, from: self)
    }

    /// Hour in specified timezone & calendar.
    func hour(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.hour, from: self)
    }

    /// Minute in specified timezone & calendar.
    func minute(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.minute, from: self)
    }

    /// Second in specified timezone & calendar.
    func second(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.second, from: self)
    }

    /// Weekday in specified timezone & calendar.
    func weekday(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.weekday, from: self)
    }

    /// WeekdayOrdinal in specified timezone & calendar.
    func weekdayOrdinal(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.weekdayOrdinal, from: self)
    }

    /// Quarter in specified timezone & calendar.
    func quarter(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        // Ref: https://nshipster.com/datecomponents See: rdar://35247464.
        let formatter = DateFormatter()
        formatter.dateFormat = "Q"
        return Int(formatter.string(from: self)) ?? getCalendar(timeZone: timeZone, calendar: calendar).component(.quarter, from: self)
    }

    /// WeekOfMonth in specified timezone & calendar.
    func weekOfMonth(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.weekOfMonth, from: self)
    }

    /// WeekOfYear in specified timezone & calendar.
    func weekOfYear(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.weekOfYear, from: self)
    }

    /// YearForWeekOfYear in specified timezone & calendar.
    func yearForWeekOfYear(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.yearForWeekOfYear, from: self)
    }

    /// Nanosecond in specified timezone & calendar.
    func nanosecond(in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Int {
        return getCalendar(timeZone: timeZone, calendar: calendar).component(.nanosecond, from: self)
    }

    private func getCalendar(timeZone: TimeZone?, calendar: Calendar?) -> Calendar {
        var calendar = calendar ?? Calendar.autoupdatingCurrent
        calendar.timeZone = timeZone ?? TimeZone.autoupdatingCurrent
        return calendar
    }
}

public extension Date {
    /// Initialize a Date object by setting date components.
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0, timeZone: TimeZone? = nil, calendar: Calendar? = nil) {
        var calendar = calendar ?? Calendar.autoupdatingCurrent
        calendar.timeZone = timeZone ?? TimeZone.autoupdatingCurrent

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: Date())
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        guard let date = calendar.date(from: components) else {
            return nil
        }
        self = date
    }

    /// Returns a new date by setting date component.
    func setting(_ component: Calendar.Component, with newValue: Int, in timeZone: TimeZone? = nil, for calendar: Calendar? = nil) -> Date? {
		var calendar = calendar ?? Calendar.autoupdatingCurrent
        let timeZone = timeZone ?? TimeZone.autoupdatingCurrent
		calendar.timeZone = timeZone

        var components = calendar.dateComponents(in: timeZone, from: self)
        switch component {
        case .era:
            components.era = newValue
        case .year:
            components.year = newValue
            components.yearForWeekOfYear = nil
        case .month:
            components.month = newValue
        case .day:
            components.day = newValue
        case .hour:
            components.hour = newValue
        case .minute:
            components.minute = newValue
        case .second:
            components.second = newValue
        case .weekday:
            components.day = (components.day ?? 0) + (newValue - (components.weekday ?? 0))
            components.weekday = newValue
        case .weekdayOrdinal:
            components.day = (components.day ?? 0) + (newValue - (components.weekdayOrdinal ?? 0)) * 7
            components.weekdayOrdinal = newValue
        case .quarter:
            let formatter = DateFormatter()
            formatter.dateFormat = "Q"
            let currentQuater = Int(formatter.string(from: self)) ?? components.quarter ?? 0
            components.month = (components.month ?? 0) + (newValue - currentQuater) * 3
            components.quarter = newValue
        case .weekOfMonth:
            components.day = (components.day ?? 0) + (newValue - (components.weekOfMonth ?? 0)) * 7
            components.weekOfMonth = newValue
        case .weekOfYear:
            components.day = (components.day ?? 0) + (newValue - (components.weekOfYear ?? 0)) * 7
            components.weekOfYear = newValue
        case .yearForWeekOfYear:
            components.yearForWeekOfYear = newValue
        case .nanosecond:
            components.nanosecond = newValue
        case .timeZone, .calendar:
            NSLog("Error: unsupported calendar component: \(component)")
        }

		return calendar.date(from: components)
    }
}
