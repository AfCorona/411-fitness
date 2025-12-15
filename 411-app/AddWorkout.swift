//
//  AddMeal.swift
//  411-app
//
//  Created by Tony Dih
//

import SwiftUI

struct AddWorkout: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var workoutStore: WorkoutStore

    // Workout-level
    @State private var workoutName: String = ""
    @State private var workoutDate: Date = Date()

    // Selection-based exercise data
    @State private var selectedMuscleGroup: String = "Chest"
    @State private var selectedExerciseName: String = "Bench Press"

    @State private var sets: Int = 3
    @State private var reps: Int = 10
    @State private var weight: Int = 0
    @State private var minutes: Int = 20

    // Exercises added to this workout
    @State private var exercises: [Exercise] = []

    // Body parts
    let muscleGroups = ["Chest", "Back", "Legs", "Arms", "Shoulders", "Abs", "Cardio", "Full Body"]

    // Available exercises for each body part
    let exerciseOptions: [String: [String]] = [
        "Chest": ["Bench Press", "Incline Bench Press", "Push-Up", "Dumbbell Fly", "Dips"],
        "Back": ["Pull-Up", "Lat Pulldown", "Seated Row", "Bent-Over Row", "Deadlift"],
        "Legs": ["Squat", "Leg Press", "Lunge", "Leg Extension", "Leg Curl"],
        "Arms": ["Bicep Curl", "Hammer Curl", "Tricep Pushdown", "Tricep Dip", "Skull Crusher"],
        "Shoulders": ["Overhead Press", "Lateral Raise", "Front Raise", "Rear Delt Fly", "Arnold Press"],
        "Abs": ["Sit-Up", "Crunch", "Plank", "Leg Raise", "Russian Twist"],
        "Cardio": ["Running", "Cycling", "Jump Rope", "Elliptical", "Rowing"],
        "Full Body": ["Burpees", "Mountain Climbers", "Kettlebell Swing", "Clean and Press", "Farmer’s Walk"]
    ]

    // Helper: is current selection cardio?
    var isCardio: Bool {
        selectedMuscleGroup == "Cardio"
    }

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Workout info
                Section("Workout Info") {
                    TextField("Workout name (e.g. Chest Day)", text: $workoutName)
                    DatePicker("Date", selection: $workoutDate, displayedComponents: .date)
                }

                // MARK: - Exercise selection
                Section("Add Exercise") {
                    Picker("Muscle Group", selection: $selectedMuscleGroup) {
                        ForEach(muscleGroups, id: \.self) { group in
                            Text(group).tag(group)
                        }
                    }
                    .onChange(of: selectedMuscleGroup) { newGroup in
                        // When body part changes, reset the exercise list & pick the first one
                        if let first = exerciseOptions[newGroup]?.first {
                            selectedExerciseName = first
                        }
                    }

                    Picker("Exercise", selection: $selectedExerciseName) {
                        ForEach(exerciseOptions[selectedMuscleGroup] ?? [], id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }

                    if isCardio {
                        // Cardio: minutes only
                        Stepper("Minutes: \(minutes)", value: $minutes, in: 1...180)
                    } else {
                        // Strength: sets / reps / weight
                        Stepper("Sets: \(sets)", value: $sets, in: 1...10)
                        Stepper("Reps: \(reps)", value: $reps, in: 1...50)
                        Stepper("Weight: \(weight) lbs", value: $weight, in: 0...500)
                    }

                    Button("Add Exercise to Workout") {
                        addExercise()
                    }
                }

                // MARK: - Current exercises in this workout
                if !exercises.isEmpty {
                    Section("Exercises in this Workout") {
                        ForEach(exercises) { exercise in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(exercise.muscleGroup): \(exercise.name)")
                                    .font(.headline)

                                if exercise.type == .strength {
                                    Text("\(exercise.sets) sets × \(exercise.reps) reps @ \(exercise.weight) lbs")
                                        .font(.subheadline)
                                } else {
                                    Text("\(exercise.minutes) min cardio")
                                        .font(.subheadline)
                                }

                                Text("\(Int(exercise.caloriesBurned)) cal")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete { indexSet in
                            exercises.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveWorkout()
                    }
                    .disabled(workoutName.trimmingCharacters(in: .whitespaces).isEmpty || exercises.isEmpty)
                }
            }
            .onAppear {
                // Make sure we always have a valid initial exercise
                if let first = exerciseOptions[selectedMuscleGroup]?.first {
                    selectedExerciseName = first
                }
            }
        }
    }

    // MARK: - Actions

    private func addExercise() {
        let type: ExerciseType = isCardio ? .cardio : .strength

        let exercise = Exercise(
            name: selectedExerciseName,
            type: type,
            muscleGroup: selectedMuscleGroup,
            sets: isCardio ? 0 : sets,
            reps: isCardio ? 0 : reps,
            weight: isCardio ? 0 : weight,
            minutes: isCardio ? minutes : 0
        )

        exercises.append(exercise)

        // Reset some fields for next add (optional)
        if isCardio {
            minutes = 20
        } else {
            sets = 3
            reps = 10
            weight = 0
        }
    }

    private func saveWorkout() {
        let newWorkout = Workout(
            name: workoutName,
            date: workoutDate,
            exercises: exercises
        )

        workoutStore.workouts.append(newWorkout)
        dismiss()
    }
}

#Preview {
    AddWorkout()
        .environmentObject(WorkoutStore())
}
