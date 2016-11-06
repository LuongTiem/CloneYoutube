//
//  CellDetailVideoRow3.swift
//  Youtube
//
//  Created by ReasonAmu on 11/6/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class CellDetailVideoRow3: UITableViewCell {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnMore(_ sender: UIButton) {
        
        print("More")
    }
    @IBOutlet weak var totalVideo: UILabel!
    @IBOutlet weak var channelSmallVideo: UILabel!
    @IBOutlet weak var titleSmallVideo: UILabel!
    @IBOutlet weak var imgSmallVideo: UIImageView!
    
    
    var setupSmallVideo : SmallVideo?{
        didSet{
            titleSmallVideo.text = setupSmallVideo?.titleVideo
            channelSmallVideo.text = setupSmallVideo?.channelVideo
//            imgSmallVideo.image = UIImage(named: (setupSmallVideo?.imageVideo)!)
            if let numberVideo = setupSmallVideo?.totalVideo {
                totalVideo.text = "\(numberVideo) videos."
            }
            
            
            let stringURL = setupSmallVideo?.imageVideo
            let url = URL(string: stringURL!)!
            imgSmallVideo.kf.setImage(with: url , options: [.transition(.fade(0.5))] )
        }
    }

 
}
