//
//  TwitterClient.swift
//  Twitter
//
//  Created by Erica Lee on 2/16/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
        
    //static is the same as class, except it won't be overwritten
    static var sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"),
        consumerKey: "uaQWWvD1okO8wibdrXUuxEJC2",
        consumerSecret: "cew9xTmT25ylM0SzBGrm9KcGTUZqOqerLDFozHQ3nSAZYnGlMp")

    var loginSuccess: (() -> ())? // may or may not have log in success
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()){ //look up closure types and syntaxes later
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET",
            callbackURL: NSURL(string:"twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
                // when request token succeeds the following code gets executed
                //print("Got the request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!) //if you don't open https... it might open different app
                
                
            }) { (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error) // pass along the error received.. if log in failure is nil question mark is needed 
        }
    }
    
    func logout(){
        User.currentUser = nil
       deauthorize()
        //need to go back to the log in page
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
        
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                },
                failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Error! \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError)->()){

        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets) // on success, returns tweets 
            //tweets are array of NSDictionaries
            //for tweet in tweets{
            //print("\(tweet.text)!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    func userTimeLine(parameters: NSDictionary? ,success: ([Tweet]) -> (), failure: (NSError)->()) {
        
        
        GET("1.1/statuses/user_timeline.json", parameters: parameters, progress: { (progress: NSProgress) -> Void in
            }, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //print(response)
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
                failure(error)
        })
    }
    
    
    func currentAccount(success: (User) -> (), failure: (NSError)->()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }

    func retweet(withID id:NSNumber, complete: (response: NSDictionary?, error: NSError?) -> Void) {
        let parameter: NSDictionary = ["id": id]
        POST("1.1/statuses/retweet/\(id).json", parameters: parameter, progress: { (progress) -> Void in
            
            }, success: { (task, response) -> Void in
                complete(response: response as? NSDictionary, error: nil)
            }) { (task, error) -> Void in
                complete(response: nil, error: error)
        }
    }

    func unretweet(withID id:NSNumber, complete: (response: NSDictionary?, error: NSError?) -> Void) {
        let parameter: NSDictionary = ["id": id]
        POST("1.1/statuses/unretweet/\(id).json", parameters: parameter, progress: { (progress) -> Void in
            }, success: { (task, response) -> Void in
                complete(response: response as? NSDictionary, error: nil)
            }) { (task, error) -> Void in
                complete(response: nil, error: error)
        }
    }
    
    func favorite(withID id:NSNumber, complete: (response: NSDictionary?, error: NSError?) -> Void) {
        let parameter: NSDictionary = ["id": id]
        POST("1.1/favorites/create.json", parameters: parameter, progress: { (progress) -> Void in
            }, success: { (task, response) -> Void in
                complete(response: response as? NSDictionary, error: nil)
            }) { (task, error) -> Void in
                complete(response: nil, error: error)
        }
    }
    
    func unfavorite(withID id:NSNumber, complete: (response: NSDictionary?, error: NSError?) -> Void) {
        let parameter: NSDictionary = ["id": id]
        POST("1.1/favorites/destroy.json", parameters: parameter, progress: { (progress) -> Void in
            }, success: { (task, response) -> Void in
                complete(response: response as? NSDictionary, error: nil)
            }) { (task, error) -> Void in
                complete(response: nil, error: error)
        }
    }
    
    func postTweet(parameters:NSDictionary, complete: (response: NSDictionary?, error: NSError?) -> Void) {
        POST("1.1/statuses/update.json", parameters: parameters, progress: { (progress) -> Void in
            }, success: { (task, response) -> Void in
                complete(response: response as? NSDictionary, error: nil)
            }) { (task, error) -> Void in
                complete(response: nil, error: error)
                
        }
    }
    
}
