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
    
    
    @State private var search:String=""
    func checkAvailable(name:String,search:String)->Bool{
        return name.contains(search)
    }
    
    var body: some View {
        VStack(alignment:.leading){
            
            HStack{
                WebImage(url: URL(string: "https://flagsapi.com/\(countryCode)/flat/64.png"))
                Text("Universities in \(countryName)").task {
                    await   fetchData()
                }
            }
            TextField("Search",text:  $search).padding(.vertical)
            if universitiesResponse.count>0 {
                List{
                    ForEach (universitiesResponse,id: \.domains){ university in
                        if checkAvailable(name: university.name!, search: search) || search.count==0 {
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
}