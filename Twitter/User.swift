//
//  User.swift
//  Twitter
//
//  Created by Erica Lee on 2/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class User: NSObject {

    //these are called stored properties, space allocated for them
    var name: NSString? //optional : can potentially be blank
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    //deserialization code. takes dictionary and selectively populating the properties
    init(dictionary: NSDictionary){//initializer... when u create a user u initialize it. Constructor!
        self.dictionary = dictionary
        name = dictionary["name"] as? String // attempt to cast it as a string
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String // can be a nil
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }
        else {
            profileUrl = nil
        }
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    //computed property, needs getter
    class var currentUser: User?{//may or may not exist
        get{//runs when someone tries to access this property
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
            if let userData = userData{
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
            }
            return _currentUser
        }

        set (user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: []) //[] default options
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
        
    }

}
