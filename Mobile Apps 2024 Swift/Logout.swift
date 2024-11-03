//
//  Logout.swift
//  Mobile Apps 2024 Swift
//
//  Created by Paritosh Vaghasiya on 11/3/24.
//

import SwiftUI

struct Logout: View {
    @State private var navigateToLogin = false // Controls navigation
    
    var body: some View {
        VStack(spacing: 20) {
            Text("You have been logged out")
                .font(.title)
                .padding()
            
            Button(action: {
                // Trigger navigation to LoginView
                navigateToLogin = true
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 40)
            .navigationDestination(isPresented: $navigateToLogin) {
                Login() // Navigates to LoginView when navigateToLogin is true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}


#Preview {
    Logout()
}
