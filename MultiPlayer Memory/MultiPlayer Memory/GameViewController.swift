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
    
    @IBOutlet weak var p1view: UIView!
    @IBOutlet weak var p2view: UIView!
    
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p1Label: UILabel!
    @IBOutlet weak var p1Points: UILabel!
    @IBOutlet weak var p2Points: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    @IBOutlet weak var p2Label: UILabel!
    
    @IBOutlet weak var turnsLabel: UILabel!
    
    
    var players : Int = 1
    var player1 : Player = Player()
    var player2 : Player = Player()
    
    var brickImages : [UIImage] = []
    
    
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
    var turnsVal = 0
    
    func configureView() {
        cellIdsArray = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
        
        if let diff = self.difficulty {
            if diff == Difficulty.Easy {
                //TODO: change size of board
            }
            else {
                //TODO: change size of board
            }
        }
        
        if let view = p1view {
            view.backgroundColor = UIColor.orange
            player1 = Player(id: 1, turn: true, view: p1view, pLabel: p1Label, pointLabel: p1PointsLabel, pointValLabel: p1Points)
            player2 = Player(id: 2, turn: false, view: p2view, pLabel: p2Label, pointLabel: p2PointsLabel, pointValLabel: p2Points)
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
        
        print(brickImages.count)
        // Configure the cell
        cell.backgroundColor = UIColor.black
        let randomValue = Int(arc4random_uniform(UInt32(cellIdsArray.count)))
        cell.id = cellIdsArray[randomValue]
        cellIdsArray.remove(at: randomValue)
        
        switch cell.id {
        case 0:
            if brickImages.count > 0 {
                cell.imageView.image = brickImages[0]
            } else {
                cell.color = UIColor.blue
            }
            break
        case 1:
            if brickImages.count > 1 {
                cell.imageView.image = brickImages[1]
            } else {
                cell.color = UIColor.brown
            }
            break
        case 2:
            if brickImages.count > 2 {
                cell.imageView.image = brickImages[2]
            } else {
                cell.color = UIColor.cyan
            }
            break
        case 3:
            if brickImages.count > 3 {
                cell.imageView.image = brickImages[3]
            } else {
                cell.color = UIColor.green
            }
            break
        case 4:
            if brickImages.count > 4 {
                cell.imageView.image = brickImages[4]
            } else {
                cell.color = UIColor.orange
            }
            break
        case 5:
            if brickImages.count > 5 {
                cell.imageView.image = brickImages[5]
            } else {
                cell.color = UIColor.magenta
            }
            break
        case 6:
            if brickImages.count > 6 {
                cell.imageView.image = brickImages[6]
            } else {
                cell.color = UIColor.yellow
            }
            break
        case 7:
            if brickImages.count > 7 {
                cell.imageView.image = brickImages[7]
            } else {
                cell.color = UIColor.gray
            }
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
        cell.imageView.isHidden = true
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
            bricks[closeBricksIndex[0]].close()
            bricks[closeBricksIndex[1]].close()
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
                        if player1.isTurn() {
                            player1.addPoint()
                        } else if player2.isTurn() {
                            player2.addPoint()
                        }
                        
                        var bricksLeft = true
                        for index in 0...15 {
                            if !openBricks[index] {
                                bricksLeft = false
                            }
                        }
                        if bricksLeft {
                            var winner : String
                            let alertMessage = "Game is finished"
                            if player1.points > player2.points {
                                winner = "Player 1 wins!"
                            } else if player2.points > player1.points {
                                winner = "Player 2 wins!"
                            } else {
                                winner = "It's a draw!"
                            }
                            let alert = UIAlertController(title: alertMessage, message: winner, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
                            self.present(alert, animated: true, completion:{})
                        }
                    }
                    else {
                        print("DEBUG: TWO UNMATCHING BRICKS")
                        closeBricks = true
                        closeBricksIndex.append(i)
                        closeBricksIndex.append(brick.brickMatchId)
                        turnsVal += 1
                        turnsLabel.text = "\(turnsVal)"
                        player1.changeTurn()
                        player2.changeTurn()
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
