//
//  CellDetailVideoRow2.swift
//  Youtube
//
//  Created by ReasonAmu on 11/6/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher
class CellDetailVideoRow2: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnRegister.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        btnRegister.setTitle("Register", for: .normal)
        imageChannel?.layer.cornerRadius = 30
        imageChannel?.layer.masksToBounds  = true
     
       
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var titleChannel: UILabel!
    @IBOutlet weak var imageChannel: UIImageView!
    
    

    var setupChannel : Channel?{
        didSet{
//            imageView?.image = UIImage(named: (setupChannel?.channel?.profileImage)!)
            let urlString = setupChannel?.profileImage
            let url = URL(string: urlString!)!
            imageChannel?.kf.setImage(with:url , options: [.transition(.fade(0.5))])
            titleChannel.text = setupChannel?.name
        }
    }
    
    
    
    
    
    func handleRegister(){
        print("Register")
        
    }
}
