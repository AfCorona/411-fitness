//
//  USDAFoodModels.swift
//  411-app
//
//  Created by Adolfo Corona
//

import Foundation

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// USDA Search Response
/// API response containing all info
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct USDASearchResponse: Decodable {
    let foods: [USDAFood]
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// USDA FOOD
/// Contains the information of a single food entry and extracts all the info
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct USDAFood: Identifiable, Decodable {
    let fdcId: Int
    let description: String
    let foodNutrients: [USDAFoodNutrient]

    var id: Int { fdcId }

    // USDA nutrients (100g usually)
    var servingSize: Double { 100 }

    var calories: Double {
        foodNutrients.first(where: { $0.nutrientName == "Energy" })?.value ?? 0
    }
    var protein: Double {
        foodNutrients.first(where: { $0.nutrientName == "Protein" })?.value ?? 0
    }
    var carbs: Double {
        foodNutrients.first(where: { $0.nutrientName == "Carbohydrate, by difference" })?.value ?? 0
    }
    var fat: Double {
        foodNutrients.first(where: { $0.nutrientName == "Total lipid (fat)" })?.value ?? 0
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// USDA food nutrient
/// Used to grab a single nutrient
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct USDAFoodNutrient: Decodable {
    let nutrientName: String
    let value: Double
}
