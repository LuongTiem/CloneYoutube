//
//  ManagerData.swift
//  Youtube
//
//  Created by ReasonAmu on 11/1/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire

class ManagerData {
    
    static let LINKHOME = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
    static let LINKTRENDING = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
    static let LINKSUBSCRIPTIONS = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"

    
    static let shareInstance = ManagerData()
    
    private  init() {
        
    }
    
    
    //-- HOME
    func getDataHome(completion : @escaping ([Video])-> ()){
        let url = URL(string: ManagerData.LINKHOME)!
        var listVideoHome = [Video]()
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? [AnyObject] {
                
                for element in json {
                    
                    let catElement = element as? [String : AnyObject]
                    let video = Video.init(json: catElement!)
                    listVideoHome.append(video!)
                   
                }
                 completion(listVideoHome)
            }
        }
    }
    
    //-- TRANDING
    func getDataTrending(completion : @escaping ([Video])-> ()){
        let url = URL(string: ManagerData.LINKTRENDING)!
        var listVideoHome = [Video]()
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? [AnyObject] {
                
                for element in json {
                    
                    let catElement = element as? [String : AnyObject]
                    let video = Video.init(json: catElement!)
                    listVideoHome.append(video!)
                    
                }
                completion(listVideoHome)
            }
        }
    }
    
    //-- SUBCRIPTION
    func getDataSubscription(completion : @escaping ([Video])-> ()){
        let url = URL(string: ManagerData.LINKSUBSCRIPTIONS)!
        var listVideoHome = [Video]()
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? [AnyObject] {
                
                for element in json {
                    
                    let catElement = element as? [String : AnyObject]
                    let video = Video.init(json: catElement!)
                    listVideoHome.append(video!)
                    
                }
                completion(listVideoHome)
            }
        }
    }
    
}
