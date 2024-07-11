//
//  CustomTabBar.swift
//  DCICalendar
//
//  Created by Alice Lisak on 7/11/24.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: Tab
    var backgroundColors = [Color("white")]
    
    var body: some View {
        VStack {
            
            Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.rawValue) {tab in
                    Button{
                        currentTab = tab
                    }label:{
                        Image(tab.rawValue)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                        
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
    //CustomTabBar(currentTab: .constant(.home))
    HomeView()
}
