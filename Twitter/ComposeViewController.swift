//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Erica Lee on 2/28/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var textBox: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(sender: AnyObject) {

    }

    @IBAction func onCancel(sender: AnyObject) {
 
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
