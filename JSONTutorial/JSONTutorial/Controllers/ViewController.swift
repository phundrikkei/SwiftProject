//
//  ViewController.swift
//  JSONTutorial
//
//  Created by Hoang NA on 3/10/16.
//  Copyright (c) 2016 HNA Studios, Ltd. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet var resultText: UITextView!
    @IBOutlet var btnGet:UIButton!
    @IBOutlet var urlField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultText.text = "sdfsdfsdsdf sdfsdf "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getUrl(){
        if(urlField.text != nil){
            let dataString = String(data: getHtml(urlField.text!), encoding: NSUTF8StringEncoding)
            resultText.text = dataString
        }
    }
    
    func getHtml(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }


}

