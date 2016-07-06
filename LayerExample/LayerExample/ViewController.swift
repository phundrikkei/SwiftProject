//
//  ViewController.swift
//  LayerExample
//
//  Created by PhuND on 7/1/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewLayer: UIView!
    
    var l : CALayer {
        return viewLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLayer(){
        l.backgroundColor = UIColor(red: 11/255.0, green: 86/255.0, blue: 14/255.0, alpha: 1.0).CGColor
        l.borderWidth = 12.0
        l.borderColor = UIColor.whiteColor().CGColor
        l.cornerRadius = 100.0
        
        l.shadowOpacity = 0.7
        l.shadowRadius = 3.0
        l.shadowOffset = CGSize(width: 0, height: 3)
        
        l.contents = UIImage(named: "star")?.CGImage
        l.contentsGravity = kCAGravityCenter
        
//        l.magnificationFilter = kCAFilterLinear
//        l.geometryFlipped = false
        
        l.masksToBounds = false
    }
}

