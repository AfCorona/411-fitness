//
//  Workout.swift
//  411-app
//
//  Created by Tony Dih
//

import Foundation

enum ExerciseType: String, CaseIterable, Identifiable {
    case strength = "Strength"
    case cardio   = "Cardio"

    var id: String { rawValue }
}

struct Exercise: Identifiable {
    let id: UUID
    var name: String
    var type: ExerciseType
    var muscleGroup: String        // Chest, Abs, etc.
    var sets: Int                  // strength
    var reps: Int                  // strength
    var weight: Int                // strength (lbs)
    var minutes: Int               // cardio only

    // SIMPLE calorie estimate
    var caloriesBurned: Double {
        switch type {
        case .strength:
            let volume = Double(max(sets, 0) * max(reps, 0) * max(weight, 1))
            return volume * 0.02      // rough estimate
        case .cardio:
            return Double(max(minutes, 0)) * 8.0   // 8 cal / min
        }
    }

    init(
        id: UUID = UUID(),
        name: String,
        type: ExerciseType = .strength,
        muscleGroup: String = "",
        sets: Int = 0,
        reps: Int = 0,
        weight: Int = 0,
        minutes: Int = 0
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.muscleGroup = muscleGroup
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.minutes = minutes
    }
}

struct Workout: Identifiable {
    let id: UUID
    var name: String
    var date: Date
    var exercises: [Exercise]

    var totalCalories: Double {
        exercises.reduce(0) { $0 + $1.caloriesBurned }
    }

    init(
        id: UUID = UUID(),
        name: String,
        date: Date = Date(),
        exercises: [Exercise]
    ) {
        self.id = id
        self.name = name
        self.date = date
        self.exercises = exercises
    }
}
