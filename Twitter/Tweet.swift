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
    var retweetCount: NSNumber?
    var favoritesCount : NSNumber?
    var user: User!
    var userName: String?
    var userScreenName: String?
    var profileImageURL: NSURL?
    var id: NSNumber?
    var retweeted: Bool?
    var favorited: Bool?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? NSNumber
        favoritesCount = dictionary["favorite_count"] as? NSNumber // THE API KEY HERE IS WRONG
        id = dictionary["id"] as? NSNumber
        /*let retweeted_status = dictionary["retweeted_status"]
        if let retweeted_status = retweeted_status as? NSDictionary {
            favoritesCount = retweeted_status["favourites_count"] as? NSNumber
            
        }
        */
        let timestampString = (dictionary["created_at"] as? String)
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timestampString)
        }
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        userName = user.name as? String
        userScreenName = user.screenname as? String
        let profileUrl = user.profileUrl as NSURL! // can be a nil
        if let profileUrl = profileUrl{
            profileImageURL = profileUrl
        }
        else {
            profileImageURL = nil
        }
        
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        
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
