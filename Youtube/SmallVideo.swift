//
//  SmallVideo.swift
//  Youtube
//
//  Created by ReasonAmu on 11/6/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class SmallVideo: NSObject {
    
    var titleVideo: String?
    var channelVideo: String?
    var imageVideo : String?
    var totalVideo : Int?
    
    
    init(title : String, channel : String, image : String, totalVideo : Int) {
        self.titleVideo = title
        self.channelVideo = channel
        self.imageVideo = image
        self.totalVideo = totalVideo
    }

}
