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
    var retweeted : BooleanType = false
    var favorited : BooleanType = false
    var retweet : Int!
    var favorite : Int!
    
    var tweet: Tweet! {
        didSet {
            favorite = tweet.favoritesCount
            retweet = tweet.retweetCount
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 5 // make image rounder
        profileImageView.clipsToBounds = true //clip to bitmap
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favoriteOnButton(sender: AnyObject) {
        if favorited { //was already favorited
            favorited = false
            favoriteButton.setImage(UIImage(named: "unfavorited.png"), forState: UIControlState.Normal)
            favorite = favorite - 1
            favoritesLabel.text = "\(favorite)"
        }
        else { // favorited!
            favorited = true
            favoriteButton.setImage(UIImage(named: "favorited.png"), forState: UIControlState.Normal)
            favorite = favorite + 1
            favoritesLabel.text = "\(favorite)"
        }
    }

    @IBAction func retweetOnButton(sender: AnyObject) {
        if retweeted { //was already favorited
            retweeted = false
            retweetButton.setImage(UIImage(named: "defaultretweet.png"), forState: UIControlState.Normal)
            retweet = retweet - 1
            retweetsLabel.text = "\(retweet)"
        }
        else { // favorited!
            retweeted = true
            retweetButton.setImage(UIImage(named: "retweeted.png"), forState: UIControlState.Normal)
            retweet = retweet + 1
            retweetsLabel.text = "\(retweet)"
        }
    }
    
}
