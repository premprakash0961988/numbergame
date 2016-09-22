//
//  ViewController+Scoring.swift
//  SwiftApp
//
//  Created by Koovs on 22/09/16.
//  Copyright © 2016 Flipkart. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func createScoreCard() {
        let headingLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 35))
        headingLabel.textAlignment = NSTextAlignment.center
        headingLabel.text = "-= Score =-"
        headingLabel.textColor =  UIColor.white
        headingLabel.font = UIFont(name: "Baskerville-SemiBold", size: 30)
        self.view.addSubview(headingLabel)
        
        scoreCard = UILabel(frame: CGRect(x: 0, y: headingLabel.frame.maxY, width: self.view.frame.width, height: 30))
        scoreCard?.textAlignment = NSTextAlignment.center
        scoreCard?.text = "0";
        scoreCard?.textColor =  UIColor.white
        scoreCard?.font = UIFont(name: "Baskerville-SemiBold", size: 20)
        self.view.addSubview(scoreCard!)
    }
    
    func createEquationBoard() {
        currentEquationBoard = UILabel(frame: CGRect(x: 8, y: scoreCard!.frame.maxY, width: self.view.frame.width, height: 44))
        currentEquationBoard?.textAlignment = .center
        currentEquationBoard?.textColor =  UIColor.white
        currentEquationBoard?.font = UIFont(name: "Baskerville-SemiBold", size: 20)
        self.view.addSubview(currentEquationBoard!)
    }
    
    func updateEquationBoard() {
        var equation : Int = 0
        let count = selectedBoxes.count

        if count > 0 {
            for (index, _) in selectedBoxes.enumerated() {
                let label : RoundedLable = selectedBoxes[index]
                equation += Int(label.text!) ?? 0
            }
            currentEquationBoard?.text = "Current : \(equation)"
        }
        else {
            currentEquationBoard?.text = ""
        }
        
        
    }
    
}
