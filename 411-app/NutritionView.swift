//
//  NutritionView.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Nutrition View
///Summary of calories + macros
///shows all meals logged
///allow user to add a meal
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct NutritionView: View {
    
    //nutritional data stored elsewhere
    @EnvironmentObject var store: NutritionStore
    @State private var showingAddMeal = false
    
    //Total values for each catagory
    var totalProtein: Int { store.totalProtein }
    var totalCarbs: Int { store.totalCarbs }
    var totalFat: Int { store.totalFat }
    var totalCalories: Int { store.totalCalories }
    
    var body: some View {
        NavigationView {
            VStack {
                // Total calories + macros card
                TotalCaloriesCard(
                    total: totalCalories,
                    protein: totalProtein,
                    carbs: totalCarbs,
                    fat: totalFat
                )
                    .padding(.horizontal)
                
                // List of meals the user has logged
                if store.meals.isEmpty {
                    Text("No meals logged yet.")
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                } else {
                    List {
                        ForEach(store.meals) { meal in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    //meal name
                                    Text(meal.name)
                                        .font(.headline)
                                    //meal catagory plus calories
                                    Text("\(meal.calories) calories • \(meal.category.rawValue)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    //meal macros
                                    Text("P: \(meal.protein)g   C: \(meal.carbs)g   F: \(meal.fat)g")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                        //delete by swiping
                        .onDelete(perform: deleteMeal)
                    }
                }
            }
            .navigationTitle("Nutrition")
            //add meal button on the top right corner
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddMeal = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            //allows user to add a new meal
            .sheet(isPresented: $showingAddMeal) {
                AddMeal(meals: $store.meals)
            }
        }
    }
    //allow the user to delete a meal
    func deleteMeal(at offsets: IndexSet) {
        store.meals.remove(atOffsets: offsets)
    }
}

#Preview {
    NutritionView()
        .environmentObject(NutritionStore())
}
