//
//  webService.swift
//  weatherApp
//
//  Created by InexTure on 06/12/18.
//  Copyright © 2018 INX. All rights reserved.
//

import Foundation
import Alamofire

extension WeatherDetails{
    
    /*
    func getWhetherAPI(strLat:String,strLong:String){
        
            let strAPIPath = "https://api.darksky.net/forecast/\(API_KEY)/\(strLat),\(strLong)"
            
            let header = ["Content-Type":"application/json"]
            var request = URLRequest(url: URL(string:strAPIPath)!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = header
            
            Alamofire.request(request).responseObject { (response: DataResponse<WhetherModel>) in
                
                if response.response?.statusCode == nil{
                }
                
                if response.result.value != nil {
                    print(response.result.value!)
                    
                    self.navigationItem.title = "Ahmedabad " + self.getTemperature(strTemp: (response.result.value?.currently.temperature)!) + "°"
                    
                    self.arrDailyTempratureData = (response.result.value?.daily.data)!
                    self.weatherTblView.reloadData()
                    
                }
                }
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        break
                    case .failure(let _):
                        break
                    }
            }
             }*/
    
}
