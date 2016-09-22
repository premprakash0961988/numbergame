//
//  TouchableView.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/10/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

import UIKit

protocol UserTouchDelegate : NSObjectProtocol {
    func touchBegan(location : CGPoint)
    func touchMoved(location : CGPoint)
    func touchEnded()
    
}

class TouchableView: UIScrollView {
    var subView : TouchView!


    override init(frame  rect: CGRect)  {
        super.init(frame: rect)
        var bounds = rect
        bounds.origin.x = 0
        bounds.origin.y = 0
        
        
        subView = TouchView(frame: bounds)
        subView.isExclusiveTouch = true
        self.isExclusiveTouch = true
        
        
        self.addSubview(subView)
        self.backgroundColor = UIColor.clear
        self.maximumZoomScale = 2
        self.isScrollEnabled = false
        
        self.isMultipleTouchEnabled = true
        subView.isMultipleTouchEnabled = true

    }
    
    
    
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
   

}


class TouchView : UIView {
    weak var touchDelegate : UserTouchDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            touchDelegate?.touchBegan(location:(touch.location(in: self)))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchDelegate?.touchMoved(location:(touch.location(in: self)))
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDelegate?.touchEnded()
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDelegate?.touchEnded()
    }

}



