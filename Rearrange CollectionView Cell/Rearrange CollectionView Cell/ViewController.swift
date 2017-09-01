//
//  ViewController.swift
//  Rearrange CollectionView Cell
//
//  Created by Appinventiv Technologies on 01/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//---------------- Outlet's ---------------
    @IBOutlet weak var collectionView: UICollectionView!
//---------------- variable's ------------
    var longPressGesture : UILongPressGestureRecognizer!
    var listData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","1","2","3","4","5","6","7","8","9","10","11","12","13","14","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","1","2","3","4","5","6","7","8","9","10","11","12","13","14","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","1","2","3","4","5","6","7","8","9","10","11","12","13","14","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
//---------------- ViewDidload method -----------
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
// --------------------------------------
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongGesture(gesture:)))
        self.collectionView?.addGestureRecognizer(longPressGesture)
        longPressGesture.minimumPressDuration = 0.0001
    }
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }

    
}
//========================= Extension of viewController ==================
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else{fatalError()}
        cell.cellLabel.text = listData[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = self.listData[sourceIndexPath.item]
        self.listData.remove(at: sourceIndexPath.item)
        self.listData.insert(item, at: destinationIndexPath.item)
    }
   
//=======================================
    
    
}

//========== Class for collectionview cell ============
class CollectionCell: UICollectionViewCell {
//----------- Outlet's --------------
    @IBOutlet weak var cellLabel: UILabel!
    var interactiveIndexPath : NSIndexPath?
    var interactiveView : UIView?
    
}

