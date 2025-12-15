//
//  USDA.swift
//  411-app
//
//  Created by Adolfo Corona on 12/10/25.
//

import Foundation

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// USDA
/// Handles API calls
/// Search function
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class USDA {
    
    private let apiKey = "pG5YX76vnhAq0fc9p8rzviS8x0dh2BLATYmnayB0"
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// Search Foods
    /// Actually performs the API search based on user input
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func searchFood(_ query: String,
                    completion: @escaping (Result<USDASearchResponse, Error>) -> Void) {
        
        //build API URL with query + key
        let urlString =
        "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(query)&pageSize=1&api_key=\(apiKey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //convert string to url object
        guard let url = URL(string: urlString) else {
            print("Invalid USDA URL")
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //network error
            if let error = error {
                print("USDA API Error:", error)
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            //ensure server actually sent data
            guard let data = data else {
                print("No data returned")
                DispatchQueue.main.async { completion(.failure(URLError(.badServerResponse))) }
                return
            }
            //decode the response from json
            do {
                let decoded = try JSONDecoder().decode(USDASearchResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                print("JSON Decode Error:", error)
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
        }.resume()
    }
}
