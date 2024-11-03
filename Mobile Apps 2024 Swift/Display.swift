//
//  Display.swift
//  Mobile Apps 2024 Swift
//
//  Created by Paritosh Vaghasiya on 11/3/24.
//

import SwiftUI
import Supabase

struct Display: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var city: String = ""
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggedOut: Bool = false

    var body: some View {
        VStack {
            Text("Your Profile")
                .font(.largeTitle)
                .padding()

            VStack(alignment: .leading) {
                Text("First Name: \(firstName)")
                Text("Last Name: \(lastName)")
                Text("City: \(city)")
                Text("Email: \(email)")
            }
            .padding()
            .font(.body)

            Button(action: {
                // Navigate to Update Info view (this can be a new SwiftUI view)
            }) {
                Text("Update Info")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Button(action: logout) {
                Text("Logout")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear(perform: fetchUserProfile)
    }

    // Fetch user profile data from Supabase
    func fetchUserProfile() {
//        Task {
//            do {
//                // Retrieve the user's session to ensure they are logged in
//                let session = try await SupabaseManager.shared.client.auth.session
//                if let session = session {
//                    // Fetch user profile from Supabase
//                    let response = try await SupabaseManager.shared.client
//                        .database
//                        .from("Table_2")
//                        .select()
//                        .execute()
//
//                    if let userProfile = response.value?.first {
//                        firstName = userProfile["firstName"] as? String ?? ""
//                        lastName = userProfile["lastName"] as? String ?? ""
//                        city = userProfile["city"] as? String ?? ""
//                        email = userProfile["email"] as? String ?? ""
//                    } else {
//                        errorMessage = "Profile data not found."
//                    }
//                } else {
//                    errorMessage = "No active session found."
//                }
//            } catch {
//                errorMessage = error.localizedDescription
//            }
//        }
    }

    // Log out user
    func logout() {
        Task {
            do {
                try await SupabaseManager.shared.client.auth.signOut()
                isLoggedOut = true
                // Navigate back to login view after logout
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview{
    Display()
}
