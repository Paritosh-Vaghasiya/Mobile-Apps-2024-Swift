//
//  Update.swift
//  Mobile Apps 2024 Swift
//
//  Created by Paritosh Vaghasiya on 11/3/24.
//

import SwiftUI
import Supabase

struct Update: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var city: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""
    @State private var showingDisplay = false
    @State private var isUpdated = false

    var body: some View {
        VStack {
            Text("Update Profile")
                .font(.largeTitle)
                .padding()

            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("City", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Update Info") {
                Task {
                    await updateProfile(
                        firstName: firstName,
                        lastName: lastName,
                        city: city
                    )
                }
            }.font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $isUpdated) {
                    Display()
                }

            Button(action: {showingDisplay = true}) {
                Text("Display")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingDisplay) {
                Display()
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            if !successMessage.isEmpty {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .task{
            await loadSession()
        }
    }

    // Load the session to ensure the user is logged in before updating
    func loadSession() async {
            do {
                let session = try await SupabaseManager.shared.client.auth.session
                if session == nil {
                    errorMessage = "No active session found."
                    return
                }
            } catch {
                errorMessage = error.localizedDescription
            }
    }

    // Update the profile information in Supabase
    func updateProfile(firstName: String, lastName: String, city: String) async {
            do {
                // Ensure there's an active session
                let userId = try await SupabaseManager.shared.client.auth.session.user.id
                
                if userId == nil {
                    errorMessage = "No active session found. Please log in."
                    return
                }

                // Update the user's profile in Supabase
                let response = try await SupabaseManager.shared.client
                    .from("Table_2") // Make sure this is the correct table name
                    .update([
                        "firstName": firstName.isEmpty ? nil : firstName,
                        "lastName": lastName.isEmpty ? nil : lastName,
                        "city": city.isEmpty ? nil : city
                    ])
                    .eq("id", value: userId)
                    .execute()

                // Handle response to check if update was successful
                if response != nil {
                    successMessage = "Profile updated successfully!"
                    errorMessage = ""
                } else {
                    errorMessage = "Error updating profile: Unknown error"
                }
                
                showingDisplay = true
            } catch {
                errorMessage = error.localizedDescription
            }
    }
}

//#Preview {
//    Update()
//}
