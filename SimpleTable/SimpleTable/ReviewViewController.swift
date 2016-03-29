//
//  ReviewViewController.swift
//  SimpleTable
//
//  Created by Hoang NA on 3/23/16.
//  Copyright © 2016 Ltd. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageReview: UIImageView!
    @IBOutlet weak var stackReview: UIStackView!
    var rating:String?

    @IBOutlet weak var greatBtn: UIButton!
    @IBOutlet weak var goodbtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageReview.addSubview(blurEffectView)
        
//        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0.0, 500)
//        stackReview.transform = CGAffineTransformConcat(scale, translate)
        dislikeBtn.transform = translate
        goodbtn.transform = translate
        greatBtn.transform = translate
    }

    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.5, options: [], animations: {self.stackReview.transform = CGAffineTransformIdentity}, completion: nil)
        UIView.animateWithDuration(1, delay: 0, options: [], animations: {self.dislikeBtn.transform = CGAffineTransformIdentity}, completion: {
            finished -> Void in
            UIView.animateWithDuration(1, delay: 0, options: [], animations: {self.goodbtn.transform = CGAffineTransformIdentity}, completion: {
                finished -> Void in
                 UIView.animateWithDuration(1, delay: 0, options: [], animations: {self.greatBtn.transform = CGAffineTransformIdentity}, completion: nil)
            })
        })
    }
    
    @IBAction func rateSelected(sender: UIButton) {
        switch sender.tag {
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default: break
        }
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
}
