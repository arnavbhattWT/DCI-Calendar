//
//  CalendarView.swift
//  DCICalendar
//
//  Created by Brynne Delaney on 7/11/24.
//


import SwiftUI

struct CalendarView: View {
    private typealias Localization = LocalizedContent.Calendar

    @ObservedObject var eventStorage: EventStorageService
    
    var days = [Localization.Monday, Localization.Tuesday, Localization.Wednesday, Localization.Thursday, Localization.Friday, Localization.Saturday, Localization.Sunday]
    @State private var selectedMonth = 0
    @State var selectedDate = Date()
    @State private var showingEventDetails = false
    @State private var selectedEvent: Event? = nil

    func selected(date: Date) -> Bool {
        return selectedDate.dateIsEqual(to: date)
    }
    
    func isCurrent(date: Date) -> Bool {
        return Date().dateIsEqual(to: date)
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
                    Text("\(Localization.yourCalendar)\n\(LocalizedContent.Common.user(user: "Geoff"))")
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
                        Text(day.prefix(3))
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                    ForEach(fetchDates()) { value in
                        VStack {
                            if value.day != -1 {
                                Button {
                                    selectedDate = value.date
                                } label: {
                                    VStack {
                                        Text("\(value.day)")
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
                                                            .foregroundStyle(.customPurple)
                                                            .opacity(0.3)
                                                    }
                                                }
                                            }
                                        HStack(spacing: 4) {
                                            ForEach(eventStorage.events) { event in
                                                let isDCI = event.type == .DCI
                                                if !eventStorage.events.contains(where: { $0.startDate.dateIsEqual(to: value.date) }) {
                                                    Circle()
                                                        .frame(width: 5, height: 5)
                                                        .foregroundStyle(.clear)

                                                }
                                                if value.date.dateIsEqual(to: event.startDate) {
                                                    Circle()
                                                        .frame(width: 5, height: 5)
                                                        .foregroundStyle(isDCI ? .customBlue : .customPurple)
                                                }
                                            }
                                        }

                                    }
                                }
                            } else {
                                Text("")
                            }
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
            
            EventListView(eventStorage: eventStorage, filteredEvents: getSelectedDateEvents(date: selectedDate), date: selectedDate)
            Spacer()
        }
        .sheet(item: $selectedEvent) { event in
          EventDetailsView(event: event)
            .environmentObject(self.eventStorage)
        }
//        CustomTabBar(currentTab: $currentTab)
    }

    func getDaysWithEvents() -> [Date] {
        var days: [Date] = []
        for event in eventStorage.events {
            days.append(event.startDate)
        }
        return days
    }
    func getSelectedDateEvents(date: Date) -> [Event] {
        var filtered: [Event] = []
        for event in eventStorage.events {
            if (event.startDate.dateIsEqual(to: selectedDate)) {
            filtered.append(event)
          }
        }
        return filtered
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

#Preview {
    CalendarView(eventStorage: EventStorageService())
}
