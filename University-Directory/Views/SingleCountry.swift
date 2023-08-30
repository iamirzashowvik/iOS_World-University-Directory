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
    // update
    
    @State var universitiesResponse = Universities()
    
    
    func fetchData()async {
                do {
                    let body: Data? = nil
                    let api = API()
                    let headers: [String: String]? = nil
                    self.universitiesResponse = try  await api.request(url: "http://universities.hipolabs.com/search?country="+self.countryName, method: "GET", body: body, headers: headers)
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
                            NavigationLink(destination:SingleUniversity(university: university) ){
                                HStack{
                                    Text(university.name!)
                                
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
