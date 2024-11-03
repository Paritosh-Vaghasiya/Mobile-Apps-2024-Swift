//
//  SupabaseManager.swift
//  Mobile-Apps-2024-Swift
//
//  Created by Paritosh Vaghasiya on 11/2/24.
//

import Supabase
import Foundation

class SupabaseManager {
    static let shared = SupabaseManager()
    private init() {}

    let client = SupabaseClient(
        supabaseURL: URL(string: "https://egzhuriimugvkjiauphl.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVnemh1cmlpbXVndmtqaWF1cGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQwNzEzNjcsImV4cCI6MjAzOTY0NzM2N30.29e4s0hYCEB3e4m0GDB2WgSpEDbiJSSC4FOg5aU8ZOk"
    )
}
