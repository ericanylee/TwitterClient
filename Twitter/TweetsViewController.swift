//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Erica Lee on 2/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil{
            return tweets!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! tweetCell
        let tweet = tweets[indexPath.row]
        let user = tweet.user
        cell.tweet = tweet
        cell.userNameLabel.text = tweet.userName
        cell.userScreenNameLabel.text = "@\(tweet.userScreenName!)"
        cell.timeLabel.text = String(tweet.timeStamp!)
        cell.profileImageView.setImageWithURL(tweet.profileImageURL!)
        cell.viewController = self
        cell.tweetTextLabel.text = tweet.text

        //calculate how many hours passed since timestamp from tweet
        let time = Int((tweet.timeStamp!.timeIntervalSinceNow))
        let hours = -time / 3600
        cell.timeLabel.text = "\(hours)h"
        
        if tweet.retweetCount == 0 {
            cell.retweetsLabel.text = ""
        } else {
            cell.retweetsLabel.text = tweet.retweetCount?.description
        }
        
        if tweet.favoritesCount == 0 {
            cell.favoritesLabel.text = ""
        } else {
            cell.favoritesLabel.text = tweet.favoritesCount?.description
        }

        if tweet.retweeted!{
            cell.retweetButton.setImage(UIImage(named: "retweeted.png"), forState: .Normal)
        }
        
        if tweet.favorited! {
            cell.favoriteButton.setImage(UIImage(named: "favorited.png"), forState: .Normal)
        }

        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogOutButon(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
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
