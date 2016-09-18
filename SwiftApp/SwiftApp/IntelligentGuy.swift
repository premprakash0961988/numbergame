//
//  IntelligentGuy.swift
//  SwiftApp
//
//  Created by Prem Prakash on 20/06/16.
//  Copyright © 2016 Flipkart. All rights reserved.
//

import Foundation


class  IntelligentGuy: NSObject {
    static var connectionPaths = [Stack]()
    
    
    
    class func calculateAllPossibleOptions(_ dataSet : [Int])  {
        connectionPaths.removeAll()
        let rows = Int(sqrt(Double(dataSet.count)))
        var input : [[Object]] = Array(repeating: Array(repeating: Object(value: 1), count: rows), count: rows)
        var i = 0
        var j = 0
        
        for value in dataSet {
            input[i][j] = Object(value: value)
            i = i + 1
            if i == rows  {
                i = 0
                j = j+1
            }
            
        }
        
        print(dataSet)
        
        
        i = 0
        j = 0

        var m = 0
        var n = 0

        
        while (i < rows - 1 || j < rows - 1) {

            if m == rows - 1  {
                if n == rows - 1 {
                    m = i
                    n = j
                    
                    if i == rows - 1 {
                        if j == rows - 1 {
                            
                        }
                        else {
                            j = j + 1
                            i = 0
                            
                        }
                    }
                    else {
                        i = i + 1
                    }
                }
                else {
                    n = n + 1
                    m = 0
                }
            }
            else {
                m = m + 1
            }
            
            
            let connectionPath = Stack()
            connectionPath.array.append((i, j))
            findAllPaths((i, j), targetNode: (m, n), connectionPath : connectionPath, input : input)

        }
        
        
        
        connectionPaths.count
        
        for path in  connectionPaths {
            path.printDesc()
            print("\n")
        }

    }

    
    class func findAllPaths(_ sourceNode : (i : Int, j: Int), targetNode : (i : Int, j: Int), connectionPath : Stack, input : [[Object]] )  {
        let allAdjectentNodes = adjecentNodes(sourceNode, iMax: input.count, jMax: input.count)
        
        for nextNode in allAdjectentNodes {
            
            if (nextNode.0 == targetNode.i && nextNode.1 == targetNode.j) {
                if connectionPath.currentSum(input) == input[targetNode.i][targetNode.j].value {
                    let tempStack = Stack()
                    for node1 in connectionPath.allObjects() {
                        tempStack.push(node1)
                    }
                    tempStack.push(nextNode)
                    connectionPaths.append(tempStack)
                }
            }
            else if !connectionPath.contains(nextNode) {
                let newConnectionPath = Stack()
                newConnectionPath.array += connectionPath.allObjects()
                newConnectionPath.push(nextNode)
                if newConnectionPath.currentSum(input) <= input[targetNode.i][targetNode.j].value  {
                    findAllPaths(nextNode, targetNode: targetNode, connectionPath : newConnectionPath,input: input)
                }
            }
        }
    }

    
    class func adjecentNodes(_ node : (i : Int, j : Int), iMax : Int, jMax : Int) -> [(Int,Int)] {
        var result = [(Int,Int)]()
        
        
        let canGoLeft  = (node.i > 0)
        let canGoRight = (node.i < iMax - 1)
        let canGoUp = (node.j > 0)
        let canGoDown = (node.j < jMax - 1)
        let canGoUpRight = canGoUp && canGoRight
        let canGoDownRight = canGoDown && canGoRight
        let canGoUpLeft = canGoUp && canGoLeft
        let canGoDownLeft = canGoDown && canGoLeft
        
        
        if canGoLeft {
            result.append((node.i - 1, node.j))
        }
        
        if canGoRight {
            result.append((node.i + 1, node.j))
        }
        
        if canGoUp {
            result.append((node.i, node.j - 1))
        }
        
        if canGoDown {
            result.append((node.i, node.j + 1))
        }
        
        if canGoUpRight {
            result.append((node.i + 1, node.j - 1))
        }
        
        if canGoDownRight {
            result.append((node.i + 1, node.j + 1))
        }
        
        if canGoUpLeft {
            result.append((node.i - 1 , node.j - 1))
        }
        
        if canGoDownLeft {
            result.append((node.i - 1 , node.j + 1))
        }
        
        return result
    }
    

    
}





struct Object {
    var value : Int
    var depth : Int = 0
    
    init(value : Int) {
        self.value = value
    }
}


class Stack : NSObject {
    var array = [(Int,Int)]()
    
    func push(_ element : (Int,Int)) {
        array.append(element)
    }
    
    func pop() -> (Int,Int)? {
        let last = array.last
        array.removeLast()
        return last
    }
    
    func allObjects() -> [(Int,Int)] {
        return array
    }
    
    func contains(_ Obj :(Int,Int)) -> Bool {
        return array.contains(where: { (i, j) -> Bool in
            return (i == Obj.0 && j == Obj.1)
        })
    }
    
    func printDesc() {
        for x in array {
            print(x)
        }
    }
    
    
    func currentSum(_ input : [[Object]]) -> Int {
        var sum : Int = 0
        for obj in array {
            sum += input[obj.0][obj.1].value
        }
        return sum
    }
}
