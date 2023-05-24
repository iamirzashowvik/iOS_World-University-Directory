//
//  SingleUniversity.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleUniversity: View {
    
    
    var university:University
    init(university: University) {
        self.university = university
       
    }
    
    @State var countries:[Country]=[]
    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]

    var body: some View {
        VStack(alignment:.leading){
            Text(university.name!).bold()
            Spacer()
            
            HStack{
                Image(systemName: "network")
                Text(university.domains[0])
            }
            Spacer()
            HStack{
                Image(systemName: "desktopcomputer")
                Text(university.domains[0])
            }
            
            
            HStack{
                Text("Visit Website")
                Spacer()
                Link("->",destination: URL(string:university.webPages[0])! )
                }.padding(.vertical)
            Spacer()
            Text("Other Countries").onAppear{
               countries = decodeJsonData()
            }
           
            if countries.count>0 {
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(countries,id: \.code) { country in
                            NavigationLink(
                                destination:SingleCountry(countryName: country.name,countryCode: country.code),
                                       label: {
                                           VStack{
                                               WebImage(url: URL(string: "https://flagsapi.com/\(country.code)/flat/64.png"))
                                               Text(country.name)
                                           }
                                       })
                        }
                    }.padding(.horizontal)
                }.frame(maxHeight: 300)

            }
            
        }
    }
}
