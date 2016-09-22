//
//  ViewController+Operations.swift
//  SwiftApp
//
//  Created by Koovs on 22/09/16.
//  Copyright © 2016 Flipkart. All rights reserved.
//

import Foundation
import  UIKit


enum OperationType {
    case plus, minus, multiply, divide
}

class Operation {
    var title : String
    var operationType : OperationType
    
    init(title : String, operationType : OperationType ) {
        self.title = title
        self.operationType = operationType
    }
    
    func result(firstInput : Int, secondInput : Int) -> Int {
        var result = firstInput
        switch self.operationType {
        case OperationType.plus:
            result = firstInput + secondInput
            break
        case OperationType.minus:
            result = firstInput - secondInput
            break
        case OperationType.multiply:
            result = firstInput * secondInput
            break
        case OperationType.divide:
            result = firstInput / secondInput
            break
        }
        return result
    }
}

private let kOperationCell = "OperationCell"

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    
    func availableOperations() -> [Operation]  {
        var operations = [Operation]()
        operations.append(Operation(title: "+", operationType: .plus))
        operations.append(Operation(title: "-", operationType: .minus))
        operations.append(Operation(title: "*", operationType: .multiply))
        operations.append(Operation(title: "/", operationType: .divide))

        
        return operations
    }

    
    func addOperationsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let height : CGFloat = 60
        layout.itemSize = CGSize(width :self.view.frame.size.width/4, height : height )
        let frame = CGRect( x :0, y: currentEquationBoard!.frame.maxY + 10 , width : self.view.frame.size.width, height : height)
        operationsCollectionView = UICollectionView(frame: frame , collectionViewLayout: layout)
        operationsCollectionView?.dataSource = self
        operationsCollectionView?.delegate = self
        operationsCollectionView?.register(nibName: kOperationCell, forCellWithReuseIdentifier: kOperationCell)
        self.view.addSubview(operationsCollectionView!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableOperations().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kOperationCell, for: indexPath)
        configureOperationCell(cell: cell, indexPath: indexPath)
        return cell
    }

    func configureOperationCell(cell : UICollectionViewCell, indexPath : IndexPath) {
        if let operationCell = cell as? OperationCell {
            let operation = availableOperations()[indexPath.row]
            operationCell.label?.text = operation.title
            let color = (operation.title != selectedOperation.title) ? UIColor.clear : UIColor(red: 255, green: 198, blue: 0, alpha: 1)
            operationCell.backgroundColor = color
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedOperation = availableOperations()[indexPath.row]
        collectionView.reloadData()
    }
    
    
    
    
}

extension UICollectionView {
    
    func register(nibName : String, forCellWithReuseIdentifier identifier : String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

