//
//  WeatherDetails.swift
//  weatherApp
//
//  Created by INX on 26/11/18.
//  Copyright © 2018 INX. All rights reserved.
//

import UIKit
import CoreLocation
import EVReflection

class ForecastItem : EVObject {
    var day:String = ""
    var temp: String = "\(0.0)"
}

class weatherCell: UITableViewCell {
    
    // ********** Outlets ********** //
    @IBOutlet var lblDayName: UILabel!
    @IBOutlet var lblHighTemp: UILabel!
    @IBOutlet var lblLowTemp: UILabel!
    
    // ********** Variables ********** //
    var weatherViewModelObj: WeatherViewModel!
    
    var weatherModelObj: WeatherViewModel!{
        didSet {
            
            self.lblHighTemp.text = weatherModelObj.temperatureHigh
            self.lblLowTemp.text = weatherModelObj.temperatureLow
            self.lblDayName.text = weatherModelObj.sunriseTime
        }
    }

}

class WeatherDetails: UIViewController {
    
    //MARK :Outlets
    @IBOutlet weak var weatherTblView: UITableView!
    
    //variables
    var weatherViewModelObj = WeatherViewModel(model: dailyDataModel())
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
       // ********** Fetch Weather Data From API ********** //
        weatherViewModelObj.fetchWhetherData(strLat: "23.0225", strLong: "72.5714") { (weatherModelObj) in
            
            self.navigationItem.title = "Ahmedabad " + self.weatherViewModelObj.getTemperature(strTemp: weatherModelObj.currently.temperature)
            self.weatherTblView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }

    //MARK : Actions
    @IBAction func btnAddListWeather(_ sender: Any) {
        let aVC = storyboard?.instantiateViewController(withIdentifier: "AddWeatherList") as! AddWeatherList
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


extension WeatherDetails : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return weatherViewModelObj.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTblView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! weatherCell
        
        let weatherModelObj = WeatherViewModel(model: weatherViewModelObj.dailyDataModelObj[indexPath.row])
        cell.weatherModelObj = weatherModelObj
        return cell
    }
}


