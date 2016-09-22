//
//  ViewController+Interaction.swift
//  SwiftApp
//
//  Created by Koovs on 22/09/16.
//  Copyright © 2016 Flipkart. All rights reserved.
//

import Foundation
import  UIKit


extension ViewController : UserTouchDelegate {
    
    func touchBegan(location : CGPoint) {
        handleUserTouch(location: location)
    }
    
    func touchMoved(location : CGPoint) {
        handleUserTouch(location: location)
    }
    
    func touchEnded() {
        self.resetViews()
    }
    
    
    func handleUserTouch(location : CGPoint) {
        for box  in allBoxes {
            if(box.ineractiveFrame().contains(location)) {
                let index = selectedBoxes.index(of: box)
                if(index == nil) {
                    box.operation = selectedOperation
                    selectedBoxes.append(box)
                    self.configureBoxes()
                }
                break;
            }
        }
    }
    
    
    func configureBoxes(){
        let state = self.currentStateForGame()
        for (index, _) in selectedBoxes.enumerated() {
            let label : RoundedLable = selectedBoxes[index]
            label.setRoundedLabelState(state)
        }
        drawUserInteractions()
    }
    
    func drawUserInteractions() {
        
        let path = UIBezierPath()
        if let first = selectedBoxes.first {
            path.move(to: convertPoint(point: first.center))
        }
        
        for box in selectedBoxes {
            path.addLine(to: convertPoint(point: box.center))
            
        }
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = (currentStateForGame() == .stateCorrect) ? UIColor.green.cgColor : UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0;
        self.baseView?.layer.insertSublayer(shapeLayer, at: 0)
        
        updateEquationBoard()
    }
    
    
    func convertPoint(point : CGPoint) -> CGPoint {
        let x = baseView!.zoomScale * point.x
        let y = baseView!.zoomScale * point.y
        return CGPoint(x:x,y:y)
    }
    
}



extension ViewController : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return (scrollView as? TouchableView)?.subView
    }
}

