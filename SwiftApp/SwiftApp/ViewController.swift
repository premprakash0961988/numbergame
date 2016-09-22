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
    var baseView : TouchableView?
    var operationsCollectionView : UICollectionView?
    var currentEquationBoard : UILabel?
    var scoreCard : UILabel?
    let shapeLayer = CAShapeLayer()
    let numberOfRows = 4
    var selectedOperation : Operation!
    var boxWindow : UIWindow!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColor.darkGray
        createScoreCard()
        createEquationBoard()
        addOperationsView()
        creatDataSetForRows(numberOfRows)
        createView(numberOfRows)
        selectedOperation = availableOperations().first
        
        self.view.isMultipleTouchEnabled = true
    }
    
    
    
    
    
    func createView (_ numberOfBoxes : NSInteger) {
        let viewDimension : Int = Int(self.view.frame.width - 22.0)
        let width : NSInteger = viewDimension / numberOfBoxes
        let height : NSInteger = width
        
        let frame =  CGRect(x: 10, y: self.view.frame.height - CGFloat(viewDimension) - 10 , width: CGFloat(viewDimension), height: CGFloat(viewDimension))
        boxWindow = UIWindow()
        boxWindow.frame = frame
        boxWindow.makeKeyAndVisible()

        
        self.baseView = TouchableView(frame: boxWindow.bounds)
        baseView?.delegate = self
        baseView?.subView.touchDelegate = self
        self.baseView?.backgroundColor = self.view.backgroundColor ?? UIColor.clear
        
        boxWindow.addSubview(baseView!)
        
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
        
    }
    

    func creatDataSetForRows(_ numberOfBoxes : NSInteger) {
        let totalBoxes = numberOfBoxes * numberOfBoxes
        for _ in 0...totalBoxes*2 {
            let newInt : UInt32 = (arc4random()%20) + 1
            self.dataSet.append(newInt)
        }
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
                total = label.operation.result(firstInput: total, secondInput: number)
            }
        }
        return roundedLabelState;
    }
    
    func currentEquationResult() -> Int {
        var total = 0
        for (index, _) in selectedBoxes.enumerated() {
            let label : RoundedLable = selectedBoxes[index]
            let text  = label.text!
            let number = Int(text) ?? 0
            total = label.operation.result(firstInput: total, secondInput: number)
        }
        return total
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
                scoreEarned += value! * numberOfBoxes //Int(pow(Double(10), Double(numberOfBoxes)))
                
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
        return Int(arc4random())%30
    }
    
    
    

    func showUserStatus() {
        
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


