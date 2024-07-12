//
//  NoEventsView.swift
//  DCICalendar
//
//  Created by Brynne Delaney on 7/11/24.
//

import SwiftUI

struct NoEventsView: View {
    private typealias Localization = LocalizedContent.EventList

    var body: some View {
        VStack {
            Text(Localization.noEvent)
                .font(.caption)
            Image("DCI Logo")
        }
    }
}

#Preview {
    NoEventsView()
}
