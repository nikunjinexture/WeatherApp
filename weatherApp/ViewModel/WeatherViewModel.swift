//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by InexTure on 07/12/18.
//  Copyright © 2018 INX. All rights reserved.
//

import Foundation
import Alamofire

class WeatherViewModel{
    
    var dailyDataModelObj = [dailyDataModel]()
    var temperatureHigh:String?
    var temperatureLow:String?
    var sunriseTime:String?
    
    init(model:dailyDataModel){
        if model.temperatureHigh.count > 0{
            self.temperatureHigh = getTemperature(strTemp: model.temperatureHigh)
            self.temperatureLow = getTemperature(strTemp: model.temperatureLow)
            self.sunriseTime = GetDayName(strDate: model.sunriseTime)
        }
    }
    
    func fetchWhetherData(strLat:String, strLong:String, completion: @escaping (_ weatherModelData: WeatherModel) -> ()){
        
        let strAPIPath = "https://api.darksky.net/forecast/\(API_KEY)/\(strLat),\(strLong)"
        
        let header = ["Content-Type":"application/json"]
        var request = URLRequest(url: URL(string:strAPIPath)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        Alamofire.request(request).responseObject { (response: DataResponse<WeatherModel>) in
            
            if response.response?.statusCode == nil{
            }
            
            if response.result.value != nil {
                print(response.result.value!)
                self.dailyDataModelObj = response.result.value!.daily.data
                completion(response.result.value!)
            }
            }
            .responseJSON { response in
                switch response.result {
                case .success:
                    break
                case .failure( _):
                    break
                }
        }
    }
    
    //MARK:- Return Number of items of Weather Data
    func numberOfItems() -> Int {
       return dailyDataModelObj.count
    }
    
    //MARK:- Set Weather Data ( high/Low Weather Temperature)
    func setWeatherData(cell:weatherCell, indexpath:IndexPath){
        cell.lblHighTemp.text = getTemperature(strTemp: dailyDataModelObj[indexpath.row].temperatureHigh)
        cell.lblLowTemp.text = getTemperature(strTemp: dailyDataModelObj[indexpath.row].temperatureLow)
    }
    
    //MARK:- Get Temperature Method
    func getTemperature(strTemp:String) -> String {
        let temperature = (Double(strTemp)! - 32) * 5/9
        return "\(Int(temperature)) \(Celsius_Key)"
    }
    
    //MARK:- Get Day Name From Date String
    func GetDayName(strDate:String) -> String{
        let unixTimestamp = strDate
        let date = Date(timeIntervalSince1970: Double(unixTimestamp)!)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE"
        return dateFormat.string(from: date)
    }
    
}
