//
//  responseModel.swift
//  weatherApp
//
//  Created by InexTure on 06/12/18.
//  Copyright © 2018 INX. All rights reserved.
//

import Foundation
import EVReflection

class WeatherModel: EVObject {
    var latitude = ""
    var longitude = ""
    var timezone = ""
    var currently = currenlyModel()
    var hourly = hourlyModel()
    var daily = dailyModel()
    var offset = ""
}

class currenlyModel: EVObject {
    var time = ""
    var summary = ""
    var icon = ""
    var precipIntensity = ""
    var precipProbability = ""
    var temperature = ""
    var apparentTemperature = ""
    var dewPoint = ""
    var humidity = ""
    var pressure = ""
    var windSpeed = ""
    var windGust = ""
    var windBearing = ""
    var cloudCover = ""
    var uvIndex = ""
    var visibility = ""
    var ozone = ""
}

class hourlyModel: EVObject{
    var summary = ""
    var icon = ""
    var data = [hourlyDataModel]()
}

class hourlyDataModel: EVObject{
    var time = ""
    var summary = ""
    var icon = ""
    var precipIntensity = ""
    var precipProbability = ""
    var temperature = ""
    var apparentTemperature = ""
    var dewPoint = ""
    var humidity = ""
    var pressure = ""
    var windSpeed = ""
    var windGust = ""
    var windBearing = ""
    var cloudCover = ""
    var uvIndex = ""
    var visibility = ""
    var ozone = ""
}

class dailyModel: EVObject{
    var summary = ""
    var icon = ""
    var data = [dailyDataModel]()
}

class dailyDataModel: EVObject{
    var time = ""
    var summary = ""
    var icon = ""
    var sunriseTime = ""
    var sunsetTime = ""
    var moonPhase = ""
    var precipIntensity = ""
    var precipIntensityMax = ""
    var precipProbability = ""
    var temperatureHigh = ""
    var temperatureHighTime = ""
    var temperatureLow = ""
    var temperatureLowTime = ""
    var apparentTemperatureHigh = ""
    var apparentTemperatureHighTime = ""
    var apparentTemperatureLow = ""
    var apparentTemperatureLowTime = ""
    var dewPoint = ""
    var humidity = ""
    var pressure = ""
    var windSpeed = ""
    var windGust = ""
    var windGustTime = ""
    var windBearing = ""
    var cloudCover = ""
    var uvIndex = ""
    var uvIndexTime = ""
    var visibility = ""
    var ozone = ""
    var temperatureMin = ""
    var temperatureMinTime = ""
    var temperatureMax = ""
    var temperatureMaxTime = ""
    var apparentTemperatureMin = ""
    var apparentTemperatureMinTime = ""
    var apparentTemperatureMax = ""
    var apparentTemperatureMaxTime = ""
}

