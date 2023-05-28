//
//  SelectDataModel.swift
//  WeatherApp
//

//

import UIKit

struct DataModel {
    var location: String?

    //天気に応じたWeatherImageを返す
    func getWeatherImage(weather: WeatherType) -> UIImage {
        switch weather {
        case .sunny:
            return UIImage(systemName: "sun.max.fill")!
        case .cloudy:
            return UIImage(systemName: "cloud.fill")!
        case .rainy:
            return UIImage(systemName: "cloud.rain")!
        case .snowy:
            return UIImage(systemName: "cloud.snow")!
        case .thunderstorm:
            return UIImage(systemName: "cloud.bolt.rain.fill")!
        }
    }

    //現在の日付を変換する
    func getCurrentFormattedDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = formatter.string(from: today)
        return date
    }
}
