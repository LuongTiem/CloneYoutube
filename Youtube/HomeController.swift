//
//  ViewController.swift
//  Youtube
//
//  Created by ReasonAmu on 10/31/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher


class HomeController: UIViewController {
    
    let cellID = "Cell"
    var listVideoHome = [Video]()
    var listTranding = [Video]()
    var listSubcription = [Video]()
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    @IBOutlet weak var menuBar: MenuBar!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         //--C1 : an navigationBar
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
         
         */
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        let titleViews = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleViews.text = "Home"
        titleViews.textColor = UIColor.white
        titleViews.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleViews
        

        collectionView.delegate = self
        collectionView.dataSource  = self
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.hidesBarsOnSwipe = true
        
        setupNavigationBar()
        setupMenuBar()
        setupCollectionViews()
        loadData()
        
    }
    //MARK: LOAD DATA 
    func loadData(){
        
        ManagerData.shareInstance.getDataHome { (result) in
            
            self.listVideoHome = result
            self.collectionView.reloadData()
        }
        
        ManagerData.shareInstance.getDataTrending{ (result) in
            
            self.listTranding = result
            self.collectionView.reloadData()
        }
        
        ManagerData.shareInstance.getDataSubscription { (result) in
            
            self.listSubcription = result
            self.collectionView.reloadData()
        }
        
    }
    
    
    //MARK:  SETUP NAVIGATIONBAR - MENU BAR
    func setupNavigationBar(){
        
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
        let searchBarItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handelSearch))
        
        let moreImage = #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal)
        let moreBarItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarItem,searchBarItem]
    }
    
    //-- init menuBar
    func setupMenuBar(){
        menuBar.homeController = self
        DispatchQueue.main.async {
            self.menuBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
            self.menuBar.setupViews()
        }
        
    }
    
    //-- scroll tu menubar
    func scrollToIndexMenu(menuIndex : Int){
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setTitleForMenu(menuIndex: menuIndex)
    }
    
    
    //-- set title
    private func setTitleForMenu(menuIndex : Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[menuIndex])"
        }
    }
    
    
    //-- itembar Search
    func handelSearch() {
        scrollToIndexMenu(menuIndex: 0)
    }
    
    //- itembar More
    func handleMore(){
        
        settingLauncher.showSetting()
    }
    
    
    
    //MARK: SETTINGS MENU
    lazy var settingLauncher : SettingsLauncher  = {
        let setting =  SettingsLauncher()
        setting.homeController = self
        return setting
    }()
    
    
    
    //-- push viewVC
    func showControllerForSetting(setting : Setting){
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailSettings
        navigationController?.navigationBar.tintColor = UIColor.white //-- navi
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        detail.title = setting.name
        
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
    
    //MARK: SETUP COLLECTIONVIEWCELL
    func setupCollectionViews(){
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.register( UINib(nibName: "PageCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.isPagingEnabled = true
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeftAuchorContraint?.constant = scrollView.contentOffset.x/4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath  =  IndexPath(item: Int(index), section: 0)
        menuBar.collectionViewMenu.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        setTitleForMenu(menuIndex: Int(index))
    }
    
    
    func presentView(){
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "detailVideo") as! DetailVideo
        self.present(detail, animated: true, completion: nil)
    }
    
    //MARK: UPDATE VIEW
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout.invalidateLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.menuBar.layoutMenu.invalidateLayout()
        self.collectionView.collectionViewLayout.invalidateLayout()
        
        
    }
    
}




extension HomeController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    
    
}


extension HomeController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
            cell.homeControllerPush = self
        switch indexPath.item {
        case 0:
            cell.videos = listVideoHome
        case 1:
            cell.videos = listTranding
        case 2 :
            cell.videos = listSubcription
        default:
            cell.videos = listVideoHome
        }
        return cell
    }
   
    
}


