//
//  EventListView.swift
//  DCICalendar
//
//  Created by Alice Lisak on 7/11/24.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var eventStorage: EventStorageService
    var filteredEvents: [Event]
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                ForEach(filteredEvents.indices, id: \.self) { index in
                    let event = filteredEvents[index]
                    
                    if index == 0 || !Calendar.current.isDate(event.startDate, inSameDayAs: filteredEvents[index - 1].startDate) {
                        
                        let dateString = formattedDividerDate(event.startDate)
                        
                        HStack {
                            Text(dateString)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray.opacity(0.5))
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 1)
                                .edgesIgnoringSafeArea(.horizontal)
                        }
                        .padding(.vertical, 8)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                    }
                    
                    EventCardView(event: event)
                        .padding(.leading)
                }
            }
        }
    }
    func formattedDividerDate(_ date: Date) -> String {
        // "Jun 20"
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let formattedString = formatter.string(from: date)
        return formattedString
    }
}

//#Preview {
//    EventListView(eventStorage: EventStorageService(), filteredEvents: )
//}
