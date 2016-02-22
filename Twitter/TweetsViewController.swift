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
            //for tweet in tweets{
            //    print(tweet.text)
            //}
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
        let formatter = NSDateFormatter()
        cell.timeLabel.text = formatter.stringFromDate(tweet.timeStamp!)
        cell.tweetTextLabel.text = tweet.text
        let profileUrlString = tweet.profileImageURL as? String // can be a nil
        if let profileUrlString = profileUrlString{
            cell.profileImageView.setImageWithURL(NSURL(string: profileUrlString)!)
        }
        else {
            cell.profileImageView.image = nil
        }
        print(tweet.userName)
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
