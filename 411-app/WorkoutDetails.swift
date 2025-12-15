//
//  WorkoutDetails.swift
//  411-app
//
//  Created by Tony Dih
//

import SwiftUI

struct WorkoutDetail: View {
    let workout: Workout

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Date:")
                    Spacer()
                    Text(workout.date.formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("Total Calories")
                    Spacer()
                    Text("\(Int(workout.totalCalories)) cal")
                        .bold()
                }
            }

            Section("Exercises") {
                ForEach(workout.exercises) { exercise in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(exercise.muscleGroup): \(exercise.name)")
                            .font(.headline)

                        if exercise.type == .strength {
                            Text("\(exercise.sets) sets × \(exercise.reps) reps @ \(exercise.weight) lbs")
                                .foregroundColor(.gray)
                        } else {
                            Text("\(exercise.minutes) min cardio")
                                .foregroundColor(.gray)
                        }

                        Text("\(Int(exercise.caloriesBurned)) cal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle(workout.name)
    }
}

#Preview {
    WorkoutDetail(workout:
        Workout(
            name: "Sample Workout",
            exercises: [
                Exercise(
                    name: "Bench Press",
                    type: .strength,
                    muscleGroup: "Chest",
                    sets: 4,
                    reps: 8,
                    weight: 135
                ),
                Exercise(
                    name: "Treadmill",
                    type: .cardio,
                    muscleGroup: "Cardio",
                    minutes: 20
                )
            ]
        )
    )
}
