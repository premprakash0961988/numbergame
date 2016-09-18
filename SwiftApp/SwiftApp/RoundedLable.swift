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

    var color = UIColor.clear
    enum RoundedLabelState {
        case stateCorrect
        case stateInCorrect
        case stateUnTouched
        case stateDisabled
    }

    var roundedLabelState : RoundedLabelState = RoundedLabelState.stateUnTouched
    
    override init(frame  rect: CGRect) {
        super.init(frame: rect)
        
        self.font = UIFont(name: "Baskerville-SemiBold", size: 20)
        self.roundedLabelState = RoundedLabelState.stateUnTouched
    }
    
    func setRoundedLabelState(_ state : RoundedLabelState) {
        self.roundedLabelState = state
        self.setNeedsDisplay()

        switch (state) {
        case .stateCorrect :
            self.textColor = UIColor.green
            break
        case .stateInCorrect :
            self.textColor = UIColor.red
            break
        case .stateUnTouched :
            self.textColor = UIColor.white
            break
        case .stateDisabled :
            self.textColor = UIColor.lightGray
            break
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func draw(_ rect: CGRect)
    {

        let bounds:CGRect = self.bounds
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        let radius = (min(bounds.size.width, bounds.size.height) / 2.0) - 4.0
        let path:UIBezierPath = UIBezierPath()
        color.setFill()
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(0.0), endAngle: CGFloat(Float(M_PI) * 2.0), clockwise: true)

        switch self.roundedLabelState {
        case .stateCorrect :
            UIColor.green.setStroke()
            path.lineWidth = 2
            break
        case .stateInCorrect :
            UIColor.red.setStroke()
            path.lineWidth = 2
            break
        case .stateUnTouched :
            UIColor.white.setStroke()
            path.lineWidth = 1
            break
        case .stateDisabled :
            UIColor.yellow.setStroke()
            path.lineWidth = 1
            break
        }

        path.fill()
        path.stroke()
        
        super.draw(rect)

    }
    
    func ineractiveFrame() -> CGRect {
        let egdeWidth = self.frame.width/5
        return self.frame.insetBy(dx: egdeWidth, dy: egdeWidth)
        
    }

}
