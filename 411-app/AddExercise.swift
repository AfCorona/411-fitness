//
//  AddExercise.swift
//  411-app
//
//  Created by Tony Dih
//

import SwiftUI

struct AddExercise: View {

    @Environment(\.dismiss) var dismiss
    @Binding var exercises: [Exercise]

    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var weight = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Info")) {
                    TextField("Exercise name", text: $exerciseName)
                }

                Section(header: Text("Strength Details")) {
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)

                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)

                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") { saveExercise() }
                        .disabled(exerciseName.isEmpty ||
                                  sets.isEmpty ||
                                  reps.isEmpty ||
                                  weight.isEmpty)
                }
            }
        }
    }

    private func saveExercise() {
        guard let s = Int(sets),
              let r = Int(reps),
              let w = Int(weight) else { return }

        // ✅ Match your current Exercise struct (in Workout.swift)
        //    - type uses ExerciseType
        //    - muscleGroup is a String
        //    - minutes is for cardio only (0 here)
        let newExercise = Exercise(
            name: exerciseName,
            type: .strength,
            muscleGroup: "Other",   // you can change this to a Picker later
            sets: s,
            reps: r,
            weight: w,
            minutes: 0
        )

        exercises.append(newExercise)
        dismiss()
    }
}

#Preview {
    // simple preview using constant binding
    AddExercise(exercises: .constant([]))
}
