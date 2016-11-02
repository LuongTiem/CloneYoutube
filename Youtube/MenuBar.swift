//
//  MenuBar.swift
//  Youtube
//
//  Created by ReasonAmu on 10/31/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class MenuBar: UIView,UICollectionViewDataSource {
    
    let cellMenu = "CellMenu"
    @IBOutlet weak var layoutMenu: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewMenu: UICollectionView!
   
    
    
    let imageNames = ["home", "trending", "subscriptions", "account"]
    var homeController : HomeController?
    
    
    
    var horizontalBarLeftAuchorContraint : NSLayoutConstraint?
    
    func setupViews(){
        //-- init thanh truot
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAuchorContraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAuchorContraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        
        
        //--
        collectionViewMenu.backgroundColor = UIColor.rgb(red : 230, green: 32, blue: 31)
        layoutMenu.invalidateLayout()
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        layoutMenu.scrollDirection = .horizontal
       
        collectionViewMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: cellMenu)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionViewMenu.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMenu, for: indexPath) as! MenuCell
        cell.imageViews.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
   
    
}




extension MenuBar : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//         let x = CGFloat(indexPath.item) * frame.width / 4
//        horizontalBarLeftAuchorContraint?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//            
//        }, completion: nil)
        
        if homeController == nil {
            print(" NIL ")
        }
        
       homeController?.scrollToIndexMenu(menuIndex: indexPath.item)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width/4, height: frame.height)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    
}
