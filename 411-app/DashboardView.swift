//
//  DashboardView.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Dashboard view for the app
/// Shows motivational quote based on user's day
/// Displays calorie burn + nutrition summary
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//How is the users day going and perform action
enum DayType {
    case none, greatDay, day
}

struct DashboardView: View {
    
    //workout to grab calories burned
    @EnvironmentObject var workoutStore: WorkoutStore   // 👈 get workouts here
        
    //Store the kind of day user selected and store the quote based on the user option
    @State private var dayType: DayType = .none
    @State private var selectedQuote = ""
    
    // Great day quotes are just positive to keep the vibe alive
    let greatDayQuotes = [
        "You're on a roll today!",
        "Love that energy — keep it going!",
        "Great days make great progress.",
        "Let’s build on that momentum!",
        "Make each day your masterpiece.",
        "Give every day the chance to become the most beautiful day of your life.",
        "You have the strength to handle anything this day brings",
        "Enjoy your life today because yesterday had gone and tomorrow may never come.",
    ]
    
    // Day quotes are supposed to be uplifting or motivational to keep going through a rough day
    let dayQuotes = [
        "Even on a regular day, you're showing up.",
        "A small step forward is still a win.",
        "Let’s turn this day into something better.",
        "You've got what it takes — keep going.",
        "If opportunity doesn't knock, build a door.",
        "Never regret a day in your life: good days give happiness, bad days give experience, worst days give lessons, and best days give memories",
        "You are braver than you believe, stronger than you seem, and smarter than you think"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Request info about day
                if dayType == .none {
                    Text("How’s your day going?")
                        .font(.title3)
                        .bold()
                    //the 2 user options and then select a random quote depending on type of day
                    HStack(spacing: 16) {
                        Button {
                            dayType = .greatDay
                            selectedQuote = greatDayQuotes.randomElement() ?? ""
                        } label: {
                            Text("Great Day")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(12)
                        }

                        Button {
                            dayType = .day
                            selectedQuote = dayQuotes.randomElement() ?? ""
                        } label: {
                            Text("Day")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                } else {
                    //show quote after button press not the buttons
                    QuoteCard(quote: selectedQuote)
                }

                //calories burned card
                VStack(alignment: .leading, spacing: 8) {
                    Text("Calories Burned (Workouts)")
                        .font(.headline)

                    Text("\(Int(workoutStore.totalCaloriesBurnedToday)) cal")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)

                // nutrition summary card call for info
                NutritionSummaryCard()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Dashboard")
    }
}

#Preview {
    DashboardView()
        .environmentObject(WorkoutStore())
        .environmentObject(NutritionStore())
}
