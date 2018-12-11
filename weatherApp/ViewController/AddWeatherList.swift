//
//  AddWeatherList.swift
//  weatherApp
//
//  Created by INX on 26/11/18.
//  Copyright © 2018 INX. All rights reserved.
//

import UIKit

class ForecastWeatherCell : UITableViewCell {
    
    //MARK : Outlets
    @IBOutlet weak var lblForecastCityName: UILabel!
    @IBOutlet weak var lblForecastTemp: UILabel!
}

class AddWeatherList: UIViewController {
    
    //MARK : Outlets
    @IBOutlet weak var tblViewListingWeather: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension AddWeatherList : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewListingWeather.dequeueReusableCell(withIdentifier: "ForecastWeatherCell") as! ForecastWeatherCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //ForecastWeatherCell.removeObserver(indexPath.row)
            tblViewListingWeather.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
