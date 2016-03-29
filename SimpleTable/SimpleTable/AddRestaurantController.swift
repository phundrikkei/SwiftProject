//
//  AddRestaurantController.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/23/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var restaurant: Restaurant!
    var isVisited: Int!
    override func viewDidLoad() {
//        restaurant = Restaurant()
        isVisited = 0
        changeColorBtnHere(isVisited)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leadingContraint = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        leadingContraint.active = true
        
        let trailingContraint = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        trailingContraint.active = true
        
        let topContraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        topContraint.active = true
        
        let bottomContraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        bottomContraint.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func chooseBeenHere(sender: UIButton) {
        isVisited = sender.tag
        changeColorBtnHere(isVisited)
    }
    
    @IBAction func save(sender: AnyObject) {
        //validate field
        if nameField.text != "" && locationField != "" && typeField != "" {
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
                restaurant.name = nameField.text!
                restaurant.location = locationField.text!
                restaurant.type = typeField.text!
                restaurant.phoneNumber = phoneField.text
                if let restaurantImage = imageView.image {
                    restaurant.image = UIImagePNGRepresentation(restaurantImage)
                }
                restaurant.isVisited = isVisited
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            performSegueWithIdentifier("unwindToHomeView", sender: self)
        } else {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required", preferredStyle: .Alert)
            let action  = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(action)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    func changeColorBtnHere(isVisited: Int){
        if isVisited == 0 {
            btnYes.backgroundColor = UIColor.grayColor()
            btnNo.backgroundColor = UIColor.redColor()
        } else {
            btnYes.backgroundColor = UIColor.redColor()
            btnNo.backgroundColor = UIColor.grayColor()
        }
    }
}
