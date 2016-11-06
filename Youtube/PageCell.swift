//
//  PageCell.swift
//  Youtube
//
//  Created by ReasonAmu on 11/2/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let cellPage = "cellPage"
    @IBOutlet weak var pageLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var homeControllerPush : HomeController?
    
    var listVideoHome = [Video]()
    var videos : [Video]? {
        didSet{
            
            listVideoHome = videos!
            pageCollectionView.reloadData()
            setupViews()
        }
    }
    
    func setupViews (){
        pageCollectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: cellPage)
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.prefetchDataSource = self
    }
    
}


extension PageCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let stringThumnail = listVideoHome[indexPath.item].thumbnailImageName
        let urlThumnail =  URL(string: stringThumnail!)!
        (cell as! HomeCell).thumbnailImageView.kf.setImage(with: urlThumnail, options: [.transition(.fade(0.5))])
        
        
        let stringProfile = (listVideoHome[indexPath.item].channel)?.profileImage
        let urlProfile = URL(string: stringProfile!)!
        (cell as! HomeCell).userProfileImageView.kf.setImage(with: urlProfile, placeholder: nil,options : [.transition(.fade(0.5))])
        
        
        (cell as! HomeCell).video = listVideoHome[indexPath.item]
        
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        (cell as! HomeCell).thumbnailImageView.kf.cancelDownloadTask()
        (cell as! HomeCell).userProfileImageView.kf.cancelDownloadTask()
    }
    
    //--
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (frame.width - 32) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeControllerPush?.presentView(index: indexPath.row)
     
    }
    
}


extension PageCell : UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return listVideoHome.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellPage, for: indexPath) as! HomeCell
        cell.thumbnailImageView.kf.indicatorType = .activity
        cell.userProfileImageView.kf.indicatorType = .activity
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        
       
        
    }
    
    
}
