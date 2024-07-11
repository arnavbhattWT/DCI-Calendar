//
//  CalendarView.swift
//  DCICalendar
//
//  Created by Sam Gilmore on 7/11/24.
//


import SwiftUI

struct CalendarView: View {
    @State var currentTab: Tab = .calendar
    @ObservedObject var eventStorage: EventStorageService
    
    var days = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"]
    @State private var selectedMonth = 0
    @State var selectedDate = Date()
    
    func selected(date: Date) -> Bool {
        return date.currentComponents().day == selectedDate.currentComponents().day &&
        date.currentComponents().month == selectedDate.currentComponents().month
    }
    
    func isCurrent(date: Date) -> Bool {
        return date.currentComponents().day == Date().currentComponents().day &&
        date.currentComponents().month == Date().currentComponents().month
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Image("Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .ignoresSafeArea()
                
                HStack {
                    Text("Your Calendar, \nGeoff")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 35)
                        .padding(.leading, 30)
                    Spacer()
                }
            }
            
        }
        ScrollView {
            VStack (spacing: 20){
                HStack {
                    Button {
                        withAnimation {
                            selectedMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                    }
                    Text(selectedDate.stringFormat())
                        .font(.headline)
                    Button {
                        withAnimation {
                            selectedMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.headline)
                    }
                }
                HStack {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                    ForEach(fetchDates()) { value in
                        VStack {
                            if value.day != -1 {
                                Button {                    selectedDate = value.date
                                } label: {
                                    Text("\(value.day)")
                                    //                  .fontWeight(value.day == Date().currentComponents().day ? .bold : .regular)
                                        .background {
                                            ZStack (alignment: .bottom) {
                                                if isCurrent(date: value.date) {
                                                    Circle()
                                                        .frame(width: 35, height: 35)
                                                        .foregroundStyle(.customBlue)
                                                        .opacity(0.3)
                                                }
                                                if selected(date: value.date) {
                                                    Circle()
                                                        .frame(width: 35, height: 35)
                                                        .foregroundStyle(.red)
                                                        .opacity(0.3)
                                                }
                                            }
                                        }
                                }
                            } else {
                                Text("")
                            }
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(.customBlue)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 32, height: 32)
                    }
                }
            }
            .padding()
            .onChange(of: selectedMonth) {
                selectedDate = fetchMonth()
            }
            
            EventListView(eventStorage: eventStorage, filteredEvents: eventStorage.events)
        }
        CustomTabBar(currentTab: $currentTab)
    }
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchMonth()
        var dates = currentMonth.datesOfMonth().map({
            CalendarDate(day: calendar.component(.day, from: $0), date: $0)
        })
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        return dates
    }
    func fetchMonth() -> Date {
        let calendar = Calendar.current
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
}
struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}
extension Date {
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
#Preview {
    CalendarView(eventStorage: EventStorageService())
}
