// EventStorageService.swift
// DCICalendar
//
// Created by Sam Gilmore on 7/11/24.
//
import Foundation
import SwiftUI
class EventStorageService: ObservableObject {
  @Published var events: [Event] = {
    let events: [Event] = [
      Event(
        id: UUID(),
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        address: "123 Main Street, City, Country",
        flyerLink: "https://example.com/flyer1",
        attendance: true,
        title: "Tech Conference",
        description: "Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology.",
        type: .DCI,
        attendeeCount: 10,
        media: nil
      ),
      Event(
        id: UUID(),
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        address: "123 Main Street, City, Country",
        flyerLink: "https://example.com/flyer1",
        attendance: true,
        title: "Wow Amazing Event",
        description: "Annual tech conference covering the latest trends in technology.",
        type: .DCI,
        attendeeCount: 10,
        media: nil
      ),
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
      ),
      Event(
        id: UUID(),
        startDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
        endDate: Calendar.current.date(byAdding: .day, value: 2, to: Calendar.current.date(byAdding: .month, value: 1, to: Date())!)!,
        address: "789 Elm Street, City, Country",
        flyerLink: "https://example.com/flyer3",
        attendance: true,
        title: "Networking Event",
        description: "Networking event for professionals in the environmental sciences.",
        type: .DCI,
        attendeeCount: nil,
        media: nil
      )
    ]
    return events
  }()
  func updateEvent(_ updatedEvent: Event) {
    DispatchQueue.main.async {
      if let index = self.events.firstIndex(where: { $0.id == updatedEvent.id }) {
        self.events[index] = updatedEvent
      }
    }
  }
}
