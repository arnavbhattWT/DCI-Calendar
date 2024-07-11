//
//  ToggleView.swift
//  DCICalendar
//
//  Created by Sam Gilmore on 7/11/24.
//

import SwiftUI

struct ToggleView: View {
    @Binding var isDCI: Bool
    var leftName: String
    var rightName : String
    
    var body: some View {
        ZStack{
            Capsule()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 200, height: 25)
                .onTapGesture {
                    isDCI.toggle()
                }
            HStack{
                ZStack{
                    Capsule()
                        .fill(isDCI ? Color.blue : Color.purple)
                        .frame(width: 105, height: 25)
                        .offset(x: isDCI ? 107 : 0)
                        .animation(.easeOut(duration: 0.2))
                    Text("\(leftName)")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isDCI ? .gray : .white)
                        .animation(.easeInOut(duration: 0.2))
                }
                ZStack{
                    Capsule()
                        .fill(.clear)
                        .frame(width: 98,height: 25)
                    Text("\(rightName)")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isDCI ? .white : .gray)
                        .animation(.easeInOut(duration: 0.2))
                }
            }
        }
    }
}

#Preview {
    ToggleView(isDCI: .constant(true), leftName: "Partner", rightName: "DCI")
}
