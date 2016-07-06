//
//  Subcontent.swift
//  Delicious
//
//  Created by PhuND on 6/7/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit

class SubContent {
    var photo: String?
    var photoWidth: CGFloat?
    var photoHeight: CGFloat?
    var text: String?
    
    init(photo: String, photoWidth: CGFloat, photoHeight: CGFloat, text: String){
        self.photo = photo
        self.photoWidth = photoWidth
        self.photoHeight = photoHeight
        self.text = text
    }
}
