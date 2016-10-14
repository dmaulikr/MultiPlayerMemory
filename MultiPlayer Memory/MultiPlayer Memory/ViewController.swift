//
//  ViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 03/10/16.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    let picker = UIImagePickerController()
    @IBOutlet weak var selectedPhotos: UILabel!
    @IBOutlet weak var multiplayerToggle: UISwitch!
    @IBOutlet weak var largeModeToggle: UISwitch!
    
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
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        selectedPhotos.isHidden = false
        dismiss(animated:true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

