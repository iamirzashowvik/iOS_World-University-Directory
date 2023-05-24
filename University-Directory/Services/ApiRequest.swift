//
//  ApiRequest.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//

import Foundation

class ApiRequest : ObservableObject{
    @Published var universities = Universities()
    
    func loadData(completion:@escaping (Universities) -> (),country
                  :String) {
        guard let url = URL(string: "") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let books = try! JSONDecoder().decode(Universities.self, from: data!)
            print(books)
            DispatchQueue.main.async {
                completion(books)
            }
        }.resume()
        
    }
}
