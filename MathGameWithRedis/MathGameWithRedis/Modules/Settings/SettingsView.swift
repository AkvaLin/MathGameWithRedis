//
//  SettingsView.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State var username = ""
    
    var body: some View {
        VStack {
            Text("Username: ")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TextField("User123", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                UserDefaults.standard.set(username, forKey: "username")
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            username = UserDefaults.standard.string(forKey: "username") ?? ""
        }
    }
}

#Preview {
    SettingsView()
}
