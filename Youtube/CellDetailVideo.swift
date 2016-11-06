//
//  CellDetailVideo.swift
//  Youtube
//
//  Created by ReasonAmu on 11/2/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellDetailVideo: UITableViewCell {
    
    var checkLike : Bool = true
    var chekDislike : Bool = true
    var numberLike : Int = 1145
    var numberDislike : Int = 112
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnLike.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        btnDislike.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
    }
    
   
    
    
    var channelVideo : Video?{
        
        didSet{
            titleVideo.text = channelVideo?.title
            if let numberView = channelVideo?.numberViews {
                let castNumber = NumberFormatter()
                castNumber.numberStyle = .decimal
                view.text = "\(castNumber.string(from: numberView)!) views."
                
            }
            
            btnLike.setTitle("\(numberLike)", for: .normal)
            btnLike.imageView?.contentMode = .right
            
            btnDislike.setTitle("\(numberDislike) ", for: .normal)
            btnDislike.imageView?.contentMode = .right
            
        }
    }
    
    @IBAction func handleMore(_ sender: UIButton) {
        
        print("Show More")
    }
    
    @IBOutlet weak var titleVideo: UILabel!
    
    @IBAction func handleDownload(_ sender: UIButton) {
     
        DispatchQueue.main.async {
            sender.setImage(#imageLiteral(resourceName: "download").withRenderingMode(.alwaysTemplate), for: .normal)
        }
        print("DownLoad Loading .....")
    }
    
    func handleDislike(){
        
        if chekDislike == true {
            numberDislike = numberDislike + 1
            DispatchQueue.main.async {
                self.btnDislike.setTitle("\(self.numberDislike)", for: .normal)
                self.btnDislike.imageView?.image = #imageLiteral(resourceName: "dislike").withRenderingMode(.alwaysTemplate)
                
            }
        }else{
            numberDislike = numberDislike - 1
            DispatchQueue.main.async {
                self.btnDislike.setTitle("\(self.numberDislike)", for: .normal)
                self.btnDislike.imageView?.image = #imageLiteral(resourceName: "dislike")
                
            }
        }
        chekDislike = !chekDislike
      
        
    }
    
    func handleLike(){
        
        if checkLike == true {
            numberLike = numberLike + 1
            DispatchQueue.main.async {
                self.btnLike.imageView?.image = #imageLiteral(resourceName: "like").withRenderingMode(.alwaysTemplate)
                
            }
        }else{
            numberLike = numberLike - 1
            DispatchQueue.main.async {
                self.btnLike.imageView?.image = #imageLiteral(resourceName: "like")
                
            }
        }
        
        self.btnLike.setTitle("\(self.numberLike)", for: .normal)
        checkLike = !checkLike
  
        
    }
    
    @IBOutlet weak var btnDislike: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var view: UILabel!
    
    
}
