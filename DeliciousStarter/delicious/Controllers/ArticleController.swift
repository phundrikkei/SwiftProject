//
//  ArticleController.swift
//  Delicious
//
//  Created by Sean Choo on 4/27/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit
import MapKit

class ArticleController: UITableViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var currentArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500.0
        
        initializeArticle()
        addFooterView()
    }
    
    func initializeArticle(){
        let mainContent = "Start your day with amazing breakfast,"
                        + "and you will be happy throughout the day"
        let article = Article(title: "Lovely Breakfast",
                        mainContent: mainContent,
                         coverPhoto: "Toast",
                    coverPhotoWidth: 1080,
                   coverPhotoHeight: 810,
                           mealType: "Breakfast",
                          mealPrice: 34)
        article.restaurantName = "Toast Box"
        article.restaurantAddress = "G/F, JD Mall, 233-239 Nathan Rd, Jordan"
        article.restaurantLatitude = 21.027864882982680
        article.restaurantLongitude = 105.834286361122100
        article.authorDisplayName = "The Dreamer"
        article.authorUsername = "dreamer"
        
        let subContentOne = SubContent(photo: "Egg",
                                  photoWidth: 1080,
                                 photoHeight: 810,
                                        text: "Half-boiled eggs is a must")
        let subContentTwo = SubContent(photo: "Tea",
                                  photoWidth: 1080,
                                 photoHeight: 810,
                                        text: "Singapore/Malaysia-styled milk tea. Milder than Hong Kong style but still great")
        article.subContents = [subContentOne, subContentTwo]
        self.currentArticle = article
    }
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let article = self.currentArticle {
            return 2 + article.subContents.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let width = currentArticle?.coverPhotoWidth, height = currentArticle?.coverPhotoHeight {
                let heightRatio = height / width
                return screenWidth * heightRatio
            }
        }
        
        return UITableViewAutomaticDimension
    }
    
    func attributedContentFromText(text: String) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 7
        let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(15),
                     NSParagraphStyleAttributeName: paraStyle]
        let attrContent = NSMutableAttributedString(string: text, attributes: attrs)
        return attrContent
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellForRow: UITableViewCell!
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CoverPhotoCell", forIndexPath: indexPath) as! CoverPhotoTableViewCell
            
            if let imageName = currentArticle?.coverPhoto {
                cell.coverImageView.image = UIImage(named: imageName)
            }
            
            cellForRow = cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MainContentCell", forIndexPath: indexPath) as! MainContentTableViewCell
            cell.titleLabel.text = currentArticle?.title
            
            cell.contentLabel.textAlignment = .Left
            if let text = currentArticle?.mainContent {
                cell.contentLabel.attributedText = attributedContentFromText(text)
            }
            
            cellForRow = cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SubContentCell", forIndexPath: indexPath) as! SubContentTableViewCell
            
            if let article = currentArticle {
                let subContent = article.subContents[indexPath.row - 2]
                
                if let width = subContent.photoWidth, height = subContent.photoHeight {
                    let heightRatio = height / width
                    cell.subImageViewHeight.constant = screenWidth * heightRatio
                }
                
                if let imageName = subContent.photo {
                    cell.subImageView.image = UIImage(named: imageName)
                }
                
                cell.subContentLabel.textAlignment = .Left
                if let text = subContent.text {
                    cell.subContentLabel.attributedText = attributedContentFromText(text)
                }
                
            }
            
            cellForRow = cell
        }
        
        return cellForRow
    }
    
    func addFooterView() {
        let footerView = NSBundle.mainBundle().loadNibNamed("ArticleFooterView", owner: self, options: nil)[0] as! ArticleFooterView
        footerView.frame = CGRectMake(0, 0, screenWidth, 486)
        
        footerView.separatorHeight.constant = 0.6
        
        if let type = currentArticle?.mealType, price = currentArticle?.mealPrice {
            footerView.mealTypeLabel.text = type
            footerView.mealPriceLabel.text = "HK$ \(price)"
        }
        
        if let name = currentArticle?.restaurantName, address = currentArticle?.restaurantAddress {
            footerView.restaurantNameLabel.text = name
            footerView.restaurantAddressLabel.text = address
        }
        
        if let name = currentArticle?.authorDisplayName, username = currentArticle?.authorUsername {
            footerView.displayNameLabel.text = name
            footerView.usernameLabel.text = "@\(username)"
        }
        
        if let lat = currentArticle?.restaurantLatitude, lng = currentArticle?.restaurantLongitude {
            let location = CLLocation(latitude: lat, longitude: lng)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 250.0, 250.0)
            footerView.mapView.setRegion(coordinateRegion, animated: false)
            
            let pin = MKPointAnnotation()
            pin.coordinate = location.coordinate
            footerView.mapView.addAnnotation(pin)
        }
        
        tableView.tableFooterView = footerView
    }
}
