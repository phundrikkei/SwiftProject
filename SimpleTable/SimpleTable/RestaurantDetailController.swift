//
//  RestaurantDetail.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/22/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var restaurantImageView: UIImageView!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet var rateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var restaurant : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.separatorColor = UIColor.blackColor()
        tableView.tableFooterView = UIView(frame: CGRectZero) // hide empty row
        restaurantImageView.image = UIImage(data: restaurant.image!)
        if let rating = restaurant.rating where restaurant.rating != "" {
            rateButton.setImage(UIImage(named: rating), forState: .Normal)
        }
        
//        nameLabel.text = restaurant.name
//        locationLabel.text = restaurant.location
//        typeLabel.text = restaurant.type
        
        // change title of navigation
        navigationItem.title = restaurant.name
        
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // self sizing cell
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation when swipe
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let mapViewController = segue.destinationViewController as! MapViewController
            mapViewController.restaurant = restaurant
        }
    }
    
    
    //MARK: tableViewDatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLable.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Location"
            cell.valueLable.text = restaurant.location
        case 2:
            cell.fieldLabel.text = "Type"
            cell.valueLable.text = restaurant.type
        case 3:
            cell.fieldLabel.text = "Phone Number"
            cell.valueLable.text = restaurant.phoneNumber
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLable.text = (restaurant.isVisited == 1) ? "Yes, I have been here" : "No"
        default :
            cell.fieldLabel.text = ""
            cell.valueLable.text = ""
        }
        return cell
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewViewController = segue.sourceViewController as? ReviewViewController {
            if let rating = reviewViewController.rating {
//                rateButton.setBackgroundImage(UIImage(named: rating), forState: .Normal)
                restaurant.rating = rating
                rateButton.setImage(UIImage(named: rating), forState: .Normal)
                
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
            }
            
        }
    }
}