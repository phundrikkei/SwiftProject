//
//  WalkThroughContentViewController.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/25/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import UIKit

class WalkThroughContentViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardVButton: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
        contentLabel.text = content
        
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardVButton.setTitle("Next", forState: .Normal)
        case 2: forwardVButton.setTitle("Done", forState: .Normal)
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parentViewController as! WalkThroughPageViewController
            pageViewController.forward(index)
        case 2:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "hasViewWalkingThrough")
            
            dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
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
