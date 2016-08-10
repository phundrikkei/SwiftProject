//
//  ViewController.swift
//  Story
//
//  Created by PhuND on 7/12/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! StoryCell
        cell.accessoryType = .DisclosureIndicator
        let checklistName = "abc 123"
        var checklistText = NSMutableAttributedString()
        checklistText = NSMutableAttributedString(string: "\(cell.storyName.text!),\(checklistName)")
        checklistText.addAttribute(NSFontAttributeName,
                                   value: UIFont(
                                    name: "Helvetica",
                                    size: 11.0)!,
                                   range: NSRange(location: cell.storyName.text!.characters.count, length: checklistName.characters.count))
        checklistText.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: cell.storyName.text!.characters.count, length: checklistName.characters.count+1))
        cell.storyName.attributedText = checklistText
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}