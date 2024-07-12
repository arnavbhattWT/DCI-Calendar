//
//  DateExtension.swift
//  DCICalendar
//
//  Created by Brynne Delaney on 7/11/24.
//

import Foundation

extension Date {
    func dateIsEqual(to: Date) -> Bool {
        return self.currentComponents().day == to.currentComponents().day &&
        self.currentComponents().month == to.currentComponents().month && self.currentComponents().year == to.currentComponents().year
    }
    func currentComponents() -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(in: .current, from: self)
    }
    func stringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: self)
    }
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        var startDateComponents = DateComponents()
        startDateComponents.month = currentMonth
        startDateComponents.year = currentYear
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        var dates: [Date] = []
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}
