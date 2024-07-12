//
//  ProfileView.swift
//  DCICalendar
//
//  Created by Arnav Bhatt on 7/12/24.
//

import SwiftUI

struct ProfileView: View {
    private typealias Localization = LocalizedContent.Home


    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Image("Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .ignoresSafeArea(edges: .top)
                HStack {
                    Text("\(Localization.welcome)\n\(LocalizedContent.Common.user(user: "Geoff"))")
                        .font(.title)
                        .bold()
                        .padding(.top, 35)
                        .padding(.leading, 30)
                    Spacer()
                }
            }
        }
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Geoff Grammer")
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Divider().background(.primary)

                HStack {
                    Text("ggrammer")
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Divider().background(.primary)

                HStack {
                    Text("••••••••")
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Divider().background(.primary)

                HStack {
                    Text("geoffthecool@gmail.com")
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Divider().background(.primary)

                HStack {
                    Text("999-999-9999")
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)

                Divider().background(.primary)
            }
            
            Spacer()
            
            Text("DCI \(LocalizedContent.Profile.coach): Vikki Leathers")
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.customPurple)
                            .padding(-40)
            
            Text(LocalizedContent.Profile.haveQs)
            Text("919-333-9999 | DCIHelp@dci.com")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
        }
        .padding([.horizontal, .top])
        .navigationBarTitle("Profile", displayMode: .inline)
    }

}

#Preview {
    ProfileView()
}
