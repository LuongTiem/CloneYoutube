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
    
    
    var smallVideo: [SmallVideo]?
    
    var requestVideo: Video?
    
    let cellDetail = "cellDetail"
    let cellChannel = "cellChannel"
    let cellVideo = "cellVideo"
    var playerLayer: AVPlayerLayer!
    var player: AVPlayer?
    var isPlaying:Bool = false
    lazy var buttonDissMiss: UIButton = {
        let btndissmiss = UIButton()
        btndissmiss.translatesAutoresizingMaskIntoConstraints = false
        btndissmiss.setImage( #imageLiteral(resourceName: "cancel"), for: .normal)
        btndissmiss.addTarget(self, action: #selector(handelDissMiss), for: .touchUpInside)
        return btndissmiss
    }()
    
    lazy var pausePlayBtn: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "pause")
        iv.tintColor = UIColor.white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var sliderVideo : UISlider = {
        let slider  = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor =  UIColor.red
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var labelVideoDuration : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints  = false
        lb.text = "00.00"
        lb.textColor = UIColor.white
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .right
        return lb
    }()
    
    lazy var labelVideoCurrentTime : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints  = false
        lb.text = "00.00"
        lb.textColor = UIColor.white
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textAlignment = .left
        return lb
    }()
    
    func handleSlider(){
        
        if let duration = player?.currentItem?.duration {
            
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(sliderVideo.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (finish) in
                
            })
        }
    }
    
    func handlePausePlay(){
        
        if player?.status == AVPlayerStatus.readyToPlay {
            if isPlaying {
                pausePlayBtn.image = #imageLiteral(resourceName: "play")
                pausePlayBtn.isHidden = false
                player?.pause()
                
                
            }else{
                player?.play()
                pausePlayBtn.isHidden = true
                
            }
            
            isPlaying = !isPlaying
        }else{
            print("Tap Video")
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        setupViewVideo(urlString: urlString)
        setupTableView()
        
        
    }
    
    func setupNotification(){
        
    }
    
    //MARK: SETUP VIEW VIDEO
    
    func setupViewVideo (urlString : String) {
        
        UIApplication.shared.isStatusBarHidden = true
        indicatorLoading.startAnimating()
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelDissMiss))
        swipeDownGesture.direction = .down
        let tapGestureVideo = UITapGestureRecognizer(target: self, action: #selector(handlePausePlay))
        tapGestureVideo.numberOfTapsRequired = 1
        viewVideo.addGestureRecognizer(tapGestureVideo)
        viewVideo.addGestureRecognizer(swipeDownGesture)
        //--
        
        
        if let url = URL(string: urlString) {
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.setupAVPlayer(view: self.viewVideo)
            
            
            //-- add button DissMiss
            viewVideo.addSubview(buttonDissMiss)
            buttonDissMiss.leftAnchor.constraint(equalTo: viewVideo.leftAnchor).isActive = true
            buttonDissMiss.topAnchor.constraint(equalTo: viewVideo.topAnchor).isActive = true
            buttonDissMiss.widthAnchor.constraint(equalToConstant: 30).isActive = true
            buttonDissMiss.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            
            //-- add label
            viewVideo.addSubview(labelVideoDuration)
            labelVideoDuration.rightAnchor.constraint(equalTo: viewVideo.rightAnchor, constant: -8).isActive = true
            labelVideoDuration.bottomAnchor.constraint(equalTo: viewVideo.bottomAnchor).isActive = true
            labelVideoDuration.widthAnchor.constraint(equalToConstant: 60).isActive = true
            labelVideoDuration.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            viewVideo.addSubview(labelVideoCurrentTime)
            labelVideoCurrentTime.leftAnchor.constraint(equalTo: viewVideo.leftAnchor, constant: 8).isActive = true
            labelVideoCurrentTime.bottomAnchor.constraint(equalTo: viewVideo.bottomAnchor, constant : -2).isActive = true
            labelVideoCurrentTime.widthAnchor.constraint(equalToConstant: 50).isActive = true
            labelVideoCurrentTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            
            //-- add slider
            viewVideo.addSubview(sliderVideo)
            sliderVideo.rightAnchor.constraint(equalTo: labelVideoDuration.leftAnchor).isActive = true
            sliderVideo.bottomAnchor.constraint(equalTo: viewVideo.bottomAnchor).isActive = true
            sliderVideo.leftAnchor.constraint(equalTo: labelVideoCurrentTime.rightAnchor).isActive = true
            sliderVideo.heightAnchor.constraint(equalToConstant: 30).isActive  = true
            
            //-- add buton Pause -- Play
            viewVideo.addSubview(pausePlayBtn)
            pausePlayBtn.centerXAnchor.constraint(equalTo: viewVideo.centerXAnchor).isActive = true
            pausePlayBtn.centerYAnchor.constraint(equalTo: viewVideo.centerYAnchor).isActive = true
            pausePlayBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            pausePlayBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            pausePlayBtn.isHidden = true
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            isPlaying = true
            player?.play()
            
            
            //--
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                //Int(seconds.truncatingRemainder(dividingBy: 60))
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.labelVideoCurrentTime.text = "\(minutesString):\(secondsString)"
                
                //-- lets move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.sliderVideo.value = Float(seconds / durationSeconds)
                    
                }
            })
            
        }
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges" {
            
            indicatorLoading.stopAnimating()
            //            isPlaying = true
            //            player?.play()
            
            if let duration = player?.currentItem?.duration {
                
                let seconds = CMTimeGetSeconds(duration)
                let secondText = Int(seconds) % 60
                let minuteText = String(format: "%02d", Int(seconds) / 60)
                labelVideoDuration.text = "\(minuteText):\(secondText)"
            }
            
        }
    }
    
    
    
    
    
    
    
    //MARK: SETUP TABLEVIEW
    func setupTableView() {
        
        tableview.register( UINib(nibName: "CellDetailVideo", bundle: nil), forCellReuseIdentifier: cellDetail)
        tableview.register( UINib(nibName: "CellDetailVideoRow2", bundle: nil) ,forCellReuseIdentifier: cellChannel)
        tableview.register( UINib(nibName: "CellDetailVideoRow3", bundle: nil) ,forCellReuseIdentifier: cellVideo)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = UITableViewAutomaticDimension
        
        
        //--
        smallVideo =  {
            return [ SmallVideo(title: "John Legend - All Of Me", channel: "JohnTheLegend", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/john_legend_all_of_me.jpg", totalVideo: 123),
                     SmallVideo(title: "Rebecca Black - Friday", channel: "Rebecca Black's Awesome", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_work.jpg", totalVideo: 676),
                     SmallVideo(title: "Kanye Interrupts Taylor Embarrassing Video", channel: "KanyeLover", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye-interupts-taylor-zoom.jpg", totalVideo:590),
                     SmallVideo(title: "Beyonce - Put A Ring On It", channel: "Taylor Fan Forever", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_put_a_ring_on_it.jpg", totalVideo: 312),
                     SmallVideo(title: "Rihanna Work featuring Drake", channel: "Rihanna's Channel", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_work.jpg", totalVideo: 572),
                     SmallVideo(title: "Taylor Swift - I Knew You Were Trouble (Exclusive)", channel: "Taylor Fan Forever", image: "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg", totalVideo: 1074)
                
                
            ]
        }()
        
    }
    
    
    
    
    
    func handelDissMiss(){
        
        player?.seek(to: kCMTimeZero)
        player?.pause()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}


extension DetailVideo : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = smallVideo?.count {
            return count + 2
        }
        
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
}

extension DetailVideo : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: cellDetail, for: indexPath) as! CellDetailVideo
            cell1.channelVideo  = requestVideo
            cell1.selectionStyle = .none
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cellChannel, for: indexPath) as! CellDetailVideoRow2
            cell2.selectionStyle = .none
            cell2.setupChannel = requestVideo?.channel
            return cell2
            
        default:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: cellVideo, for: indexPath) as! CellDetailVideoRow3
            cell3.setupSmallVideo = smallVideo?[indexPath.row - 2]
            
            return cell3
        }
        
        
    }
}




