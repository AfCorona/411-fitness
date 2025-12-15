//
//  WorkoutView.swift
//  411-app
//
//  Created by Tony Dih
//

import SwiftUI

struct WorkoutView: View {

    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var showingAddWorkout = false

    var body: some View {
        NavigationView {
            VStack {
                if workoutStore.workouts.isEmpty {
                    Text("No workouts logged yet.")
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                } else {
                    List {
                        ForEach(workoutStore.workouts) { workout in
                            NavigationLink(destination: WorkoutDetail(workout: workout)) {
                                VStack(alignment: .leading) {
                                    Text(workout.name)
                                        .font(.headline)

                                    Text("\(workout.exercises.count) exercises · \(Int(workout.totalCalories)) cal")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddWorkout = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkout()
                    .environmentObject(workoutStore)
            }
        }
    }

    func deleteWorkout(at offsets: IndexSet) {
        workoutStore.workouts.remove(atOffsets: offsets)
    }
}

#Preview {
    WorkoutView()
        .environmentObject(WorkoutStore())
}
