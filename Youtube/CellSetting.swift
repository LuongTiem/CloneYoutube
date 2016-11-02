//
//  CellSetting.swift
//  Youtube
//
//  Created by ReasonAmu on 11/2/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellSetting: UICollectionViewCell {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    override var isHighlighted: Bool{
        
        didSet{
            
            backgroundColor = isHighlighted ? UIColor.darkGray  : UIColor.white
            titleName.textColor = isHighlighted ? UIColor.white : UIColor.black
            image.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            
        }
    }
    
    
    var setting : Setting? {
        didSet{
            titleName.text = setting?.name
            
            if let imageOK = setting?.image {
                image.image = UIImage(named: imageOK)?.withRenderingMode(.alwaysTemplate)
                image.tintColor = UIColor.darkGray
            
            }
        }
        
    }
    

}
