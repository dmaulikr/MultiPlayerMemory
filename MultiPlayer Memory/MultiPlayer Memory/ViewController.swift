//
//  ViewController.swift
//  MultiPlayer Memory
//
//  Created by Magnus Huttu on 03/10/16.
//  Copyright © 2016 Magnus Huttu. All rights reserved.
//
// Animation KLAR
// Highscore KLAR
// Färgtema KLAR-isch
// Bibliotek - bilder
// Gps - KLAR
// För liten play-knapp

import UIKit
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var photoWarnLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var playWarnLabel: UILabel!
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
    
    //gps
    let locationManager = CLLocationManager()
    let gpsLocation = GpsLocation.sharedInstance
    
    @IBOutlet weak var locWarnLabel: UILabel!
    
    @IBAction func clearImages(_ sender: UIButton) {
        self.memoryBricks.removeAll()
        gridLayout.reloadData()
    }
    @IBAction func multiplayerToggle(_ sender: UISwitch) {
        multiplayerToggle = sender
    }
    @IBAction func largeModeToggle(_ sender: UISwitch) {
        largeModeToggle = sender
        updateBottomInfo()
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
        if gpsLocation.inside {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                noCamera()
            }
        } else {
            let alert = UIAlertController(title: "Alert!", message: "You can only take photos if you're at the world culture museum.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil ))
            self.present(alert, animated: true, completion:{})
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
        
        playBtn.layer.cornerRadius = 3
        playBtn.layer.masksToBounds = true
        
        var enoughImages = 8
        if largeModeToggle.isOn {
            enoughImages = 16
        }
        
        if memoryBricks.count < enoughImages {
            playBtn.isUserInteractionEnabled = false
            playBtn.backgroundColor = UIColor.gray
        }
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        gpsLocation.warnLabel = locWarnLabel
        startMonitoring(gpsLocation: gpsLocation)
        
        multiplayerToggle.onTintColor = UIColor(red:0.992, green:0.561, blue:0.145, alpha:1.0)
        largeModeToggle.onTintColor = UIColor(red:0.992, green:0.561, blue:0.145, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            let controller = segue.destination as! GameViewController
            if largeModeToggle.isOn {
                controller.difficulty = Difficulty.Hard
            } else {
                controller.difficulty = Difficulty.Easy
            }
            controller.brickImages = memoryBricks
            if multiplayerToggle.isOn {
                controller.players = 2
            }
        }
    }
    
    //MARK: - Delegates
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        /* 2 lines below can be removed, used prev. for setting the image to the last photo taken */
        //myImageView.contentMode = .scaleAspectFit
        //myImageView.image = chosenImage
        
        selectedPhotos.isHidden = false
        clearImages.isHidden = false
        dismiss(animated:true, completion: nil)
        
        memoryBricks.append(chosenImage)
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
        updateBottomInfo()
        return self.memoryBricks.count

    }
    
    private func updateBottomInfo() {
        var amountImages = 8
        if largeModeToggle.isOn {
            amountImages = 16
        }
        
        if memoryBricks.count == amountImages {
            playBtn.isUserInteractionEnabled = true
            playBtn.backgroundColor = UIColor.black
        } else {
            playBtn.isUserInteractionEnabled = false
            playBtn.backgroundColor = UIColor.gray
        }
        playWarnLabel.text = "Select \(amountImages-memoryBricks.count) more pictures to enable play"    }
    
    func startMonitoring(gpsLocation: GpsLocation) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            print("not able to monitor")
        }
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            print("not authorized")
            
        }
        let region = self.region(withGpsLocation: gpsLocation)
        locationManager.startMonitoring(for: region)
    }
    
    func region(withGpsLocation gpsLocation: GpsLocation) -> CLCircularRegion {
        
        let region = CLCircularRegion(center: gpsLocation.coordinate, radius: gpsLocation.radius, identifier: gpsLocation.identifier)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
    func stopMonitoring(gpsLocation: GpsLocation) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == gpsLocation.identifier else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    
}
