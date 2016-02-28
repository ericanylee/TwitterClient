//
//  detailsViewController.swift
//  Twitter
//
//  Created by Erica Lee on 2/23/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {

    var tweet : Tweet?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var favorites: UILabel!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWithURL(tweet!.profileImageURL!)
        profileImage.layer.cornerRadius = 5 // make image rounder
        profileImage.clipsToBounds = true //clip to bitmap

        userName.text = tweet!.userName
        screenName.text = "@\(tweet!.userScreenName!)"
        tweetContent.text = tweet!.text
        //for time stamp, format it differently
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy, HH:mm"
        timeStamp.text = formatter.stringFromDate(tweet!.timeStamp!)
        retweets.text = tweet!.retweetCount!.description
        favorites.text = tweet!.favoritesCount!.description
  
        if tweet!.favorited! {
            favoriteBtn.setImage(UIImage(named: "favorited.png"), forState: .Normal)
        }
        else {
            favoriteBtn.setImage(UIImage(named: "unfavorited.png"), forState: .Normal)
        }
        
        if tweet!.retweeted!{
            retweetBtn.setImage(UIImage(named: "retweeted.png"), forState: .Normal)
        }
        else {
            retweetBtn.setImage(UIImage(named: "defaultretweet.png"), forState: .Normal)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetTapped(sender: AnyObject) {
    
    
    }
    
    @IBAction func favoriteTapped(sender: AnyObject) {

    
    }
    

    @IBAction func replyTapped(sender: AnyObject) {
  
    
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
