//
//  CollectionViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-10.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    var pairs = 0
    var cellIds = 0
    var cellAlg : Bool = false
    var bricks : [Brick] = []
    var openBricks : [Brick] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        print("anyone?")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Brick
    
        // Configure the cell
        cell.backgroundColor = UIColor.black
        if(pairs < 2) {
            cell.color = UIColor.blue
        } else if (pairs < 4 && pairs >= 2){
            cell.color = UIColor.green
        } else if (pairs < 6 && pairs >= 4){
            cell.color = UIColor.red
        } else if (pairs < 8 && pairs >= 6){
            cell.color = UIColor.cyan
        } else if (pairs < 10 && pairs >= 8){
            cell.color = UIColor.brown
        } else if (pairs < 12 && pairs >= 10){
            cell.color = UIColor.darkGray
        } else if (pairs < 14 && pairs >= 12){
            cell.color = UIColor.gray
        } else if (pairs < 16 && pairs >= 14){
            cell.color = UIColor.orange
        }
        cell.id = pairs
        cell.brickMatchId = cellIds
        
        if cellAlg {
            cellIds += 1
            cellAlg = false
        } else {
            cellAlg = true
        }
        
        
        bricks.append(cell)
        
        pairs+=1
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
        
        return headerView
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let brick = collectionView.cellForItem(at: indexPath) as! Brick
        brick.click()
        //add that the brick is open if its not the same brick that is in there
        openBricks.append(brick)
        
        print("print working")
        for i in 0...15 {
            print(bricks[i].id)
            if bricks[i].id == brick.id {
                print("DEBUG: BRICKS MATCH")
                if indexPath.count != i {
                    print("DEBUG: INDEXES NOT EQUAL")
                }
            }
        }
        
        print(4)
        return true
    }
    

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {    }
    
    

}
