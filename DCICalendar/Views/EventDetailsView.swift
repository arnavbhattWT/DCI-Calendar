//
// EventDetailsView.swift
// DCICalendar
//
// Created by Sam Gilmore on 7/11/24.
//
import SwiftUI
import MapKit

struct EventDetailsView: View {
    var event: Event
    @State private var isAttending: Bool
    @EnvironmentObject var eventStorage: EventStorageService
    @ObservedObject var viewModel: EventDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
    init(event: Event) {
        self.event = event
        self._isAttending = State(initialValue: event.attendance)
//        if let eventAddress = event.wrappedValue?.address {
//            self.viewModel = EventDetailsViewModel(address: eventAddress)
//          } else {
//            self.viewModel = EventDetailsViewModel(address: "Default Address")
//          }
        self.viewModel = EventDetailsViewModel(address: event.address)
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(colorScheme == .dark ? Color.white.opacity(0.0) : Color.white, lineWidth: 2)
                            .padding(.top, 10)
                        Image("Banner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                            .shadow(radius: 5)
                    }
                    Text(event.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .padding(.top, 20)
                    Text("\(formattedDateTime(event.startDate)) - \(formattedEndTime(event.endDate))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.leading, 16)
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    Link(destination: URL(string: "http://maps.apple.com/?address=\(event.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!) {
                        Text("\(event.address)")
                            .font(.callout.smallCaps())
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                    }
                    Text("\(event.description)")
                        .font(.body)
                        .padding(.top, 10)
                        .padding(.horizontal, 16)
                    // Media text (if available)
                    if let media = event.media {
                        Text("\(media)")
                            .font(.callout)
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                    }
                    Map(coordinateRegion: $viewModel.mapRegion,
                        annotationItems: viewModel.annotations) { annotation in
                        MapAnnotation(coordinate: annotation.coordinate) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                Text(annotation.title ?? "")
                                    .fixedSize() // Ensure the text does not get truncated
                            }
                        }
                    }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding()
                    // lol
                    Text("\n\n\n\n")
                    Spacer()
                }
            }
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.top, 10)
                HStack {
                    Text("RSVP")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.top, 20)
                        .padding(.leading, 25)
                    Spacer()
                    Button(action: {
                        self.isAttending = true
                        self.updateAttendance()
                        // Open Bitly link
                        if let bitlyURL = URL(string: "https://bit.ly/DCIinterestform") {
                            UIApplication.shared.open(bitlyURL)
                        }
                    }) {
                        ZStack {
                            Capsule()
                                .fill(self.isAttending ? Color.blue : Color.gray)
                                .frame(width: 75, height: 40)
                            Text("Yes")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 8)
                    .padding(.top, 20)
                    Button(action: {
                        self.isAttending = false
                        self.updateAttendance()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(!self.isAttending ? Color.blue : Color.gray)
                                .frame(width: 75, height: 40)
                            Text("No")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                .padding(.vertical, 10)
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
        }
    }
    func formattedDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy | h:mm a"
        return formatter.string(from: date)
    }
    func formattedEndTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    private func updateAttendance() {
        var updatedEvent = event
        updatedEvent.attendance = isAttending
        eventStorage.updateEvent(updatedEvent)
    }
}
struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(id: UUID(),
                          startDate: Date(),
                          endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                          address: "123 Main Street, City, Country",
                          flyerLink: "https://example.com/flyer1",
                          attendance: true,
                          title: "Tech Conference",
                          description: "Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. Annual tech conference covering the latest trends in technology. ",
                          type: .DCI,
                          attendeeCount: 10,
                          media: "geoffwebsite.com/volunteer @ggrammer")
        EventDetailsView(event: event)
    }
}
