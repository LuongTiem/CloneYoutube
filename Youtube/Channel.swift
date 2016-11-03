//
//  Channel.swift
//  Youtube
//
//  Created by ReasonAmu on 11/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class Channel {

    var name: String?
    var profileImage: String?
    
    
    init?(channel : [String : AnyObject]) {
        guard  let name = channel["name"] as? String else {
            return nil
        }
        guard let profileImage = channel["profile_image_name"] as? String else {
            return nil
        }
        
        self.name = name
        self.profileImage = profileImage
    }
}
