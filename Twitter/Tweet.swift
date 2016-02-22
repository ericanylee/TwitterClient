//
//  Tweet.swift
//  Twitter
//
//  Created by Erica Lee on 2/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount : Int = 0
    var user: NSDictionary!
    var userName: String?
    var userScreenName: String?
    var profileImageURL: NSURL?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0 // if exists use as Int, if the key doesnt exist use 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = (dictionary["created_at"] as? String)
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timestampString)
        }
        
        user = dictionary["user"] as? NSDictionary
        userName = user["name"] as? String
        userScreenName = user["screen_name"] as? String
        let profileUrlString = user["profile_image_url_https"] as? String // can be a nil
        if let profileUrlString = profileUrlString{
            profileImageURL = NSURL(string: profileUrlString)
        }
        else {
            profileImageURL = nil
        }

    }
    //this function returns array of tweets
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]() // swift style dictionry
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}
