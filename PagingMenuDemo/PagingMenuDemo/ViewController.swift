//
//  ViewController.swift
//  PagingMenuDemo
//
//  Created by PhuND on 5/4/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit
import PagingMenuController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let viewVC1 = ListViewController()
//        viewVC1.textLabel.text = "View Controller 1"
        
        let viewVC2 = ListViewController()
        viewVC1.title = "abc"
//        viewVC2.textLabel.text = "View Controller 2"
        
        let viewVCs = [viewVC1, viewVC2, ListViewController(), ListViewController(), ListViewController()]
        
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 40
//        options.menu
        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .ScrollEnabled)
        options.menuPosition = .Top
        
        options.menuItemMode = .Underline(height: 2, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
        options.selectedTextColor = UIColor.redColor()
        options.scrollEnabled = true
        
        let pagingMenuController = PagingMenuController(viewControllers: viewVCs, options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
        self.title = "Paging Menu Controller"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

