//
//  tweetCell.swift
//  Twitter
//
//  Created by Erica Lee on 2/21/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    var viewController: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 5 // make image rounder
        profileImageView.clipsToBounds = true //clip to bitmap
        loadGestureRecognizer()
    }

    func loadGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "profileTapped")
        profileImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func profileTapped() {
        viewController?.performSegueWithIdentifier("profilePage", sender: tweet?.user)
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
/*
    func loadGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "onProfileImage")
        profileImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func onProfile() {
        viewController?.performSegueWithIdentifier("profilePage", sender: tweet?.user)
    }
    */
    @IBAction func favoriteOnButton(sender: AnyObject) {
        if tweet!.favorited!{// if it was already favorited, clicking on it is unfavoriting it..
            TwitterClient.sharedInstance.unfavorite(withID: tweet!.id!, complete: { (response, error) -> Void in
                self.tweet?.favoritesCount = self.tweet!.favoritesCount!.integerValue - 1
                self.favoritesLabel.text = self.tweet?.favoritesCount!.description
                self.tweet?.favorited = false
                self.favoriteButton.setImage(UIImage(named: "unfavorited.png"), forState: .Normal)
                
            })
        } else { //favoring action
            TwitterClient.sharedInstance.favorite(withID: tweet!.id!, complete: { (response, error) -> Void in
                self.tweet?.favoritesCount = self.tweet!.favoritesCount!.integerValue + 1
                self.favoritesLabel.text = self.tweet?.favoritesCount?.description
                self.tweet?.favorited = true
                self.favoriteButton.setImage(UIImage(named: "favorited.png"), forState: .Normal)

            })
        }
    }

    @IBAction func retweetOnButton(sender: AnyObject) {
        
        if tweet!.retweeted!{// if it was already retweeted, clicking on it is unretweeting it..
            TwitterClient.sharedInstance.unretweet(withID: tweet!.id!, complete: { (response, error) -> Void in
                self.tweet?.retweetCount = self.tweet!.retweetCount!.integerValue - 1
                self.retweetsLabel.text = self.tweet?.retweetCount!.description
                self.tweet?.retweeted = false
                self.retweetButton.setImage(UIImage(named: "defaultretweet.png"), forState: .Normal)
            })
        } else { //retweeting action
            TwitterClient.sharedInstance.retweet(withID: tweet!.id!, complete: { (response, error) -> Void in
                self.tweet?.retweetCount = self.tweet!.retweetCount!.integerValue + 1
                self.retweetsLabel.text = self.tweet?.retweetCount!.description
                self.tweet?.retweeted = true
                self.retweetButton.setImage(UIImage(named: "retweeted.png"), forState: .Normal)
            })
        }
    }
}
