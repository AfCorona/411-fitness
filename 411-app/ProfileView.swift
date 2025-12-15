//
//  ProfileView.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Profile View
/// Stores user information
/// Very generic info and nothing personal is stored
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct ProfileView: View {

    //Straight forward function names to specify user information
    @AppStorage("weight") private var weight = ""
    @AppStorage("weightGoal") private var wGoal = ""
    @AppStorage("height") private var height = ""
    @AppStorage("gender") private var gender = "Male"
    @AppStorage("fitnessGoal") private var goal = "Stay Healthy"
    
    //Specific macro + calories information to personalize the app
    @AppStorage("calorieGoal") private var calorieGoal = ""
    @AppStorage("proteinGoal") private var proteinGoal = ""
    @AppStorage("carbGoal") private var carbGoal = ""
    @AppStorage("fatGoal") private var fatGoal = ""

    var body: some View {
        Form {
            Section(header: Text("Your Body Stats")) {
                //body stats
                TextField("Weight (lbs)", text: $weight)
                TextField("Height (ft-in)", text: $height)
                //gender stats
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Other").tag("Other")
                }
                //Specific goal for why they are working out/tracking macros
                Picker("Fitness Goal", selection: $goal) {
                    Text("Lose Weight").tag("Lose Weight")
                    Text("Gain Muscle").tag("Gain Muscle")
                    Text("Increase Strength").tag("Increase Strength")
                    Text("Stay Healthy").tag("Stay Healthy")
                }
                //weight goal stats
                TextField("Weight Goal (lbs)", text: $wGoal)
            }
            //daily nutritional goals to meet set goal
            Section(header: Text("Daily Nutrition Goals")) {
                TextField("Calories", text: $calorieGoal)
                TextField("Protein (g)", text: $proteinGoal)
                TextField("Carbs (g)", text: $carbGoal)
                TextField("Fat (g)", text: $fatGoal)
            }
        }
    }
}

