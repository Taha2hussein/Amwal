//
//  UserDefault Data.swift
//  Runner
//
//  Created by Diaa saeed on 14/05/2024.
//

import Foundation

class UserModelkeys{
    let amwalType = "ticker"
}

class UserDefaultModel {

    private var keys = UserModelkeys()
    
    static var shared: UserDefaultModel = {
        let object = UserDefaultModel()
        return object
    }()
    
    private init(){}
    
    //MARK: - Get from user defualt
   
    func getamwalType() -> String {
       return UserDefaults.standard.value(forKey: keys.amwalType) as? String ?? ""
    }
    
    
    // MARK: - Set from user defualt

    func settamwalType(type: String) {
        UserDefaults.standard.set(type, forKey: keys.amwalType)
    }
    
}
