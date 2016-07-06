//
//  ViewController.swift
//  BubleView
//
//  Created by PhuND on 6/23/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: BubleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
//        myView = BubleView(withColor: CGRectMake(0, 0, 200, 200), color: UIColor.redColor())
    }


}

