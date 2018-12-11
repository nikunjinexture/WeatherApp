//
//  GooglePlacePicker.swift
//  weatherApp
//
//  Created by INX on 28/11/18.
//  Copyright © 2018 INX. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class GooglePlacePicker: UIViewController{
    
    //MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    //MARK: variables
    var placesClient : GMSPlacesClient!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
    }
    
    //MARK : Action
    @IBAction func pickPlan(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewPort = GMSCoordinateBounds(coordinate: northEast, coordinate:southWest)
        let config =  GMSPlacePickerConfig(viewport: viewPort)
        let placePicker = GMSPlacePicker(config: config)


        placePicker.pickPlace (callback: { (place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            if let place = place {
                //self.lblName.text = place.name
                self.lblAddress.text =  place.formattedAddress?.components(separatedBy:",").joined(separator: "\n")
            }
            else {
                //self.lblName.text = "No place selected"
                self.lblAddress.text = ""
            }

        })
        
        
        
//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//
//        present(placePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickRepeatDay(_ sender: Any) {
        let aVC = storyboard?.instantiateViewController(withIdentifier: "RepeatDayPicker") as! RepeatDayPicker
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

//MARK : GMSPlacePickerViewControllerDelegate

extension GooglePlacePicker : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        //print("Place name \(place.name)")
        print("Place address \(String(describing: place.formattedAddress))")
        //print("Place attributions \(String(describing: place.attributions))")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("No place selected")
    }
}
