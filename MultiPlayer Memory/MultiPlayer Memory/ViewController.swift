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
// Alert på - man ska inte kunna välja fler bilder än brädet tillåter
//          - 

import UIKit
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var numberOfImages: UILabel!
    @IBOutlet weak var highscoreBtn: UIButton!
    
    @IBOutlet weak var gpsImg: UIImageView!
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
        if (getLMState().isOn){
            numberOfImages.text = String(memoryBricks.count) + " of 16"
        }else if (!getLMState().isOn){
            numberOfImages.text = String(memoryBricks.count) + " of 8"
        }
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
        if GpsLocation.sharedInstance.inside {
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
            let alertVC = UIAlertController(
                title: "Not in range",
                message: "You are not in range of the Museum of World Culture and can therefore not take pictures.",
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
        
        
        //Gps
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        
        gpsLocation.gpsImage = gpsImg
        startMonitoring(gpsLocation: gpsLocation)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            if((memoryBricks.count == 8 && !largeModeToggle.isOn) || (memoryBricks.count == 16 && largeModeToggle.isOn)){
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
            else{
                let imgLeftLarge = 16 - memoryBricks.count
                let imgLeft = 8 - memoryBricks.count
                if(getLMState().isOn){
                    let alertVC = UIAlertController(
                        title: "Not yet",
                        message: "You need " + String(imgLeftLarge) + " more photos",
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
                }else{
                    let alertVC = UIAlertController(
                        title: "Not yet",
                        message: "You need " + String(imgLeft) + " more photos",
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
        if (getLMState().isOn){
            numberOfImages.text = String(memoryBricks.count) + " of 16"
        }else if (!getLMState().isOn){
            numberOfImages.text = String(memoryBricks.count) + " of 8"
        }
        
        
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
