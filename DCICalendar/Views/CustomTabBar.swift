//
//  CustomTabBar.swift
//  DCICalendar
//
//  Created by Alice Lisak on 7/11/24.
//

import SwiftUI

struct CustomTabBar: View {
    @State var currentTab: Tab = .home
    @ObservedObject var eventStorage = EventStorageService()
    @State var isActive = false

    var backgroundColors = [Color("white")]
    
    var body: some View {
        VStack {
            switch currentTab {
            case .home:
                HomeView(eventStorage: eventStorage)
                    .transition(.opacity)
            case .calendar:
                CalendarView(eventStorage: eventStorage)
                    .transition(.opacity)
            case .profile:
                ProfileView()
                    .transition(.opacity)
            }
            Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.rawValue) {tab in
                    Button{
                        withAnimation(.easeIn) {
                            currentTab = tab
                        }
                    }label:{
                        Image(tab.rawValue)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(currentTab.rawValue == tab.rawValue ? .customPurple : .black)

                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 30)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(.white)
        }
    }
}

#Preview {
    CustomTabBar()
//    HomeView()
}
