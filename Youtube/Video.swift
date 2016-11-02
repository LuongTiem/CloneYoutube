
//
//  Video.swift
//  Youtube
//
//  Created by ReasonAmu on 11/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class Video {
    
    var thumbnailImageName : String?
    var numberViews : NSNumber?
    var title: String?
    var duration : NSNumber?
    var channel : Channel?
    
    init?(json : [String : AnyObject]) {
        
        guard let thumbnailImageName = json["thumbnail_image_name"] as? String else {
            return nil
        }
        guard let numberViews = json["number_of_views"] as? NSNumber else {
            return nil
        }
        guard let title = json["title"] as? String else {
            return nil
        }
        guard let duration = json["duration"] as? NSNumber else {
            return nil
        }
        
        guard let channelObject = json["channel"] as? [String : AnyObject] else {
            return nil
        }
        
        self.channel = Channel.init(channel: channelObject)
        
        self.thumbnailImageName = thumbnailImageName
        self.numberViews = numberViews
        self.title = title
        self.duration = duration
        
    }

}


