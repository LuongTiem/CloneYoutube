//
//  MenuCell.swift
//  Youtube
//
//  Created by ReasonAmu on 10/31/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cod
       
        
    }
    
    @IBOutlet weak var imageViews: UIImageView!
    
    override var isHighlighted: Bool {
        didSet{
            imageViews.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    
    override var isSelected: Bool {
        
        didSet{
            
            imageViews.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
}
