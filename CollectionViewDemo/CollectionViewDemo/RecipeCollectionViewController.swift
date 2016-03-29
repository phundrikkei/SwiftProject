//
//  RecipeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by PhuND on 3/29/16.
//
//

import UIKit

class RecipeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!

    var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict",
        "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich",
        "hamburger", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork",
        "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee",
        "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
    
    var shareEnabled = false
    var selectedRecipes:[String] = []
    
    override func viewDidLoad() {
        print(collectionView?.frame.size)
    }
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        collectionView?.reloadData()
//    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RecipeCollectionViewCell
        cell.recipeImageView.image = UIImage(named: recipeImages[indexPath.row])
        cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame"))
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "photo-frame-selected"))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath:
            NSIndexPath) -> CGSize {
//            let sideSize = (traitCollection.horizontalSizeClass == .Compact &&
//            traitCollection.verticalSizeClass == .Regular) ? 80.0 : 128.0
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let space = CGFloat(10)
            let count = CGFloat(recipeImages.count)
            let sideSize = sqrt(width * height / count) - space * 3
            print(sideSize)
            return CGSize(width: sideSize, height: sideSize)
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard shareEnabled else {
            return
        }
        
        selectedRecipes.append(recipeImages[indexPath.row])
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            guard shareEnabled else {
                return
            }
            
            let deSelectedRecipe = recipeImages[indexPath.row]
            if let index = selectedRecipes.indexOf(deSelectedRecipe) {
                selectedRecipes.removeAtIndex(index)
            }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showRecipePhoto" {
            if shareEnabled {
                return false
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  "showRecipePhoto" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems() {
                let destinationViewController = segue.destinationViewController as! UINavigationController
                let photoViewController = destinationViewController.viewControllers[0] as! PhotoViewController
                photoViewController.image = recipeImages[indexPaths[0].row]
                collectionView?.deselectItemAtIndexPath(indexPaths[0], animated: true)
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
            
    }
    @IBAction func shareButtonTapped(sender: AnyObject) {
        if shareEnabled {
            if selectedRecipes.count > 0 {
                
            }
        
            shareEnabled = false
            collectionView?.allowsMultipleSelection = false
            shareButton.title = "Share"
            shareButton.style = .Plain
        } else {
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true
            shareButton.title = "Upload"
            shareButton.style = .Done
        }
    }
}
