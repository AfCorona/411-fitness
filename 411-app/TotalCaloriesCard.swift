//
//  TotalCaloriesCard.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Total Calories Card
/// UI that can be used anywhere
/// Displays macros in a simple to see way
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct TotalCaloriesCard: View {
    //calories + macros saved as ints
    var total: Int
    var protein: Int = 0
    var carbs: Int = 0
    var fat: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //card title
            Text("Today's Nutrition")
                .font(.caption)
                .foregroundColor(.gray)
            //calories
            Text("\(total) calories")
                .font(.largeTitle)
                .bold()
            //macros
            HStack {
                Text("P: \(protein)g")
                Text("C: \(carbs)g")
                Text("F: \(fat)g")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

