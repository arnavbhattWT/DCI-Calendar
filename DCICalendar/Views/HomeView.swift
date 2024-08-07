//
// HomeView.swift
// DCICalendar
//
// Created by Sam Gilmore on 7/11/24.
//
import SwiftUI
struct HomeView: View {
    private typealias Localization = LocalizedContent.Home

    @ObservedObject var eventStorage: EventStorageService
  @State private var isDCISelected: Bool = true
  @State private var selectedEvent: Event? = nil
  @State private var showingEventDetails = false
  var numberAttended: Int {
    eventStorage.events.reduce(0) { count, event in
      event.attendance ? count + 1 : count
    }
  }
  var filteredEvents: [Event] {
    var filtered: [Event] = []
    for event in eventStorage.events {
      if event.attendance && ((isDCISelected && event.type == .DCI) || (!isDCISelected && event.type == .Partner)) {
        filtered.append(event)
      }
    }
    return filtered
  }
  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .topLeading) {
        Image("Header")
          .resizable()
          .scaledToFit()
          .frame(width: 400)
          .ignoresSafeArea()
        HStack {
            Text("\(Localization.welcome)\n\(LocalizedContent.Common.user(user: "Geoff"))")
            .font(.title)
            .bold()
            .padding(.top, 35)
            .padding(.leading, 30)
          Spacer()
        }
      }
      HStack {
        Spacer()
        VStack {
          ZStack {
            CustomProgressRing(progress: Double(numberAttended) / 10,
                      backgroundRingColor: .customPurple.opacity(0.4),
                      primaryRingColor: .customPurple,
                      ringLineWidth: 10)
            VStack {
              Text("\(numberAttended)/10")
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(.customPurple)
            Text(Localization.eventsAttended)
                .foregroundColor(.customPurple)
            }
          }
          HStack(spacing: 0) {
              Text("\(Localization.untilEventUnlocked) **\(Localization.unlocked)**")
          }
          .foregroundColor(.customPurple)
          .padding(.top, 5)
        }
        Spacer()
      }
      .padding(.top, -40)
      .padding(.bottom, 20)
      HStack {
          Text(Localization.yourEvents)
              .font(.title3)
              .fontWeight(.bold)
          .padding(.leading, 30)
        Spacer()
          ToggleView(isDCI: $isDCISelected, leftName: Localization.partner, rightName: Localization.DCI)
          .padding(.trailing, 15)
      }
      .padding(.top, 18)
      .padding(.bottom, 10)
//      ScrollView {
//        VStack(spacing: 0) {
//          ForEach(filteredEvents.indices, id: \.self) { index in
//            let event = filteredEvents[index]
//            if index == 0 || !Calendar.current.isDate(event.startDate, inSameDayAs: filteredEvents[index - 1].startDate) {
//              let dateString = formattedDividerDate(event.startDate)
//              HStack {
//                Text(dateString)
//                  .font(.system(size: 15))
//                  .foregroundColor(Color.gray.opacity(0.5))
//                Rectangle()
//                  .fill(Color.gray.opacity(0.5))
//                  .frame(height: 1)
//                  .edgesIgnoringSafeArea(.horizontal)
//              }
//              .padding(.vertical, 8)
//              .padding(.leading, 20)
//              .padding(.trailing, 10)
//            }
//            EventCardView(event: event)
//              .padding(.leading)
//              .onTapGesture {
//                selectedEvent = event
//                self.showingEventDetails = true
//              }
//          }
//        }
//      }
        EventListView(eventStorage: eventStorage, filteredEvents: filteredEvents)
      Spacer()
    }
//      CustomTabBar(currentTab: $currentTab)

  }
  func formattedDividerDate(_ date: Date) -> String {
    // "Jun 20"
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    let formattedString = formatter.string(from: date)
    return formattedString
  }
}
struct CustomProgressRing: View {
  let progress: Double
  let backgroundRingColor: Color
  let primaryRingColor: Color
  let ringLineWidth: CGFloat
  var body: some View {
    ZStack {
      Circle()
        .stroke(backgroundRingColor, lineWidth: ringLineWidth)
      Circle()
        .trim(from: 0.0, to: progress)
        .stroke(
          style: StrokeStyle(
            lineWidth: ringLineWidth,
            lineCap: .round,
            lineJoin: .round
          )
        )
        .fill(primaryRingColor)
        .rotationEffect(.degrees(-90))
    }
  }
}
#Preview {
  HomeView(eventStorage: EventStorageService())
}
