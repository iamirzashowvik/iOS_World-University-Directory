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
           
            
            HStack{
                Image(systemName: "network")
                Text(university.domains[0])
            }
            
            HStack{
                Image(systemName: "desktopcomputer")
                Text(university.domains[0])
            }
            
            
            HStack{
                Text("Visit Website")
                Spacer()
                Text("->")
            }.padding().background(Color(hex:0x3A2367)).foregroundColor(Color(hex:0xffffff)).frame(width: .infinity, height: 90, alignment: .center)
                .clipShape(Rectangle()).onTapGesture {
                    UIApplication.shared.open(URL(string: university.webPages[0])!)
           }
         
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
                                               Text(country.name).lineLimit(1)
                                           }.frame(width: UIScreen.main.bounds.width/3, height: 90, alignment: .center)
                                                                                              .clipShape(Rectangle()).padding()
                                       })
                        }
                    }.padding(.horizontal)
                }.frame(maxHeight: .infinity)

            }
            
        }
    }
}
