//
//  NutritionSummaryCard.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Nutrition Summary Card
/// Quick over view of the eaten macros for that day
/// Total calories with a progress towards 2000 calories
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct NutritionSummaryCard: View {
    //holds all meals with macros
    @EnvironmentObject var store: NutritionStore
    
    var body: some View {
        //title of the card
        VStack(alignment: .leading, spacing: 12) {
            Text("Nutrition Summary")
                .font(.headline)
                .foregroundColor(.gray)

            HStack {
                //calories on the left side
                VStack(alignment: .leading) {
                    Text("Calories")
                        .font(.caption)
                        .foregroundColor(.gray)
                    //total calories pulled from butrition store
                    Text("\(store.totalCalories)")
                        .font(.title)
                        .bold()
                }

                Spacer()

                //rght side just a goood looking indicator with percent total
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .overlay(
                        Text("\(Int(progress * 100))%")
                            .font(.caption)
                            .bold()
                    )
            }
        }
        //styling
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }

    //Progress based off 2000 cals
    private var progress: CGFloat {
        let goal = 2000.0
        return min(CGFloat(store.totalCalories) / goal, 1.0)
    }
}

#Preview {
    NutritionSummaryCard()
        .environmentObject(NutritionStore())
}
