//
//  LocalStorage.swift
//  University-Directory
//
//  Created by Mirza  on 24/5/23.
//

import Foundation

struct AppStrings {
    static let keyOne = "firstStringKey"
    static let keyTwo = "secondStringKey"
}



class LocalStorageX{
   func save(value:String,key:String){
        let defaults = UserDefaults.standard
        defaults.set(
           value,
            forKey: key
        )
    }
  func  read(key:String)->String{
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(
            forKey: key
        ) {
            return stringOne;
        }
      return "";
    }
}
