//
//  WeatherType.swift
//  WeatherApp
//

//

import UIKit
//APIから取得した名称に変更する予定
enum WeatherType {
    case sunny
    case cloudy
    case rainy
    case snowy
    case thunderstorm

    //天気に応じたWeatherImageを返す
    func getWeatherImage() -> UIImage {
        switch self {
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
}
