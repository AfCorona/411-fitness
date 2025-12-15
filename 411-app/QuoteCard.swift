//
//  QuoteCard.swift
//  411-app
//
//  Created by Adolfo Corona
//

import SwiftUI

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Quote Card
/// Simple UI to show a motivational quote
/// Straight forward card that holds the motivational quote after button press
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct QuoteCard: View {
    //quote passed thru
    var quote: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            //header
            Text("Today's Motivation")
                .font(.headline)
                .foregroundColor(.gray)
            //the actual quote
            Text("“\(quote)”")
                .font(.title3)
                .bold()
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    QuoteCard(quote: "Small steps lead to big results.")
}
