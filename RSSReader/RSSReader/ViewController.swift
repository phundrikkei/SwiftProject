//
//  ViewController.swift
//  RSSReader
//
//  Created by PhuND on 5/17/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var rssItems: [(title: String, description: String, pubDate: String)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl(frame: CGRectMake(0, 0, 50, 50))
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.backgroundColor = UIColor.grayColor()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: #selector(ViewController.refresh),
                                 forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.endRefreshing()
        
        updateTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Tableviewdatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rssItems = rssItems {
            return rssItems.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! RssTableViewCell
        
        if let item = rssItems?[indexPath.row] {
            cell.titleLabel.text = item.title
            cell.dateLabel.text = item.pubDate
            cell.descriptionLabel.text = item.description
        }
        return cell
    }

//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y <= 0 {
//            refreshControl.beginRefreshing()
//            print("refreshcontrol is \(refreshControl.refreshing)")
//            if refreshControl.refreshing {
//                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
//                dispatch_after(time, dispatch_get_main_queue(), {
//                    self.refreshControl.endRefreshing()
//                })
//            }
//        }
//    }
    
    
    func refresh(){
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
//        dispatch_after(time, dispatch_get_main_queue(), {
//            self.refreshControl.endRefreshing()
//        })
//        refreshControl.endRefreshing()
//        self.tableView.reloadData()
//        refreshControl.endRefreshing()
        updateTableData()
    }
    
    func updateTableData(){
        let feedParser = FeedParser()
        feedParser.parseFeed("https://www.apple.com/main/rss/hotnews/hotnews.rss") { (rssItems: [(title: String, description: String, pubDate: String)]) -> Void in
            self.rssItems = rssItems
            dispatch_async(dispatch_get_main_queue(), {
                //                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }
}

