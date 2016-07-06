//
//  BubleView.swift
//  BubleView
//
//  Created by PhuND on 6/23/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import UIKit

class BubleView: UIView {
    
    var color:UIColor = UIColor.grayColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    required convenience init(withColor frame: CGRect, color:UIColor? = .None) {
        self.init(frame: frame)
        
        if let color = color {
            self.color = color
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let rounding:CGFloat = rect.width * 0.02
        
        //Draw the main frame
        
        let bubbleFrame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height * 2 / 3)
        let bubblePath = UIBezierPath(roundedRect: bubbleFrame, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: rounding, height: rounding))
        
        //Color the bubbleFrame
        
        color.setStroke()
        color.setFill()
        bubblePath.stroke()
        bubblePath.fill()
        
        //Add the point
        
        let context = UIGraphicsGetCurrentContext()
        
        //Start the line
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, CGRectGetMinX(bubbleFrame) + bubbleFrame.width * 1/3, CGRectGetMaxY(bubbleFrame))
        
        //Draw a rounded point
        
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect) * 1/3, CGRectGetMaxY(rect), CGRectGetMaxX(bubbleFrame), CGRectGetMinY(bubbleFrame), rounding)
        
        //Close the line
        
        CGContextAddLineToPoint(context, CGRectGetMinX(bubbleFrame) + bubbleFrame.width * 2/3, CGRectGetMaxY(bubbleFrame))
        CGContextClosePath(context)
        
        //fill the color
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillPath(context);
    }
}