//
//  DataService.swift
//  NewHungryCougar
//
//  Created by Kyle Nakamura on 2/28/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()
let ST_BASE = Storage.storage().reference()

class DataService {
    
    // Global object
    static let ds = DataService()
    
    // DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("restaurant-hours")
    
    // ST References
    private var _REF_POST_IMAGES = ST_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
}
