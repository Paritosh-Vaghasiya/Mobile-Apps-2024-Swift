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
    @State private var showingUpdate: Bool = false
    
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
            
            Button(action: {showingUpdate = true}) {
                Text("Update Info")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingUpdate) {
                Update()
            }
            
            Button("Logout") {
                Task {
                    await logout()
                }
            }.font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $isLoggedOut) {
                    Logout()
                }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .task{
            await fetchUserProfile()
        }
    }
    
    // Fetch user profile data from Supabase
    func fetchUserProfile() async {
        do {
            let session = try await SupabaseManager.shared.client.auth.session
            if session == nil {
                errorMessage = "No active session found."
                return
            }
            
            let response: [UserProfile] = try await SupabaseManager.shared.client
                .from("Table_2")
                .select("firstName, lastName, city, email")
                .eq("id", value: session.user.id)
                .execute()
                .value
            
            if let userProfile = response.first {
                firstName = userProfile.firstName
                lastName = userProfile.lastName
                city = userProfile.city
                email = userProfile.email
            } else {
                errorMessage = "Profile data not found."
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    
    struct UserProfile: Decodable {
        let firstName: String
        let lastName: String
        let city: String
        let email: String
    }


    // Log out user
    func logout() async{
        do {
            try await SupabaseManager.shared.client.auth.signOut()
                isLoggedOut = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

//#Preview{
//    Display()
//}
