//
//  SingleCountry.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//

import SwiftUI

import Foundation
import SDWebImageSwiftUI

struct SingleCountry: View {
    var countryName:String
    var countryCode:String
    init(countryName: String,countryCode:String) {
        self.countryName = countryName
        self.countryCode = countryCode
    }
    
    
    @State var universitiesResponse = Universities()
    
func fetchData()async {
            do {
                let url = URL(string: "http://universities.hipolabs.com/search?country="+self.countryName)!
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(Universities.self, from: data)
                self.universitiesResponse = decodedData
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    
    
    var body: some View {
        VStack{
            HStack{
                WebImage(url: URL(string: "https://flagsapi.com/\(countryCode)/flat/64.png"))
                Text("Universities in \(countryName)").task {
                    await   fetchData()
                }
              
                
            }
            
            if universitiesResponse.count>0 {
                List{
                    ForEach (universitiesResponse,id: \.name){ university in
                        HStack{
                            Text(university.name!)
                            Spacer()
                            Link("->",destination: URL(string:university.webPages[0])! )
                        }
                        
                        
                    }
                }
            }
        }
    }
}
