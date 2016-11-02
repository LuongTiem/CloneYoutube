//
//  ExtensionColor.swift
//  Youtube
//
//  Created by ReasonAmu on 10/31/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit


extension UIColor {
    
     static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}


