//
//  ViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 03/10/16.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//
// Animation KLAR
// Highscore
// Färgtema
// Bibliotek - bilder
// Gps

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var playBtn: UIButton!

    @IBOutlet weak var numberOfImages: UILabel!
    @IBOutlet weak var highscoreBtn: UIButton!
    
    @IBOutlet weak var clearImages: UIButton!
    let reuseIdentifier = "cell"
    var memoryBricks: [UIImage] = []
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var selectedPhotos: UILabel!
    @IBOutlet weak var multiplayerToggle: UISwitch!
    @IBOutlet weak var largeModeToggle: UISwitch!
    @IBOutlet weak var gridLayout: UICollectionView!
    
    @IBAction func clearImages(_ sender: UIButton) {
        
            
        
        
        let alertVC = UIAlertController(
            title: "Clear images",
            message: "Are you sure you want to clear selected images?",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: { action in
                self.memoryBricks.removeAll();
                 self.numberOfImages.text = "";
                 self.gridLayout.reloadData()
            })
        alertVC.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }

    @IBAction func multiplayerToggle(_ sender: UISwitch) {
        multiplayerToggle = sender
    }
    @IBAction func largeModeToggle(_ sender: UISwitch) {
        largeModeToggle = sender
    }
    /* Get:er for multiplayerToggle */
    func getMPState() -> UISwitch {
        return multiplayerToggle
    }
    /* Get:er for largeModeToggle */
    func getLMState() -> UISwitch {
        return largeModeToggle
    }

    @IBAction func photoFromLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }

    }
    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
            }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        highscoreBtn.layer.cornerRadius = 3
        highscoreBtn.layer.masksToBounds = true
        
        numberOfImages.isHidden = true
        playBtn.layer.cornerRadius = 3
        playBtn.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            if ((memoryBricks.count == 8 && largeModeToggle.isOn) || (memoryBricks.count == 16 && !largeModeToggle.isOn)){
                let alertVC = UIAlertController(
                    title: "Memory bricks don't match",
                    message: "Sorry, the amount of photos does not match the selected mode",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                present(
                    alertVC,
                    animated: true,
                    completion: nil)
            }
            else if((memoryBricks.count == 8 && !largeModeToggle.isOn) || (memoryBricks.count == 16 && largeModeToggle.isOn)){
                let controller = segue.destination as! GameViewController
                controller.difficulty = Difficulty.Easy
                controller.brickImages = memoryBricks
                if multiplayerToggle.isOn {
                    controller.players = 2
                }
            }
            else{
                let alertVC = UIAlertController(
                    title: "Not yet",
                    message: "You have the wrong number of photos selected",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                present(
                    alertVC,
                    animated: true,
                    completion: nil)
            }
        }
    }
    
    //MARK: - Delegates
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        /* 2 lines below can be removed, used prev. for setting the image to the last photo taken */
        //myImageView.contentMode = .scaleAspectFit
        //myImageView.image = chosenImage
        
        
        numberOfImages.isHidden = false
        selectedPhotos.isHidden = false
        clearImages.isHidden = false
        dismiss(animated:true, completion: nil)
        
        memoryBricks.append(chosenImage)
        numberOfImages.text = String(memoryBricks.count) + " selected"
        
        self.gridLayout.reloadData()
        
        print("DEBUG: \(memoryBricks)") //prints the array in the console for debugging
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = gridLayout.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.img = self.memoryBricks[indexPath.item]
        print("indexPath: ", indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memoryBricks.count
    }
    

}
