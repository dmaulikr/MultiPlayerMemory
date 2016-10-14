//
//  ViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 03/10/16.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var items: [String] = ["1","2","3","4","5"]
    let reuseIdentifier = "cell"
    var memoryBricks: [UIImage] = []
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var selectedPhotos: UILabel!
    @IBOutlet weak var multiplayerToggle: UISwitch!
    @IBOutlet weak var largeModeToggle: UISwitch!
    
    @IBOutlet weak var gridLayout: UICollectionView!
    @IBOutlet weak var stateTest: UILabel! //TESTLABEL, ta bort sen!
    
    @IBAction func multiplayerToggle(_ sender: UISwitch) {
        multiplayerToggle = sender
        
        /* Testkod för att se att multiplayerToggle sparar rätt värde, ta bort sen */
        if multiplayerToggle.isOn{
            stateTest.text = "ON"
        }
        else{
            stateTest.text = "OFF"
        }
    }
    @IBAction func largeModeToggle(_ sender: UISwitch) {
        largeModeToggle = sender
    }
    /* GET:er för multiplayerToggle */
    func getMPState() -> UISwitch {
        return multiplayerToggle
    }
    /* GET:er för largeModeToggle */
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Delegates
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        /* 2 lines below can be removed? */
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        
        selectedPhotos.isHidden = false
        dismiss(animated:true, completion: nil)
        
        memoryBricks.append(chosenImage)
        /* här nedan tänkte jag att collection viewn ska uppdateras eftersom det är här varje ny bild slängs in i arrayn */

        self.gridLayout.reloadData()
        
        
        print(memoryBricks) //printar arrayn i consolen för debugging
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = gridLayout.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.brick.image = self.memoryBricks[indexPath.item]
        print("indexPath: ", indexPath)
        print(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memoryBricks.count
    }
    

}

