//
//  ModelAVPlayer.swift
//  Youtube
//
//  Created by ReasonAmu on 11/3/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import AVFoundation


extension AVPlayerLayer {
    
    
    func setupAVPlayer(view : UIView){
        
        self.frame = view.frame
        self.videoGravity = AVLayerVideoGravityResizeAspectFill
        view.layer.addSublayer(self)
        
    }
    
    
}


