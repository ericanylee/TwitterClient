//
//  User.swift
//  Twitter
//
//  Created by Erica Lee on 2/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString? //optional : can potentially be blank
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    //deserialization code. takes dictionary and selectively populating the properties
    init(dictionary: NSDictionary){//initializer... when u create a user u initialize it. Constructor!
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
}
