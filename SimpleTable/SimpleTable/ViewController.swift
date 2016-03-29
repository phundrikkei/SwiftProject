//
//  ViewController.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/21/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    var fetchResultController: NSFetchedResultsController!
    
    var restaurants:[Restaurant] = []
    var searchResults:[Restaurant] = []
    
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        self.navigationController?.navigationBar.barStyle = .BlackTranslucent
        
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
            
        }
        
        // add search controller
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
//        searchController.searchBar.placeholder = "abc"
//        searchController.searchBar.tintColor = UIColor.greenColor()
//        searchController.searchBar.prompt = "123"
//        searchController.searchBar.barTintColor = UIColor.grayColor()
//        searchController.searchBar.searchBarStyle = .Minimal
        
//        let view = UIView(frame: CGRectMake(0, 0, 40, 40))
//        view.backgroundColor = UIColor.grayColor()
//        tableView.tableFooterView = view
//        
//        let indicator = UIActivityIndicatorView(frame: CGRectMake(0,0,40,40))
//        indicator.activityIndicatorViewStyle = .White
//        indicator.startAnimating()
//        indicator.center = view.center
//        view.addSubview(indicator)
//        let refreshControl = UIRefreshControl()
//        refreshControl.backgroundColor = UIColor.blueColor()
////        tableView.tableFooterView = refreshControl
//        view.addSubview(refreshControl)
//        refreshControl.beginRefreshing()
        
        // connet to function to handle search
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
         
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation when swipe
        navigationController?.hidesBarsOnSwipe = true
        
//        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
//            let fetchRequest = NSFetchRequest(entityName: "Restaurant")
//            
//            do {
//                restaurants = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Restaurant]
//                tableView.reloadData()
//            } catch {
//                print(error)
//            }
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasWalked = defaults.boolForKey("hasViewWalkingThrough")
        
        if hasWalked {
            return
        }
        
        if let pageController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController") as? WalkThroughPageViewController {
            presentViewController(pageController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRestaurantDetail"){
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! RestaurantDetailController
                if searchController.active {
                    destinationController.restaurant = searchResults[indexPath.row]
                } else {
                    destinationController.restaurant = restaurants[indexPath.row]
                }
                destinationController.hidesBottomBarWhenPushed = true
//                destinationController.name = restaurants[indexPath.row].name
//                destinationController.location = restaurants[indexPath.row].location
//                destinationController.type = restaurants[indexPath.row].type
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
//        cell.textLabel?.text = restaurantNames[indexPath.row]
//        cell.imageView?.image = UIImage(named: "restaurant")
        var restaurant: Restaurant
        if searchController.active {
            restaurant = searchResults[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        if restaurant.isVisited == 1 {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if(editingStyle == .Delete){
//            restaurants.removeAtIndex(indexPath.row)
////            restaurantImages.removeAtIndex(indexPath.row)
////            restaurantLocations.removeAtIndex(indexPath.row)
////            restaurantNames.removeAtIndex(indexPath.row)
////            restaurantTypes.removeAtIndex(indexPath.row)
////            tableView.reloadData()
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .Default, title: "Share", handler: {
            (action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            if let image = UIImage(data: self.restaurants[indexPath.row].image!){
                let activityController = UIActivityViewController(activityItems: [defaultText,image], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {
            (action, indexPath) -> Void in
//            self.restaurants.removeAtIndex(indexPath.row)
//            self.restaurantImages.removeAtIndex(indexPath.row)
//            self.restaurantLocations.removeAtIndex(indexPath.row)
//            self.restaurantNames.removeAtIndex(indexPath.row)
//            self.restaurantTypes.removeAtIndex(indexPath.row)
            //            tableView.reloadData()
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                let restaurantToDelete  = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
        })
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        return [shareAction, deleteAction]
    }
    
//    // MARK: UITableViewDelegate
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath)
//        let alert  = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .ActionSheet)
//        let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        
//        let handlerCall = {(action:UIAlertAction) -> Void in
//            let callAlert = UIAlertController(title: "Service unavailable", message: "Sorry, the call feature is not available yet.Please try later", preferredStyle: .Alert)
//            let actionOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            callAlert.addAction(actionOk)
//            self.presentViewController(callAlert, animated: true, completion: nil)
//        }
//        
//        let actionCall = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default, handler: handlerCall)
//        
//        let isCheck = restaurantIsVisited[indexPath.row]
//        let titleAction = isCheck ? "I've been not there" : "I've been there"
//        
//        let isVisitedAction = UIAlertAction(title: titleAction, style: .Default, handler: {
//            (action:UIAlertAction) -> Void in
////                print("abc")
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            if !isCheck {
//                cell?.accessoryType = .Checkmark
//                self.restaurantIsVisited[indexPath.row] = true
//            } else {
//                cell?.accessoryType = .None
//                self.restaurantIsVisited[indexPath.row] = false
//            }
//        })
//        alert.addAction(actionCall)
//        alert.addAction(actionCancel)
//        alert.addAction(isVisitedAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
    
    //MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    @IBAction func UnWindToHome(segue:UIStoryboardSegue){
//        if let addRestaurantController = segue.sourceViewController as? AddRestaurantController {
//            if let restaurant = addRestaurantController.restaurant {
//                restaurants.append(restaurant)
//                tableView.reloadData()
//            }
//        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchString: String) {
        searchResults = restaurants.filter({
            (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil || locationMatch != nil
        })
    }

}

