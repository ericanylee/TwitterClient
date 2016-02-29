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

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    
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
        userName.text = User._currentUser!.name as! String
        let imageUrl = User._currentUser?.profileUrl
        if let imageUrl = imageUrl {
            profileImage.setImageWithURL(imageUrl)
        }
        else{
            profileImage = nil
        }

        screenName.text = User._currentUser!.screenname as! String
        numTweets.text = User._currentUser!.numTweets?.description
        numFollowers.text = User._currentUser!.numFollowers?.description
        numFollowing.text = User._currentUser!.numFollowing?.description
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil{
            return tweets!.count
        }
        else {
            return 0
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let tweet = tweets![indexPath.row]
        performSegueWithIdentifier("detailsPage", sender: tweet)

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
        if hours <= 24 {
            cell.timeLabel.text = "\(hours)h"
        }
        else { //have to format it to days
            let days = hours / 24
            cell.timeLabel.text = "\(days)d"
        }
        
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


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)

        if segue.identifier == "detailsPage" {
            let detailViewController = segue.destinationViewController as! detailsViewController
            /*let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]*/
            //print(sender)
            detailViewController.tweet = sender as? Tweet

        } else if segue.identifier == "profilePage" {
            let detailViewController = segue.destinationViewController as! profileViewController
            detailViewController.user = sender as? User
        }
    }
    


}
