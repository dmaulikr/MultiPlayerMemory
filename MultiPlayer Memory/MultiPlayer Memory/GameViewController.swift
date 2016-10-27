//
//  GameViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 2016-10-07.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pointMsg: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var p1view: UIView!
    @IBOutlet weak var p2view: UIView!
    
    
    @IBOutlet weak var p1Points: UILabel!
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p1Label: UILabel!
    @IBOutlet weak var p2Points: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    @IBOutlet weak var p2Label: UILabel!
    
    @IBOutlet weak var turnsLabel: UILabel!
    
    @IBAction func back(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var players : Int = 1
    var player1 : Player = Player()
    var player2 : Player = Player()
    
    var brickImages : [UIImage] = []
    
    
    var difficulty: Difficulty? {
        didSet{
            self.configureView()
        }
    }
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "pling", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as Error {
            print(error.localizedDescription)
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
        
        print(difficulty!)
        if let diff = self.difficulty {
            if diff == Difficulty.Easy {
                cellIdsArray = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
            }
            else {
                for index in 0...15 {
                    cellIdsArray.append(index)
                    cellIdsArray.append(index)
                }
            }
        }
        
        if let view = p1view {
            if(players > 1) {
                player2 = Player(id: 2, turn: false, view: p2view, pLabel: p2Label, pointLabel: p2PointsLabel, pointValLabel: p2Points)
                view.backgroundColor = UIColor(red:90.0/255, green:200.0/255, blue:250.0/255, alpha:1.0)
            } else {
                p1PointsLabel.isHidden = true
                p1Points.isHidden = true
                p2Label.isHidden = true
                p2PointsLabel.isHidden = true
                p2Points.isHidden = true
            }
            player1 = Player(id: 1, turn: true, view: p1view, pLabel: p1Label, pointLabel: p1PointsLabel, pointValLabel: p1Points)
        }
        
        backBtn.layer.cornerRadius = 3
        backBtn.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()        
        pointMsg.alpha = 0.0
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
        
        return cellIdsArray.count
    }
    
    //init bricks
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Brick
        print(brickImages.count)
        // Configure the cell
        let randomValue = Int(arc4random_uniform(UInt32(cellIdsArray.count)))
        cell.id = cellIdsArray[randomValue]
        cellIdsArray.remove(at: randomValue)
        switch cell.id {
        case 0:
            if brickImages.count > 0 {
                cell.frontImage = brickImages[0]
            } else {
                cell.color = UIColor.blue
            }
            break
        case 1:
            if brickImages.count > 1 {
                cell.frontImage = brickImages[1]
            } else {
                cell.color = UIColor.brown
            }
            break
        case 2:
            if brickImages.count > 2 {
                cell.frontImage = brickImages[2]
            } else {
                cell.color = UIColor.cyan
            }
            break
        case 3:
            if brickImages.count > 3 {
                cell.frontImage = brickImages[3]
            } else {
                cell.color = UIColor.green
            }
            break
        case 4:
            if brickImages.count > 4 {
                cell.frontImage = brickImages[4]
            } else {
                cell.color = UIColor.orange
            }
            break
        case 5:
            if brickImages.count > 5 {
                cell.frontImage = brickImages[5]
            } else {
                cell.color = UIColor.magenta
            }
            break
        case 6:
            if brickImages.count > 6 {
                cell.frontImage = brickImages[6]
            } else {
                cell.color = UIColor.yellow
            }
            break
        case 7:
            if brickImages.count > 7 {
                cell.frontImage = brickImages[7]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 8:
            if brickImages.count > 8 {
                cell.frontImage = brickImages[8]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 9:
            if brickImages.count > 9 {
                cell.frontImage = brickImages[9]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 10:
            if brickImages.count > 10 {
                cell.frontImage = brickImages[10]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 11:
            if brickImages.count > 11 {
                cell.frontImage = brickImages[11]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 12:
            if brickImages.count > 12 {
                cell.frontImage = brickImages[12]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 13:
            if brickImages.count > 13 {
                cell.frontImage = brickImages[13]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 14:
            if brickImages.count > 14 {
                cell.frontImage = brickImages[14]
            } else {
                cell.color = UIColor.gray
            }
            break
        case 15:
            if brickImages.count > 15 {
                cell.frontImage = brickImages[15]
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
        cell.imageView.image = cell.backgroundImage
        bricks.append(cell)
        openBricks.append(false)
        
        return cell
    }
    
    func fadeViewInThenOut(view : UIView) {
        
        let delay = 1
        let animationDuration = 0.5
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        }) { (Bool) -> Void in
            
            UIView.animate(withDuration: animationDuration, delay: TimeInterval(delay), options: .curveEaseInOut, animations: { () -> Void in
                view.alpha = 0
            },completion: nil)
        }
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
                        let animationDuration = 0.5
                        if(players > 1) {
                            if player1.isTurn() {
                                player1.addPoint()
                                fadeViewInThenOut(view: pointMsg)
                                playSound()
                            }
                            else if player2.isTurn(){
                                player2.addPoint()
                                fadeViewInThenOut(view: pointMsg)
                                playSound()
                            }
                        }
                        else {
                            player1.addPoint()
                            fadeViewInThenOut(view: pointMsg)
                            playSound()
                        }
                        
                        var bricksLeft = false
                        for index in 0...15 {
                            if !openBricks[index] {
                                bricksLeft = true
                            }
                        }
                        if !bricksLeft {
                            if players > 1 {
                                var winner : String
                                let alertMessage = "Well done!"
                                if player1.points > player2.points {
                                    winner = "Player 1 wins!"
                                } else if player2.points > player1.points {
                                    winner = "Player 2 wins!"
                                } else {
                                    winner = "It's a draw! Enter a combined name to be remembered!"
                                }
                                let alert = UIAlertController(title: alertMessage, message: winner, preferredStyle: UIAlertControllerStyle.alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                
                                }))
                            
                                self.present(alert, animated: true, completion:{})
                                
                            }
                             else {
                                var tField: UITextField!
                                
                                func configurationTextField(textField: UITextField!)
                                {
                                    textField.text = "Player"
                                    tField = textField
                                }

                                let alert = UIAlertController(title: "Well done!", message: "Unfortunately, you did not make it to the highscore list.", preferredStyle: UIAlertControllerStyle.alert)
                                if(isHighscore(score: turnsVal)) {
                                    alert.message = "Congratulations, you made a high score! Enter your name to be remembered!"
                                    alert.addTextField(configurationHandler: configurationTextField)
                                }
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(alertAction) in
                                    self.addHighscore(score: self.turnsVal, name: tField.text!)
                                    self.navigationController?.popViewController(animated: true)}))
                                self.present(alert, animated: true, completion:{})
                            }
                        }
                    }
                    else {
                        print("DEBUG: TWO UNMATCHING BRICKS")
                        closeBricks = true
                        closeBricksIndex.append(i)
                        closeBricksIndex.append(brick.brickMatchId)
                        turnsVal += 1
                        turnsLabel.text = "\(turnsVal)"
                        if(players > 1) {
                            player1.changeTurn()
                            player2.changeTurn()
                        } else {
                            
                        }
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
    
    private func isHighscore(score : Int) -> Bool{
        return Highscore.sharedInstance.isHighscore(score: score, board: self.difficulty!)
    }
    
    private func addHighscore(score : Int, name : String) {
        Highscore.sharedInstance.addHighscore(name: name, score: score, board: self.difficulty!)
        Highscore.sharedInstance.saveChanges()
    }
}
