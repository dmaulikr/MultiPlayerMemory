//
//  GameViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-07.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var turnsLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    
    private var deck: Array<Int>? {
        didSet{
            self.configureView()
        }
    }
    
    var difficulty: Difficulty? {
        didSet{
            self.configureView()
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    var cellAlg : Bool = false
    var closeBricks : Bool = false
    var closeBricksIndex : [Int] = []
    var cellIds = 0
    var cellMatchId = 0
    var bricks : [Brick] = []
    var openBricks : [Bool] = []
    var cellIdsArray : [Int] = []
    
    func configureView() {
        cellIdsArray = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
        
        if let diff = self.difficulty {
            if diff == Difficulty.Easy {
                if let label = diffLabel {
                    label.text = "Easy"
                    
                }
            }
            else {
                diffLabel.text = "Hard"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return 16
    }
    
    //init bricks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Brick
        
        // Configure the cell
        cell.backgroundColor = UIColor.black
        let randomValue = Int(arc4random_uniform(UInt32(cellIdsArray.count)))
        cell.id = cellIdsArray[randomValue]
        cellIdsArray.remove(at: randomValue)
        
        switch cell.id {
        case 0:
            cell.color = UIColor.blue
            break
        case 1:
            cell.color = UIColor.brown
            break
        case 2:
            cell.color = UIColor.cyan
            break
        case 3:
            cell.color = UIColor.green
            break
        case 4:
            cell.color = UIColor.orange
            break
        case 5:
            cell.color = UIColor.magenta
            break
        case 6:
            cell.color = UIColor.yellow
            break
        case 7:
            cell.color = UIColor.gray
            break
        default: break
        }
        
        if cellAlg {
            cellAlg = false
            cellIds+=1
        } else {
            cellAlg = true
        }
        cell.brickMatchId = cellMatchId
        cellMatchId += 1
        
        bricks.append(cell)
        openBricks.append(false)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let brick = collectionView.cellForItem(at: indexPath) as! Brick
        
        if closeBricks {
            closeBricks = false
            bricks[closeBricksIndex[0]].backgroundColor = UIColor.black
            bricks[closeBricksIndex[1]].backgroundColor = UIColor.black
            bricks[closeBricksIndex[0]].open = false
            bricks[closeBricksIndex[1]].open = false
            closeBricksIndex = []
        }
        
        brick.click()
        
        
        print("print working")
        
        for i in 0...bricks.count-1 {
            print(bricks[i].id)
            if openBricks[i] {
                
            }
            else if bricks[i].isOpen() {
                if bricks[i].brickMatchId != brick.brickMatchId {
                    print("DEBUG: NOT SAME BRICKS")
                    if bricks[i].id == brick.id {
                        print("DEBUG: TWO MATCHING BRICKS")
                        bricks[i].isMatch()
                        brick.isMatch()
                        openBricks[i] = true
                        openBricks[brick.brickMatchId] = true
                    }
                    else {
                        print("DEBUG: TWO UNMATCHING BRICKS")
                        closeBricks = true
                        closeBricksIndex.append(i)
                        closeBricksIndex.append(brick.brickMatchId)
                    }
                }
                else {
                    print("DEBUG: SAME BRICKS")
                }
            }
        }
        
        
        return false
    }
    
    
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {        return true
    }
    
    
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    }
}
