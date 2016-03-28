//
//  SettingViewController.swift
//  IOS8SwiftActionSheetTutorial
//
//  Created by Hoang NA on 3/16/16.
//  Copyright (c) 2016 Arthur Knopper. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let lists = ["Facebook Login","Version","abc"]

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many rows are there in this section?
        // There's only 1 section, and it has a number of rows
        // equal to the number of logItems, so return the count
        return lists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
//        cell.contentView.layoutMargins = UIEdgeInsetsZero
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // Get the LogItem for this index
        let logItem = lists[indexPath.row]
        
        // Set the title of the cell to be the title of the logItem
        cell.textLabel?.text = logItem
        return cell
    }
}