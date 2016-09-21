//
//  ViewController.swift
//  SwiftApp
//
//  Created by Prem Chaurasiya on 29/09/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UserTouchDelegate {
    
    var allBoxes : [RoundedLable] = []
    var selectedBoxes = [RoundedLable]()
    var dataSet : [UInt32] = []
    var suggestions : [RoundedLable] = []
    var baseView : TouchableView?
    var upComingObjectView : UIScrollView?
    var scoreCard : UILabel?
    let shapeLayer = CAShapeLayer()
    let numberOfRows = 10
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColor.darkGray
        self.createScoreCard()
        self.creatDataSetForRows(numberOfRows)
        self.createView(numberOfRows)
        self.createUpComingObjects()
    }
    
    
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
    
    
    func createUpComingObjects() {
        
        var x : CGFloat = 0
        let y : CGFloat = 0
        let boxWidth : CGFloat = 80
        let boxHeight : CGFloat = 80
        
        upComingObjectView = UIScrollView(frame: CGRect(x: 0, y: scoreCard!.frame.maxY, width: self.view.frame.width, height: boxHeight))
        upComingObjectView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(upComingObjectView!)
        
        let count = dataSet.count
        let animationDuration : TimeInterval = 0.3
        let delayInAnimation : TimeInterval = 0.0
        let factor : Double = Double((arc4random()%5)) + 3
        
        for index in 0..<count {
            let nextObj : Int = Int(dataSet[index])
            
            let newLable : RoundedLable = RoundedLable(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(boxWidth) - 10, height: CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj) as String
            newLable.textColor = UIColor.lightGray
            newLable.roundedLabelState = RoundedLable.RoundedLabelState.stateDisabled
            newLable.textColor = UIColor.yellow
            scoreCard?.font = UIFont(name: "Baskerville-SemiBold", size: 13)
            newLable.textAlignment = NSTextAlignment.center
            x += boxWidth + 10
            
            var fromRect = newLable.frame
            let toRect = newLable.frame
            fromRect.origin.x -= 300
            newLable.frame = fromRect
            upComingObjectView?.addSubview(newLable)
            suggestions.append(newLable)
            UIView.animate(withDuration: animationDuration, delay:delayInAnimation/factor, usingSpringWithDamping: 0.9, initialSpringVelocity:5, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                newLable.frame = toRect
                }, completion: nil)
            
        }
        upComingObjectView?.contentSize = CGSize(width: x , height: boxHeight)
        
    }
    
    func removeObjectsForIndex( _ numberOfObjects : Int ) {
        var xMargin : CGFloat = 0
        var allObjects = suggestions
        var originX : CGFloat = 0
        for index in 0..<allObjects.count {
            let upcomingObject : RoundedLable = allObjects[index]
            if(index < numberOfObjects) {
                suggestions.remove(at: 0)
                xMargin = upcomingObject.frame.maxX
                UIView.animate (withDuration: 0.5, delay:1.0, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                    upcomingObject.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    }, completion: { finished in
                        upcomingObject.removeFromSuperview()
                        
                })
            }
            else {
                originX = upcomingObject.frame.origin.x - xMargin
                var toFrame : CGRect = upcomingObject.frame
                toFrame.origin.x = originX
                UIView.animate (withDuration: 0.5, delay:1.0, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                    upcomingObject.frame = toFrame
                    }, completion:nil)
            }
        }
        self.addUpComingObject(numberOfObjects, xOrigin: originX)
    }
    
    func addUpComingObject (_ numberOfObjects : Int , xOrigin : CGFloat ) {
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
            let newLable : RoundedLable = RoundedLable(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(boxWidth) - 10, height: CGFloat(boxWidth) - 10))
            newLable.text = NSString(format: "%d", nextObj) as String
            newLable.textColor = UIColor.lightGray
            newLable.roundedLabelState = RoundedLable.RoundedLabelState.stateDisabled
            newLable.textColor = UIColor.yellow
            newLable.textAlignment = NSTextAlignment.center
            upComingObjectView?.addSubview(newLable)
            suggestions.append(newLable)

            x += boxWidth + 10
        }
        
        
        upComingObjectView?.contentSize = CGSize(width: x , height: boxHeight)


    }
    
    
    
    func creatDataSetForRows(_ numberOfBoxes : NSInteger) {
        let totalBoxes = numberOfBoxes * numberOfBoxes
        for _ in 0...totalBoxes*2 {
            let newInt : UInt32 = (arc4random()%20) + 1
            self.dataSet.append(newInt)
        }
    }
    
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
                    selectedBoxes.append(box)
                    self.configureBoxes()
                }
                break;
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.addChildWithTouch(touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.addChildWithTouch(touch)
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetViews()
    }
    
    
    
    
    
    func addChildWithTouch(_ touch : UITouch) {
        if let view = touch.view {
            let touchedView : UIView = (view)
            if(touchedView == self.baseView) {
                let location : CGPoint = (touch.location(in: touch.view))
                for box  in allBoxes {
                    if(box.ineractiveFrame().contains(location)) {
                        let index = selectedBoxes.index(of: box)
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
        for (index, _) in selectedBoxes.enumerated() {
            let label : RoundedLable = selectedBoxes[index]
            label.setRoundedLabelState(state)
        }
        drawUserInteractions()
    }
    
    func currentStateForGame() -> RoundedLable.RoundedLabelState {
        var total = 0
        var roundedLabelState  = RoundedLable.RoundedLabelState.stateInCorrect;
        for (index, _) in selectedBoxes.enumerated() {
            let label : RoundedLable = selectedBoxes[index]
            let text  = label.text!
            let number = Int(text) ?? 0
            if(index == selectedBoxes.count - 1 && number == total) {
                roundedLabelState = RoundedLable.RoundedLabelState.stateCorrect;
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
        for (index, _) in selectedBoxes.enumerated() {
            let label : RoundedLable = selectedBoxes[index]
            let state = self.currentStateForGame()
            if(state == RoundedLable.RoundedLabelState.stateCorrect) {
                let value = Int(label.text ?? "0")
                //scoreEarned += value! * Int(pow(Double(10), Double(numberOfBoxes)))
                scoreEarned += value! * numberOfBoxes //Int(pow(Double(10), Double(numberOfBoxes)))
                //var animationDuration : NSTimeInterval = 0.3
                //
                
                let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    self.drawUserInteractions()
                }

                

                let delayTime1 = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: delayTime1) {
                    IntelligentGuy.calculateAllPossibleOptions(self.currentData())
                    
                }

                
                UIView.animate (withDuration: 0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                    label.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    
                    }, completion: { finished in
                        
                        UIView.animate (withDuration: 0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                            label.transform = CGAffineTransform.identity
                            label.text = NSString(format: "%d", self.objectForNextIndex()) as String
                            label.setRoundedLabelState(RoundedLable.RoundedLabelState.stateUnTouched)
                            
                            }, completion: { finished in
                               
                        })
                })
            }
            else {
                label.setRoundedLabelState(RoundedLable.RoundedLabelState.stateUnTouched)
                self.drawUserInteractions()
            }
        }
        if(scoreEarned != previousScore) {
            self.setUserScore(scoreEarned)
            self.removeObjectsForIndex(numberOfBoxes)
        }
        selectedBoxes.removeAll()
        self.drawUserInteractions()
        
    }
    
    
    func setUserScore(_ score : Int) {
        let scoreCard : UILabel = self.scoreCard!
        UIView.animate (withDuration: 0.5, delay:0.5, usingSpringWithDamping:0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            scoreCard.text = NSString(format: "%d", score) as String
            }, completion: { finished in
                
        })
        
    }
    
    
    func objectForNextIndex() -> Int {
//        if(dataSet.count < numberOfRows*numberOfRows) {
//            self.creatDataSetForRows(numberOfRows)
//        }

        let firstObject : Int = Int(dataSet[0])
        dataSet.remove(at: 0)
        return firstObject
    }
    
    
    func createView (_ numberOfBoxes : NSInteger) {
        let viewDimension : Int = Int(self.view.frame.width - 22.0)
        let width : NSInteger = viewDimension / numberOfBoxes
        let height : NSInteger = width
        
        self.baseView = TouchableView(frame: CGRect(x: 10, y: self.view.frame.height - CGFloat(viewDimension) - 10 , width: CGFloat(viewDimension), height: CGFloat(viewDimension)))
        baseView?.delegate = self
        baseView?.subView.touchDelegate = self
        self.baseView?.backgroundColor = self.view.backgroundColor ?? UIColor.clear
        
        self.view.addSubview(baseView!)
        
        var x : Int = 5, y : Int = 5
        let totalBoxes = numberOfBoxes * numberOfBoxes - 1
        for i in 0...totalBoxes
        {
            let newLable : RoundedLable = RoundedLable(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width) - 10, height: CGFloat(height) - 10))
            newLable.text = NSString(format: "%d", self.dataSet[i]) as String
            newLable.textColor = UIColor.white
            newLable.color = baseView?.backgroundColor ?? UIColor.clear
            newLable.textAlignment = NSTextAlignment.center
            //newLable.font = UIFont(name: "Baskerville-SemiBold", size: )
            x += width ;
            if(CGFloat(x) >= baseView!.frame.width) {
                x = 5
                y += height
                
            }
            
            let toRect = newLable.frame
            var fromRect = toRect
            fromRect.origin.y = (((arc4random()%2) == 1) ? -CGFloat((arc4random()%100)) - 600 : CGFloat((arc4random()%1000)) + 600)
            fromRect.origin.x = (((arc4random()%2) == 1) ? -CGFloat((arc4random()%100)) - 400 : CGFloat((arc4random()%1000)) + 400)
            newLable.frame = fromRect
            
            let animationDuration : TimeInterval = 0.3
            let delayInAnimation : TimeInterval = Double(i)*animationDuration
            let factor : Double = Double((arc4random()%5)) + 3
            UIView.animate(withDuration: animationDuration, delay:delayInAnimation/factor, usingSpringWithDamping: 0.9, initialSpringVelocity:5, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
                newLable.frame = toRect
                }, completion: nil)
            baseView?.subView.addSubview(newLable)
            allBoxes.append(newLable)
        }
        dataSet.removeSubrange(0...totalBoxes)
        //dataSet.removeRange(Range(start: 0, end: totalBoxes + 1))
    }
    
    
    func drawUserInteractions() {
        
        let path = UIBezierPath()
        if let first = selectedBoxes.first {
            path.move(to: first.center)
        }
        
        for box in selectedBoxes {
            let x = baseView!.zoomScale * box.center.x
            let y = baseView!.zoomScale * box.center.y
            path.addLine(to: CGPoint(x:x,y:y))
            
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = (currentStateForGame() == .stateCorrect) ? UIColor.green.cgColor : UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0;
        self.baseView?.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func showUserStatus() {
//        var userInput = ""
 //       for box in selectedBoxes {
//            userInput
            
//        }
    }
    
    func currentData() -> [Int] {
        var data = [Int]()
        
        for box in allBoxes {
            let text  = box.text!
            let number = Int(text) ?? 0
            data.append(number)
        }
        
        return data
    }

    @IBAction func touchUpInside() {
        print("touchUpInside")
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return (scrollView as? TouchableView)?.subView
    }
}

