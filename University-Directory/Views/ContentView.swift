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
                        LazyVGrid(columns: columns, spacing: 0){
                            ForEach(countries,id: \.code) { country in
                                NavigationLink(
                                    destination:SingleCountry(countryName: country.name,countryCode: country.code),
                                           label: {
                                               VStack(alignment:.center){
                                                   WebImage(url: URL(string: "https://flagsapi.com/\(country.code)/flat/64.png"))
                                                   Text(country.name).lineLimit(1)
                                               }.frame(width: UIScreen.main.bounds.width/3, height: 90, alignment: .center)
                                                   .clipShape(Rectangle()).padding()
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


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
