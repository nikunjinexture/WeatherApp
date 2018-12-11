//
//  ForecastWeather.swift
//  weatherApp
//
//  Created by INX on 26/11/18.
//  Copyright © 2018 INX. All rights reserved.
//

import Foundation

class ForecastWeather {
    private var _date : String!
    private var _temp : Double!
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var temp : Double{
        if _temp == nil{
           _temp = 0.0
        }
        return _temp
    }
}
