//  ContentView.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Main content view of the app
/// The connection between everything
/// Navigation tool for getting to anywhere on the app
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct ContentView: View {

    //workout store given to the entire app
    @StateObject private var workoutStore = WorkoutStore()

    //UI for main screen
    var body: some View {
        TabView {

            //dashboard tab
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            //Workout tab
            WorkoutView()
                .tabItem {
                    Image(systemName: "bolt.heart.fill")
                    Text("Workouts")
                }

            //Nutrition Tab
            NutritionView()
                .tabItem {
                    Image(systemName: "fork.knife.circle.fill")
                    Text("Nutrition")
                }

            //Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        //app color and workout store share factor
        .accentColor(.green)
        .environmentObject(workoutStore)
    }
}

#Preview {
    ContentView()
        .environmentObject(NutritionStore())
        .environmentObject(WorkoutStore())
}
