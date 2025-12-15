//
//  AddMeal.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Add a meal using USDA API
/// Let the meals change by serving size or be manually inputted
/// Probelms include poor UI and not the best adding machine
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct AddMeal: View {
    
    //Ask user for input about what to search
    @State private var searchQuery = ""
    //Api call return result
    @State private var searchResults: [USDAFood] = []
    //Spinning circle while we wait on Api call
    @State private var isSearching = false
    
    //api call helper
    let usda = USDA()
    
    //cancel button helper
    @Environment(\.dismiss) var dismiss
        
    //push meals without owning the meals data
    @Binding var meals: [Meal]
    
    //variables to store info - named for understanding
    @State private var mealName = ""
    @State private var calories = ""
    @State private var selectedCategory: MealCategory = .breakfast
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var portionAmount = ""
    @State private var portionType: PortionType = .grams
    
    //which portion type to be used after calling USDA API
    enum PortionType: String, CaseIterable, Identifiable {
        case grams = "Grams"
        case servings = "Servings"

        var id: String { rawValue }
    }
    
    //body
    var body: some View {
        NavigationView {
            Form {
                //USDA search section
                Section(header: Text("Search Food (USDA)")) {
                    HStack {
                        TextField("Search for food...", text: $searchQuery)
                        
                        Button("Search") {
                            performUSDASearch()
                        }
                        .disabled(searchQuery.isEmpty)
                    }
                    //let the user know the data is being grabbed
                    if isSearching {
                        ProgressView("Searching…")
                    }
                    
                    //what was returned from the API call
                    ForEach(searchResults) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.description)
                                .font(.headline)
                            
                            Text("Calories: \(Int(item.calories))")
                            Text("Protein: \(Int(item.protein)) g")
                            Text("Carbs: \(Int(item.carbs)) g")
                            Text("Fat: \(Int(item.fat)) g")
                        }
                        .padding(.vertical, 6)
                        
                        Button("Use This Food") {
                            applyUSDAFood(item)
                        }
                        .padding(.top, 4)
                    }
                }
                
                //generic meal information such as meal name and meal catagory ie breakfast etc.
                Section(header: Text("Meal Information")) {
                    TextField("Meal name", text: $mealName)

                    Picker("Category", selection: $selectedCategory) {
                        ForEach(MealCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                //user input grams or serving amounts
                Section(header: Text("Portion Size")) {
                    TextField("Amount (e.g., 200)", text: $portionAmount)
                        .keyboardType(.decimalPad)

                    Picker("Type", selection: $portionType) {
                        ForEach(PortionType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                //USer or ASDA inputted information based on meal
                Section(header: Text("Macros (grams)")) {
                    TextField("Protein (g)", text: $protein)
                        .keyboardType(.numberPad)

                    TextField("Carbs (g)", text: $carbs)
                        .keyboardType(.numberPad)

                    TextField("Fat (g)", text: $fat)
                        .keyboardType(.numberPad)
                    
                    TextField("Calories (kcal)", text: $calories)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Meal")
            //Save or cancel button for UI
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveMeal()
                    }
                    .disabled(mealName.isEmpty || calories.isEmpty)
                }
            }
        }
    }
    
    //Convert the values to numbers for storing and saving the meal
    func saveMeal() {
        guard
            //Stores the amount of (name)
            let p = Int(protein),
            let c = Int(carbs),
            let f = Int(fat),
            let _ = Int(calories)
        else { return }
        
        //save the meal for logging and into the system
        let newMeal = Meal(
            name: mealName,
            category: selectedCategory,
            protein: p,
            carbs: c,
            fat: f,
            calories: Int(calories)!
        )
        //save meal to newMeal
        meals.append(newMeal)
        dismiss()
    }
    
    //Performs the search for the USDA food using the API
    func performUSDASearch() {
        isSearching = true
        searchResults = []

        usda.searchFood(searchQuery) { result in
            DispatchQueue.main.async {
                self.isSearching = false
                switch result {
                case .success(let response):
                    // Map the response to [USDAFood]. Adjust the property name if needed.
                    // Assuming `USDASearchResponse` has a property `foods` of type [USDAFood]
                    self.searchResults = response.foods
                case .failure(let error):
                    // Clear results on failure and optionally log the error
                    self.searchResults = []
                    // You might want to surface this error to the UI in the future
                    print("USDA search failed: \(error)")
                }
            }
        }
    }
    
    //apply the macros of the food that was grabbed from the search
    func applyUSDAFood(_ item: USDAFood) {
        guard let amount = Double(portionAmount) else {
            // If no portion entered, default to USDA's single serving
            protein = String(Int(item.protein))
            carbs = String(Int(item.carbs))
            fat = String(Int(item.fat))
            calories = String(Int(item.calories))
            return
        }
        
        // Determine scale factor
        let scale: Double
        if portionType == .grams {
            scale = amount / item.servingSize
        } else {
            scale = amount
        }
        
        protein = String(Int(item.protein * scale))
        carbs   = String(Int(item.carbs * scale))
        fat     = String(Int(item.fat * scale))
        calories = String(Int(item.calories * scale))
    }

}

#Preview {
    AddMeal(meals: .constant([]))
}
