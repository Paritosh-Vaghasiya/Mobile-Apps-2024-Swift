//
//  Login.swift
//  Mobile Apps 2024 Swift
//
//  Created by Paritosh Vaghasiya on 11/3/24.
//

import SwiftUI
import Supabase

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isSignedIn: Bool = false
    @State private var showingSignup = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Login") {
                Task {
                    await login(email: email, password: password)
                }
            }.font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $isSignedIn) {
                    Display()
                }
            
            Button(action: {showingSignup = true}) {
                Text("Signup")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingSignup) {
                Signup()
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let session = try await SupabaseManager.shared.client.auth.signIn(email: email, password: password)
            if session != nil {
                isSignedIn = true
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
