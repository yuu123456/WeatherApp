//
//  WeatherData.swift
//  WeatherApp
//

//

import Foundation
/// 取得したいデータのモデル（APIのレスポンスに合わせた）
public struct WeatherData: Decodable {
    // レスポンスにおいてlistは配列型
    public var list: [List]
    public var city: City
}

public struct List: Decodable {
    public var main: Main
    // レスポンスにおいてweatherは配列型
    public var weather: [Weather]
    public var rainyPercent: Double
    public var dateString: String

    public enum CodingKeys: String, CodingKey {
        case main
        case weather
        case rainyPercent = "pop"
        case dateString = "dt_txt"
    }
}

public struct Main: Decodable {
    public var maxTemp: Double
    public var minTemp: Double
    public var humidity: Int

    public enum CodingKeys: String, CodingKey {
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case humidity
    }
}

 public struct Weather: Decodable {
    public var weatherIconId: String

    public enum CodingKeys: String, CodingKey {
        case weatherIconId = "icon"
    }
 }

 public struct City: Decodable {
    public var name: String
    public var coord: Coord
 }

 public struct Coord: Decodable {
    public var lat: Double
    public var lon: Double
 }
