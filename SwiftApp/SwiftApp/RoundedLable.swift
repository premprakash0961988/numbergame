//
//  RoundedLable.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/10/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class RoundedLable : UILabel {

    var color = UIColor.clearColor()
    enum RoundedLabelState {
        case StateCorrect
        case StateInCorrect
        case StateUnTouched
        case StateDisabled
    }

    var roundedLabelState : RoundedLabelState = RoundedLabelState.StateUnTouched
    
    override init(frame  rect: CGRect) {
        super.init(frame: rect)
        
        self.font = UIFont(name: "Baskerville-SemiBold", size: 20)
        self.roundedLabelState = RoundedLabelState.StateUnTouched
    }
    
    func setRoundedLabelState(state : RoundedLabelState) {
        self.roundedLabelState = state
        self.setNeedsDisplay()

        switch (state) {
        case .StateCorrect :
            self.textColor = UIColor.greenColor()
            break
        case .StateInCorrect :
            self.textColor = UIColor.redColor()
            break
        case .StateUnTouched :
            self.textColor = UIColor.whiteColor()
            break
        case .StateDisabled :
            self.textColor = UIColor.lightGrayColor()
            break
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func drawRect(rect: CGRect)
    {

        let bounds:CGRect = self.bounds
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        let radius = (min(bounds.size.width, bounds.size.height) / 2.0) - 4.0
        let path:UIBezierPath = UIBezierPath()
        color.setFill()
        path.addArcWithCenter(center, radius: CGFloat(radius), startAngle: CGFloat(0.0), endAngle: CGFloat(Float(M_PI) * 2.0), clockwise: true)

        switch self.roundedLabelState {
        case .StateCorrect :
            UIColor.greenColor().setStroke()
            path.lineWidth = 2
            break
        case .StateInCorrect :
            UIColor.redColor().setStroke()
            path.lineWidth = 2
            break
        case .StateUnTouched :
            UIColor.whiteColor().setStroke()
            path.lineWidth = 1
            break
        case .StateDisabled :
            UIColor.yellowColor().setStroke()
            path.lineWidth = 1
            break
        }

        path.fill()
        path.stroke()
        
        super.drawRect(rect)

    }
    
    func ineractiveFrame() -> CGRect {
        let egdeWidth = CGRectGetWidth(self.frame)/5
        return self.frame.insetBy(dx: egdeWidth, dy: egdeWidth)
        
    }

}
