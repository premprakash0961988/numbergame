//
//  ViewController.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/09/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allBoxes : [RoundedLable] = []
    var selectedBoxes = [RoundedLable]()
    var dataSet : [UInt32] = []
    var suggestions : [RoundedLable] = []
    var baseView : TouchableView?
    var upComingObjectView : UIScrollView?
    var scoreCard : UILabel?
    let shapeLayer = CAShapeLayer()
    let numberOfRows = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.createScoreCard()
        self.creatDataSetForRows(numberOfRows)
        self.createView(numberOfRows)
        self.createUpComingObjects()
    }
    
    
    func createScoreCard() {
        let headingLabel = UILabel(frame: CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 35))
        headingLabel.textAlignment = NSTextAlignment.Center
        headingLabel.text = "-= Score =-"
        headingLabel.textColor =  UIColor.whiteColor()
        headingLabel.font = UIFont(name: "Baskerville-SemiBold", size: 30)
        self.view.addSubview(headingLabel)
        
        scoreCard = UILabel(frame: CGRectMake(0, CGRectGetMaxY(headingLabel.frame), CGRectGetWidth(self.view.frame), 30))
        scoreCard?.textAlignment = NSTextAlignment.Center
        scoreCard?.text = "0";
        scoreCard?.textColor =  UIColor.whiteColor()
        scoreCard?.font = UIFont(name: "Baskerville-SemiBold", size: 20)
        self.view.addSubview(scoreCard!)
    }
    
    
    func createUpComingObjects() {
        
        var x : CGFloat = 0
        let y : CGFloat = 0
        let boxWidth : CGFloat = 80
        let boxHeight : CGFloat = 80
        
        upComingObjectView = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(scoreCard!.frame), CGRectGetWidth(self.view.frame), boxHeight))
        upComingObjectView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(upComingObjectView!)
        
        let count = dataSet.count
        let animationDuration : NSTimeInterval = 0.3
        let delayInAnimation : NSTimeInterval = 0.0
        let factor : Double = Double((arc4random()%5)) + 3
        
        for index in 0..<count {
            let nextObj : Int = Int(dataSet[index])
            
            let newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(boxWidth) - 10, CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj) as String
            newLable.textColor = UIColor.lightGrayColor()
            newLable.roundedLabelState = RoundedLable.RoundedLabelState.StateDisabled
            newLable.textColor = UIColor.yellowColor()
            scoreCard?.font = UIFont(name: "Baskerville-SemiBold", size: 13)
            newLable.textAlignment = NSTextAlignment.Center
            x += boxWidth + 10
            
            var fromRect = newLable.frame
            let toRect = newLable.frame
            fromRect.origin.x -= 300
            newLable.frame = fromRect
            upComingObjectView?.addSubview(newLable)
            suggestions.append(newLable)
            UIView.animateWithDuration(animationDuration, delay:delayInAnimation/factor, usingSpringWithDamping: 0.9, initialSpringVelocity:5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                newLable.frame = toRect
                }, completion: nil)
            
        }
        upComingObjectView?.contentSize = CGSizeMake(x , boxHeight)
        
    }
    
    func removeObjectsForIndex( numberOfObjects : Int ) {
        var xMargin : CGFloat = 0
        var allObjects = suggestions
        var originX : CGFloat = 0
        for index in 0..<allObjects.count {
            let upcomingObject : RoundedLable = allObjects[index]
            if(index < numberOfObjects) {
                suggestions.removeAtIndex(0)
                xMargin = CGRectGetMaxX(upcomingObject.frame)
                UIView.animateWithDuration (0.5, delay:1.0, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    upcomingObject.transform = CGAffineTransformMakeScale(0.0, 0.0)
                    }, completion: { finished in
                        upcomingObject.removeFromSuperview()
                        
                })
            }
            else {
                originX = upcomingObject.frame.origin.x - xMargin
                var toFrame : CGRect = upcomingObject.frame
                toFrame.origin.x = originX
                UIView.animateWithDuration (0.5, delay:1.0, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    upcomingObject.frame = toFrame
                    }, completion:nil)
            }
        }
        self.addUpComingObject(numberOfObjects, xOrigin: originX)
        
    }
    
    func addUpComingObject (numberOfObjects : Int , xOrigin : CGFloat ) {
        let boxWidth : CGFloat = 80
        let boxHeight : CGFloat = 80
        var x : CGFloat = xOrigin + boxWidth
        let y : CGFloat = 0
        
        
        
        var newObjects = [UInt32]()
        for _ in 0..<numberOfObjects {
            let newInt : UInt32 = (arc4random()%30) + 10
            newObjects.append(newInt)
            self.dataSet.append(newInt)
        }

        for nextObj in newObjects {
            let newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(boxWidth) - 10, CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj) as String
            newLable.textColor = UIColor.lightGrayColor()
            newLable.roundedLabelState = RoundedLable.RoundedLabelState.StateDisabled
            newLable.textColor = UIColor.yellowColor()
            newLable.textAlignment = NSTextAlignment.Center
            upComingObjectView?.addSubview(newLable)
            suggestions.append(newLable)

            x += boxWidth + 10
        }
        
        

        

        upComingObjectView?.contentSize = CGSizeMake(x , boxHeight)


    }
    
    
    
    func creatDataSetForRows(numberOfBoxes : NSInteger) {
        let totalBoxes = numberOfBoxes * numberOfBoxes
        for _ in 0...totalBoxes*2 {
            let newInt : UInt32 = (arc4random()%20) + 1
            self.dataSet.append(newInt)
        }
    }
    
    
        
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.addChildWithTouch(touch)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.addChildWithTouch(touch)
        }

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.resetViews()
    }
    
    
    
    
    
    func addChildWithTouch(touch : UITouch) {
        if let view = touch.view {
            let touchedView : UIView = (view)
            if(touchedView == self.baseView) {
                let location : CGPoint = (touch.locationInView(touch.view))
                for box  in allBoxes {
                    if(box.ineractiveFrame().contains(location)) {
                        let index = selectedBoxes.indexOf(box)
                        if(index == nil) {
                            selectedBoxes.append(box)
                            self.configureBoxes()
                        }
                        break;
                    }
                }
            }
        }
    }
    
    func configureBoxes(){
        let state = self.currentStateForGame()
        for (index, _) in selectedBoxes.enumerate() {
            let label : RoundedLable = selectedBoxes[index]
            label.setRoundedLabelState(state)
        }
        drawUserInteractions()
    }
    
    func currentStateForGame() -> RoundedLable.RoundedLabelState {
        var total = 0
        var roundedLabelState  = RoundedLable.RoundedLabelState.StateInCorrect;
        for (index, _) in selectedBoxes.enumerate() {
            let label : RoundedLable = selectedBoxes[index]
            let text : NSString = label.text!
            let number = text.integerValue
            if(index == selectedBoxes.count - 1 && number == total) {
                roundedLabelState = RoundedLable.RoundedLabelState.StateCorrect;
            }
            else {
                total += number;
            }
        }
        return roundedLabelState;
    }
    
    func resetViews() {
        let previousScore = Int(self.scoreCard?.text ?? "0")
        var scoreEarned : Int = previousScore!
        let numberOfBoxes = selectedBoxes.count
        for (index, _) in selectedBoxes.enumerate() {
            let label : RoundedLable = selectedBoxes[index]
            let state = self.currentStateForGame()
            if(state == RoundedLable.RoundedLabelState.StateCorrect) {
                let value = Int(label.text ?? "0")
                //scoreEarned += value! * Int(pow(Double(10), Double(numberOfBoxes)))
                scoreEarned += value! * numberOfBoxes //Int(pow(Double(10), Double(numberOfBoxes)))
                //var animationDuration : NSTimeInterval = 0.3
                //
                
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    self.drawUserInteractions()
                }

                let delayTime1 = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime1, dispatch_get_main_queue()) {
                    IntelligentGuy.calculateAllPossibleOptions(self.currentData())
                    
                }

                
                UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    label.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    
                    }, completion: { finished in
                        
                        UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                            label.transform = CGAffineTransformIdentity
                            label.text = NSString(format: "%d", self.objectForNextIndex()) as String
                            label.setRoundedLabelState(RoundedLable.RoundedLabelState.StateUnTouched)
                            
                            }, completion: { finished in
                               
                        })
                })
            }
            else {
                label.setRoundedLabelState(RoundedLable.RoundedLabelState.StateUnTouched)
                self.drawUserInteractions()
            }
        }
        if(scoreEarned != previousScore) {
            self.setUserScore(scoreEarned)
            self.removeObjectsForIndex(numberOfBoxes)
        }
        selectedBoxes.removeAll()
        
    }
    
    
    func setUserScore(score : Int) {
        let scoreCard : UILabel = self.scoreCard!
        UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            scoreCard.text = NSString(format: "%d", score) as String
            }, completion: { finished in
                
        })
        
    }
    
    
    func objectForNextIndex() -> Int {
//        if(dataSet.count < numberOfRows*numberOfRows) {
//            self.creatDataSetForRows(numberOfRows)
//        }

        let firstObject : Int = Int(dataSet[0])
        dataSet.removeAtIndex(0)
        return firstObject
    }
    

    
    func createView (numberOfBoxes : NSInteger) {
        let viewDimension : Int = Int(CGRectGetWidth(self.view.frame) - 22.0)
        let width : NSInteger = viewDimension / numberOfBoxes
        let height : NSInteger = width
        
        self.baseView = TouchableView(frame: CGRectMake(10, CGRectGetHeight(self.view.frame) - CGFloat(viewDimension) - 10 , CGFloat(viewDimension), CGFloat(viewDimension)))
        self.baseView?.backgroundColor = self.view.backgroundColor ?? UIColor.clearColor()
        self.view.addSubview(baseView!)
        
        var x : Int = 5, y : Int = 5
        let totalBoxes = numberOfBoxes * numberOfBoxes - 1
        for i in 0...totalBoxes
        {
            let newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(width) - 10, CGFloat(height) - 10))
            newLable.text = NSString(format: "%d", self.dataSet[i]) as String
            newLable.textColor = UIColor.whiteColor()
            newLable.color = baseView?.backgroundColor ?? UIColor.clearColor()
            newLable.textAlignment = NSTextAlignment.Center
            //newLable.font = UIFont(name: "Baskerville-SemiBold", size: )
            x += width ;
            if(CGFloat(x) >= CGRectGetWidth(baseView!.frame)) {
                x = 5
                y += height
                
            }
            
            let toRect = newLable.frame
            var fromRect = toRect
            fromRect.origin.y = (((arc4random()%2) == 1) ? -CGFloat((arc4random()%100)) - 600 : CGFloat((arc4random()%1000)) + 600)
            fromRect.origin.x = (((arc4random()%2) == 1) ? -CGFloat((arc4random()%100)) - 400 : CGFloat((arc4random()%1000)) + 400)
            newLable.frame = fromRect
            
            let animationDuration : NSTimeInterval = 0.3
            let delayInAnimation : NSTimeInterval = Double(i)*animationDuration
            let factor : Double = Double((arc4random()%5)) + 3
            UIView.animateWithDuration(animationDuration, delay:delayInAnimation/factor, usingSpringWithDamping: 0.9, initialSpringVelocity:5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                newLable.frame = toRect
                }, completion: nil)
            baseView!.addSubview(newLable)
            allBoxes.append(newLable)
        }
        dataSet.removeRange(0...totalBoxes)
        //dataSet.removeRange(Range(start: 0, end: totalBoxes + 1))
    }
    
    
    func drawUserInteractions() {
        
        let path = UIBezierPath()
        if let first = selectedBoxes.first {
            path.moveToPoint(first.center)
        }
        
        for box in selectedBoxes {
            path.addLineToPoint(box.center)
            
        }

        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = (currentStateForGame() == .StateCorrect) ? UIColor.greenColor().CGColor : UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 2.0;
        self.baseView?.layer.insertSublayer(shapeLayer, atIndex: 0)
        
        
        
    }
    
    func currentData() -> [Int] {
        var data = [Int]()
        
        for box in allBoxes {
            let text : NSString = box.text!
            let number = text.integerValue
            data.append(number)
        }
        
        return data
    }

}

