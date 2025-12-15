//
//  WrokoutStore.swift
//  411-app
//
//  Created by Tony Dih
//

import Foundation
import Combine

final class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []

    // only today's calories
    var totalCaloriesBurnedToday: Double {
        let calendar = Calendar.current
        return workouts
            .filter { calendar.isDateInToday($0.date) }
            .reduce(0) { $0 + $1.totalCalories }
    }
}
