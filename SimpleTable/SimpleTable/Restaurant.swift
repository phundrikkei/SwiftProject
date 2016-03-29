//
//  Restaurant.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/22/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject {
//    var _name: String {
//        get {
//            return _name
//        }
//        
//        set(newName) {
//            _name = newName
//        }
    //    }
    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var type: String
    @NSManaged var image: NSData?
    @NSManaged var phoneNumber: String?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var rating: String?
    
//    init(){
//        name = ""
//        location = ""
//        type = ""
//        phoneNumber = ""
//        image = "cafedeadend.jpg"
//        isVisited = false
//        rating = "rating"
//    }
    
//    init(name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool){
//        self.name = name
//        self.location = location
//        self.type = type
//        self.image = image
//        self.isVisited = isVisited
//        self.phoneNumber = phoneNumber
//    }
    
    func isSave() -> Bool{
        if(location != "" && name != "" && type != ""){
            return true
        } else  {
            return false
        }
    }
}
