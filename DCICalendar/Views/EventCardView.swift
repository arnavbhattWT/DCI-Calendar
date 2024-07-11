//
//  EventCardView.swift
//  DCICalendar
//
//  Created by Sam Gilmore on 7/11/24.
//

import SwiftUI

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: event.attendance ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text(event.title) // Truncated title
                            .lineLimit(1)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                            Text("\(formattedStartDate(event.startDate)) - \(formattedEndDate(event.endDate))")
                                //.lineLimit(1)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 2)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .background(event.type == .DCI ? Color.customBlue : Color.customPurple)
            .cornerRadius(10)
            .padding(.vertical, 5)
            
            Spacer()
        }
    }
    
    func formattedStartDate(_ date: Date) -> String {
        // "Saturday Jul 13, 1:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d, h:mm"
        let formattedString = formatter.string(from: date)
        return formattedString
    }
    
    func formattedEndDate(_ date: Date) -> String {
        // "4:00 PM"
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let formattedString = formatter.string(from: date)
        return formattedString
    }
}

#Preview {
    EventCardView(event:
                    Event(
                        id: UUID(),
                        startDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                        endDate: Calendar.current.date(byAdding: .day, value: 8, to: Date())!,
                        address: "456 Park Avenue, City, Country",
                        flyerLink: "https://example.com/flyer2",
                        attendance: true,
                        title: "Global Health Innovative Practice Workshop",
                        description: "Workshop on innovative practices in global health.",
                        type: .Partner,
                        attendeeCount: 24,
                        media: "@ggrammer"
                    )
    )
}
