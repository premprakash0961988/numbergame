//
//  ViewController.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/09/14.
//  Copyright (c) 2014 Flipkart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allBoxes : [UILabel] = []
    var selectedBoxes : NSMutableArray = []
    var dataSet : [UInt32] = []
    var suggestions : [RoundedLable] = []
    var baseView : TouchableView?
    var upComingObjectView : UIScrollView?
    var scoreCard : UILabel?
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
        var headingLabel = UILabel(frame: CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 35))
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
        var animationDuration : NSTimeInterval = 0.3
        var delayInAnimation : NSTimeInterval = 0.0
        var factor : Double = Double((arc4random()%5)) + 3
        
        for index in 0..<count {
            let nextObj : Int = Int(dataSet[index])
            
            var newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(boxWidth) - 10, CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj)
            newLable.textColor = UIColor.lightGrayColor()
            newLable.roundedLabelState = RoundedLable.RoundedLabelState.StateDisabled
            newLable.textColor = UIColor.yellowColor()
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
            var upcomingObject : RoundedLable = allObjects[index]
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
                println(toFrame)
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
        
        
        for _ in 0...numberOfObjects {
            let newInt : UInt32 = (arc4random()%20) + 1
            self.dataSet.append(newInt)
        }
        

        for index in 0..<numberOfObjects {
            let nextObj : Int = Int(dataSet[self.suggestions.count + index])
            
            var newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(boxWidth) - 10, CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj)
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
        var totalBoxes = numberOfBoxes * numberOfBoxes - 1
        for _ in 0...totalBoxes*2 {
            let newInt : UInt32 = (arc4random()%20) + 1
            self.dataSet.append(newInt)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        self.addChildWithTouch(touch)
    }
    
    override  func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        self.addChildWithTouch(touch)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.resetViews()
    }
    
    func addChildWithTouch(touch : UITouch) {
        var touchedView : UIView = (touch.view)
        if(touchedView == self.baseView) {
            let location : CGPoint = (touch.locationInView(touch.view))
            for box  in allBoxes {
                if(box.frame.contains(location)) {
                    let index = selectedBoxes.indexOfObject(box)
                    if(index == NSNotFound) {
                        selectedBoxes.addObject(box)
                        self.configureBoxes()
                    }
                    break;
                }
            }
        }
    }
    
    func configureBoxes(){
        var state = self.currentStateForGame()
        for (index, value) in enumerate(selectedBoxes) {
            let label : RoundedLable = selectedBoxes.objectAtIndex(index) as RoundedLable
            label.setRoundedLabelState(state)
        }
    }
    
    func currentStateForGame() -> RoundedLable.RoundedLabelState {
        var total = 0
        var roundedLabelState  = RoundedLable.RoundedLabelState.StateInCorrect;
        for (index, value) in enumerate(selectedBoxes) {
            let label : RoundedLable = selectedBoxes.objectAtIndex(index) as RoundedLable
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
        let previousScore = self.scoreCard?.text?.toInt()
        var scoreEarned : Int = previousScore!
        let numberOfBoxes = selectedBoxes.count
        for (index, value) in enumerate(selectedBoxes) {
            let label : RoundedLable = selectedBoxes.objectAtIndex(index) as RoundedLable
            var state = self.currentStateForGame()
            if(state == RoundedLable.RoundedLabelState.StateCorrect) {
                let value = label.text?.toInt()
                scoreEarned += value! * Int(pow(Double(10), Double(numberOfBoxes)))
                var animationDuration : NSTimeInterval = 0.3
                
                UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    label.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    }, completion: { finished in
                        UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                            label.transform = CGAffineTransformIdentity
                            label.text = NSString(format: "%d", self.objectForNextIndex())
                            label.setRoundedLabelState(RoundedLable.RoundedLabelState.StateUnTouched)
                            
                            }, completion: { finished in
                                
                        })
                })
            }
            else {
                label.setRoundedLabelState(RoundedLable.RoundedLabelState.StateUnTouched)
            }
        }
        if(scoreEarned != previousScore) {
            self.setUserScore(scoreEarned)
            self.removeObjectsForIndex(numberOfBoxes)
        }
        selectedBoxes.removeAllObjects()
    }
    
    
    func setUserScore(score : Int) {
        var scoreCard : UILabel = self.scoreCard!
        UIView.animateWithDuration (0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            scoreCard.text = NSString(format: "%d", score)
            }, completion: { finished in
                
        })
        
    }
    
    
    func objectForNextIndex() -> Int {
        if(dataSet.count < numberOfRows*numberOfRows) {
            self.creatDataSetForRows(numberOfRows)
        }
        let firstObject : Int = Int(dataSet[0])
        dataSet.removeAtIndex(0)
        return firstObject
    }
    
    func createView (numberOfBoxes : NSInteger) {
        let viewDimension : Int = Int(CGRectGetWidth(self.view.frame) - 22.0)
        var width : NSInteger = viewDimension / numberOfBoxes
        let height : NSInteger = width
        
        self.baseView = TouchableView(frame: CGRectMake(10, CGRectGetHeight(self.view.frame) - CGFloat(viewDimension) - 10 , CGFloat(viewDimension), CGFloat(viewDimension)))
        self.view.addSubview(baseView!)
        
        var x : Int = 5, y : Int = 5
        var totalBoxes = numberOfBoxes * numberOfBoxes - 1
        for i in 0...totalBoxes
        {
            var newLable : RoundedLable = RoundedLable(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(width) - 10, CGFloat(height) - 10))
            newLable.text = NSString(format: "%d", self.dataSet[i])
            newLable.textColor = UIColor.whiteColor()
            newLable.textAlignment = NSTextAlignment.Center
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
            
            var animationDuration : NSTimeInterval = 0.3
            var delayInAnimation : NSTimeInterval = Double(i)*animationDuration
            var factor : Double = Double((arc4random()%5)) + 3
            UIView.animateWithDuration(animationDuration, delay:delayInAnimation/factor, usingSpringWithDamping: 0.9, initialSpringVelocity:5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                newLable.frame = toRect
                }, completion: nil)
            baseView!.addSubview(newLable)
            allBoxes.append(newLable)
        }
        dataSet.removeRange(Range(start: 0, end: totalBoxes + 1))
    }

}

