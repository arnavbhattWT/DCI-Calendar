//
//  LocalizedContent.swift
//  DCICalendar
//
//  Created by Brynne Delaney on 7/11/24.
//

import Foundation

enum LocalizedContent {
    enum Common {
        // "Geoff"
        static func user(user: String) -> String {
            String(
                localized: "calendar-screen.text.user",
                defaultValue: "\(user)",
                comment: "Calendar Screen title"
            )
        }
    }

    enum Home {
        /// "Welcome"
        static let welcome = String(
                localized: "home-screen.text.welcome",
                defaultValue: "Welcome,",
                comment: "Welcome message to user"
            )

        /// "events attended"
        static let eventsAttended = String(
            localized: "home-screen.text.events-attended",
            defaultValue: "events attended",
            comment: "Events attended text for progress"
        )

        ///  Until Gift Drive Event
        static let untilEventUnlocked = String(
            localized: "home-screen.text.events-to-unlock",
            defaultValue: "Until Gift Drive Event ",
            comment: "Until next event unclocked"
        )

        /// Unlocked
        static let unlocked = String(
            localized: "home-screen.text.unlocked",
            defaultValue: "Unlocked",
            comment: "Word unclocked"
        )

        /// "Your Events"
        static let yourEvents = String(
            localized: "home-screen.text.your-events",
            defaultValue: "Your events",
            comment: "Title for RSVP events"
        )

        /// Partner
        static let partner = String(
            localized: "home-screen.toggle.partner",
            defaultValue: "Partner",
            comment: "Title for Partner Toggle"
        )

        /// DCI
        static let DCI = String(
            localized: "home-screen.toggle.dci",
            defaultValue: "DCI",
            comment: "Title for DCI Toggle"
        )
    }

    enum Calendar {
        /// Monday
        static let Monday = String(
            localized: "calendar-screen.text.monday",
            defaultValue: "Monday",
            comment: "Monday"
        )

        /// Tuesday
        static let Tuesday = String(
            localized: "calendar-screen.text.tuesday",
            defaultValue: "Tuesday",
            comment: "Tuesday"
        )

        /// Wednesday
        static let Wednesday = String(
            localized: "calendar-screen.text.wednesday",
            defaultValue: "Wednesday",
            comment: "Wednesday"
        )

        /// Thursday
        static let Thursday = String(
            localized: "calendar-screen.text.thursday",
            defaultValue: "Thursday",
            comment: "Thursday"
        )

        /// Friday
        static let Friday = String(
            localized: "calendar-screen.text.friday",
            defaultValue: "Friday",
            comment: "Friday"
        )

        /// Saturday
        static let Saturday = String(
            localized: "calendar-screen.text.saturday",
            defaultValue: "Saturday",
            comment: "Saturday"
        )

        /// Sunday
        static let Sunday = String(
            localized: "calendar-screen.text.sunday",
            defaultValue: "Sunday",
            comment: "Sunday"
        )

        /// "Your Calendar, \nGeoff"
        static let yourCalendar = String(
                localized: "calendar-screen.text.your-calendar-user",
                defaultValue: "Your calendar,",
                comment: "Calendar Screen title"
            )

    }

    enum EventList {
        /// There are no events this day.
        static let noEvent = String(
            localized: "event-list.text.no-events",
            defaultValue: "There are no events to show this day.",
            comment: "Empty view text for no events"
        )

        /// Event title
        static func eventTitle(title: String) -> String {
            String(
                localized: "event-list.text.no-events",
                defaultValue: "There are no events to show this day.",
                comment: "Empty view text for no events"
            )
        }
    }

    enum Profile {
        /// Coach
        static let coach = String(
            localized: "profile.text.coach",
            defaultValue: "Coach",
            comment: "Coach text"
        )

        /// Have Questions? Contact Us.
        static let haveQs = String(
            localized: "profile.text.have-questions",
            defaultValue: "Have Questions? Contact Us",
            comment: "Have Questions? Contact Us"
        )
    }
}
