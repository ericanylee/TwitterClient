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
    var favorites = 1
    var retweets = 1
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            //for tweet in tweets{
            //    print(tweet.text)
            //}
            
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
        
        cell.userNameLabel.text = tweet.userName
        cell.userScreenNameLabel.text = tweet.userScreenName
        cell.timeLabel.text = String(tweet.timeStamp!)
        cell.tweetTextLabel.text = tweet.text
        //let profileUrlString = tweet.profileImageURL as? String // can be a nil
        //if let profileUrlString = profileUrlString{
            cell.profileImageView.setImageWithURL(tweet.profileImageURL!)
        //}
        //else {
            //cell.profileImageView.image = nil
        //}
        cell.favoritesLabel.text = "\(tweet.favoritesCount)"
        cell.retweetsLabel.text = "\(tweet.retweetCount)"
        //cell.favoritesImageView.image = UIImage(named: "DefaultFavorite")
       // cell.retweetsImageView.image = UIImage(named: "DefaultRetweet")
        //cell.favoritesImageView.frame = CGRectMake(0,0,100,100)
       // cell.retweetsImageView.frame = CGRectMake(0,0,100,100)
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavoriteButton(sender: UIButton) {
        tableView.reloadData()
    }

    @IBAction func onRetweetButton(sender: AnyObject) {
        tableView.reloadData()
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
