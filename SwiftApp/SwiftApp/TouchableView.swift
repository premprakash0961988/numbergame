//
//  TouchableView.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/10/14.
//  Copyright (c) 2014 Flipkart. All rights reserved.
//

import UIKit

class TouchableView: UIView {


    override init(frame  rect: CGRect)  {
        super.init(frame: rect)
        self.backgroundColor = UIColor.clearColor()
    }
    
     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        // Drawing code
    }
    

}
