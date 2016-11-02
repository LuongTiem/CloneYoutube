//
//  Setting.swift
//  Youtube
//
//  Created by ReasonAmu on 11/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class Setting : NSObject{
    
    var name : String?
    var image : String?
    init?(name : String , image : String) {
        self.name = name
        self.image = image
    }
}
