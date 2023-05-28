//
//  KariData.swift
//  WeatherApp
//

//

import Foundation
//API通信を行うまでの仮のデータ（後ほど削除）
struct KariData {
    var timeArray = ["12:00", "15:00", "18:00", "21:00"]
    var weatherArray: [WeatherType] = [.thunderstorm, .snowy, .sunny, .rainy]
    var maxTempArray = [25.5, 24.5, 26.7, 36.6]
    var minTempArray = [15.0, 17.0, 20.8, 19.9]
    var humidArray = [30, 40, 50, 70]
    var rainyPercentArray = [30, 30, 20, 50]
}
