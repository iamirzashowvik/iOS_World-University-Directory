//
//  Universities.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//


//   let universities = try? JSONDecoder().decode(Universities.self, from: jsonData)

import Foundation


struct University: Codable {
    let country: String?
    let alphaTwoCode: String?
let name: String?
    
    let domains: [String]?
    let webPages: [String]

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case alphaTwoCode = "alpha_two_code"
        case name = "name"
        
        case domains = "domains"
        case webPages = "web_pages"
    }
}

typealias Universities = [University]

