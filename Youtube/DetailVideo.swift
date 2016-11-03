//
//  DetailVideo.swift
//  Youtube
//
//  Created by ReasonAmu on 11/2/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import AVFoundation

class DetailVideo: UIViewController {
    @IBOutlet weak var viewVideo: UIView!
    
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
 
    
    
    let cellDetail = "cellDetail"
    var playerLayer: AVPlayerLayer!
    var player: AVPlayer?
    
    var buttonDissMiss: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewVideo()
        setupTableView()
        
        
    }
    
    
    //MARK: SETUP VIEW VIDEO
    
    func setupViewVideo () {
        
        UIApplication.shared.isStatusBarHidden = true
        indicatorLoading.startAnimating()
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelDissMiss))
        swipeDownGesture.direction = .down
        viewVideo.addGestureRecognizer(swipeDownGesture)
        //--
        
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.viewVideo.frame
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.viewVideo.layer.addSublayer(playerLayer)
            
            
            //-- add Button
            buttonDissMiss.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            self.viewVideo.addSubview(buttonDissMiss)
            buttonDissMiss.addTarget(self, action: #selector(handelDissMiss), for: .touchUpInside)
            
            player?.play()
            
        }
        
        
        
        
        
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isLandscape {
            
            if let window = UIApplication.shared.keyWindow {
                
                self.tableview.isHidden = true
                self.viewVideo.frame = window.frame
                self.indicatorLoading.updateFocusIfNeeded()
                self.playerLayer.frame = viewVideo.frame
                self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                
                print("Nam Ngang")
                
            }
            
            
        }else {
            self.playerLayer.frame = viewVideo.frame
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.tableview.isHidden = false
        }
    }
    
    
    //MARK: SETUP TABLEVIEW
    func setupTableView() {
        
        tableview.register( UINib(nibName: "CellDetailVideo", bundle: nil), forCellReuseIdentifier: cellDetail)
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    
    
    func handelDissMiss(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}


extension DetailVideo : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    
}

extension DetailVideo : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDetail, for: indexPath) as! CellDetailVideo
        cell.backgroundColor = UIColor.red
        return cell
    }
}




