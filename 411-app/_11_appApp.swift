//
//  _11_appApp.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

@main
struct _11_appApp: App {
    @StateObject private var nutritionStore = NutritionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()  
                .environmentObject(nutritionStore)
        }
    }
}
