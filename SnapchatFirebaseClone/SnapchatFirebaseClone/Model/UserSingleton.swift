//
//  UserSingleton.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import Foundation

class UserSingleton{
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init(){
        
    }
    
}
