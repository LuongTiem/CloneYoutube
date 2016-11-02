//
//  HomeCell.swift
//  Youtube
//
//  Created by ReasonAmu on 10/31/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var subtitleTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    
    var video : Video? {
        didSet{
            
            titleLabel.text = video?.title
            
            if let channelName = video?.channel?.name,let numberViews = video?.numberViews {
                
                let castNumber = NumberFormatter()
                 castNumber.numberStyle = .decimal
                let resultSubtitle = "\(channelName) * \(castNumber.string(from: numberViews)!) • 2 years ago "
                subtitleTextView.text = resultSubtitle
                subtitleTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
                subtitleTextView.textColor = UIColor.lightGray
                subtitleTextView.translatesAutoresizingMaskIntoConstraints = false
            }
            
        }
        
        
    }
    
    func setupViews(){
        
        thumbnailImageView.image = #imageLiteral(resourceName: "taylor_swift_bad_blood")
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        
        userProfileImageView.image = #imageLiteral(resourceName: "taylor_swift_profile")
       
        
        
        titleLabel.text = "Taylor Swift - Blank Space"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleTextView.text =  "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        subtitleTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        subtitleTextView.textColor = UIColor.lightGray
        subtitleTextView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
