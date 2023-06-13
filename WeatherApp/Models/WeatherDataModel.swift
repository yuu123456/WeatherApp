//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by 秋山悠 on 2023/06/12.
//

import Foundation

struct WeatherDataModel {
    var timeArray: [String?]
    var weatherArray: [WeatherType?]
    var maxTempArray: [Double?]
    var minTempArray: [Double?]
    var humidArray = [30, 85, 50, 70]
    var rainyPercentArray: [Double] = [30, 85, 20, 50]
}
