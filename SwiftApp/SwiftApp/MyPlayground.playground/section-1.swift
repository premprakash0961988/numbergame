// Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//
//var stringArray = ["c","ios","john","mark","moto","swift","taylor","amnkds"]
//
//var sortedStrings = sorted(stringArray) {
//    $0.uppercaseString < $1.uppercaseString
//}
//
//
//var word = "cafe"
//println("the number of characters in \(word) is \(countElements(word))")
//// prints "the number of characters in cafe is 4"
//
//word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
//
//println("the number of characters in \(word) is \(countElements(word))")
//// prints "the number of characters in café is 4"
//
//var myArr = [Int]()
//var something = 10
//
//
//myArr.append(3)
//myArr.append(5)
//myArr.append(10)
//
//for x in myArr {
//    println("\(x)")
//}
////println("\(myarr[1])")
//
//myArr.append(3)
//
//
//var newArray = [Int](count:5, repeatedValue : 1)
//
//newArray.removeAtIndex(1)
//
//var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
//
//var myFirstDict : [Int : String] = [11 : "ONE", 2 : "TWO"]
//
//
//myFirstDict.updateValue("It is not equal to 1", forKey: 11)
//var x = myFirstDict.updateValue("Seriously", forKey: 2)
//
//let allKeys = [Int]  (myFirstDict.keys)
//let allValues = [String]  (myFirstDict.values)
//
//println("\(allKeys)")
//println("\(allValues)")
//
//for (xKey, xValue) in myFirstDict {
//    println("\(xKey) ==  \(xValue)")
//}

var lable = UILabel(frame: CGRectMake(0, 0, 300, 300))
lable.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
lable.text = "Ghumaaaao"



let testLabel = UILabel(frame: CGRectMake(0, 0, 120, 40))
testLabel.text = "Hello, Swift!"
testLabel.textColor = UIColor.whiteColor()
testLabel.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
testLabel.textAlignment = NSTextAlignment.Center
testLabel.layer.masksToBounds = true
testLabel.layer.cornerRadius = 10

testLabel


let transitionOptions = UIViewAnimationOptions.TransitionCurlUp

UIView.transitionWithView(testLabel, duration: 2.0, options: transitionOptions, animations: {
    // remove the front object...
    
    // ... and add the other object
    testLabel.alpha = 0.3;
    testLabel
    }, completion: { finished in
        // any code entered here will be applied
        // .once the animation has completed
})


