//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by ReasonAmu on 11/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    
    var homeController : HomeController?
    let cellHeight : CGFloat = 50
    let cellID = "CellSetting"
    
    
    override init() {
        super.init()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UINib(nibName: "CellSetting", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        
    }
    
    
    
    let setting : [Setting] = {
 
        return [Setting(name: SettingName.Settings.rawValue, image:  SettingImage.settings.rawValue)!,
                Setting(name: SettingName.TermsPrivacy.rawValue, image: SettingImage.termsPrivacy.rawValue)!,
                Setting(name: SettingName.SendFeedback.rawValue, image:SettingImage.sendFeedback.rawValue)!,
                Setting(name: SettingName.Help.rawValue, image: SettingImage.help.rawValue)!,
                Setting(name: SettingName.SwitchAccount.rawValue, image: SettingImage.switchAccount.rawValue)!,
                Setting(name: SettingName.Cancel.rawValue, image: SettingImage.cancel.rawValue)!]
        
    }()
    
    
    
    let blackView = UIView()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        
        
    }()
    
    let tableview  : UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.backgroundColor = UIColor.white
        return tb
        
    }()
    
    //-- show Menu
    func showSetting(){
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
            let height: CGFloat = CGFloat(setting.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            
            
            
            self.blackView.frame  = window.frame
            self.blackView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
                
            }, completion: nil)
            
        }
        
    }
    
    func tapGesture(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
            
        }, completion: nil)
        
    }
    
    func handleDissMiss(_ setting: Setting){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }, completion: { (Bool) in
            
            if (setting.name != SettingName.Cancel.rawValue ){
                
                self.homeController?.showControllerForSetting(setting: setting)
            }
          
        })
    }
    
}



extension SettingsLauncher : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.setting[indexPath.item]
        handleDissMiss( setting)
    }
    
    
    
}


extension SettingsLauncher : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CellSetting
        cell.setting = setting[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setting.count
    }
    
}
