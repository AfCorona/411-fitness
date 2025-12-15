//
//  NutritionStore.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI
import Combine

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Nutrition info storage
/// Holds all info about logged meals and totals for meals as well
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class NutritionStore: ObservableObject {
    //array to store every meal logged for the day
    @Published var meals: [Meal] = []
    //total protien across all logged meals that day
    var totalProtein: Int {
        meals.reduce(0) { $0 + $1.protein }
    }
    //total carbs across all logged meals that day
    var totalCarbs: Int {
        meals.reduce(0) { $0 + $1.carbs }
    }
    //total fat across all logged meals that day
    var totalFat: Int {
        meals.reduce(0) { $0 + $1.fat }
    }
    //total calories across all logged meals that day
    var totalCalories: Int {
        meals.reduce(0) { $0 + $1.calories }
    }
}

