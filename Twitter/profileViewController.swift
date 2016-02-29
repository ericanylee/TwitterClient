//
//  profileViewController.swift
//  Twitter
//
//  Created by Erica Lee on 2/28/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var user : User?
    var tweets: [Tweet]?
    var screenNameVar: String?
  //  var ScreenNameVar: String?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenNameVar = user!.screenname as! String
        let parameters: NSDictionary = ["screen_name": screenNameVar!]

        TwitterClient.sharedInstance.userTimeLine(parameters, success: { (tweets: [Tweet]) -> () in
            var index = 0
            for tweet in tweets {
                if index != 0 {
                    self.tweets?.append(tweet)
                }
                index = index + 1
            }
            self.tableView.reloadData()
            },failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
            if user == nil {
                user = User.currentUser
        }

        //print(tweets)
        userName.text = user?.name as! String
        screenName.text = user?.screenname as! String
        location.text = user?.location as! String
        tweetsCount.text = user!.numTweets?.description
        followersCount.text = user!.numFollowers?.description
        followingCount.text = user!.numFollowing?.description
        userName.sizeToFit()
        screenName.sizeToFit()
        location.sizeToFit()
        tweetsCount.sizeToFit()
        followersCount.sizeToFit()
        followingCount.sizeToFit()
        
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! profileCell

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        /*if tweets != nil{
            return tweets!.count
        }
        else {*/
            return 5
       // }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
