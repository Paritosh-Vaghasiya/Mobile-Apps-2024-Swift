//
//  Signup.swift
//  Mobile Apps 2024 Swift
//
//  Created by Paritosh Vaghasiya on 11/3/24.
//

import SwiftUI
import Supabase

struct Signup: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var city: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var showingLogin = false
    @State private var isSignedUp = false
    
    
    var body: some View {
        VStack {
            Text("Signup")
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
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Signup") {
                Task {
                    await signup(
                        firstName: firstName,
                        lastName: lastName,
                        city: city,
                        email: email,
                        password: password
                    )
                }
            }.font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $isSignedUp) {
                    Login()
                }
            
            
            Button(action: {showingLogin = true}) {
                Text("Login")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingLogin) {
                Login()
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    func signup(firstName: String, lastName: String, city: String, email: String, password: String) async {
        do {
            let response = try await SupabaseManager.shared.client.auth.signUp(email: email, password: password)
            
            let data: [String: String] = [
                "firstName": firstName,
                "lastName": lastName,
                "city": city,
                "email": email
            ]
            
            try await SupabaseManager.shared.client.from("Table_2").insert(data).execute()
            
            if response != nil {
                isSignedUp = true
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}



//#Preview{
//    Signup()
//}
