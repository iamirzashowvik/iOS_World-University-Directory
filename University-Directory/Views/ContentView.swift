//
//  ContentView.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var countries:[Country]=[]
    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
        
                Text("Universities in All Countries").onAppear{
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
                    }

                }
            }        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
