//
//  ListViewController.swift
//  PagingMenuDemo
//
//  Created by PhuND on 5/4/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

//    var textLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        textLabel.center = view.center
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(24)
        textLabel.text = "View Controller 1"
        view.addSubview(textLabel)
        
        print("abvc")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
