//
//  PhotoViewController.swift
//  CollectionViewDemo
//
//  Created by PhuND on 3/29/16.
//
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    var image = ""
    
    override func viewDidLoad() {
        recipeImageView.image = UIImage(named: image)
    }
}
