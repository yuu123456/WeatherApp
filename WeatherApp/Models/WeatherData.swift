//
//  WeatherData.swift
//  WeatherApp
//

//

import Foundation

public struct WeatherData: Decodable {
    public var list: [List]
    public var city: City
}

public struct List: Decodable {
    public var main: Main
    public var weather: Weather
    public var rainyPercent: Double
    public var dateString: String

    public enum CodingsKeys: String, CodingKey {
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

    public enum CodingsKeys: String, CodingKey {
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case humidity
    }
}

public struct Weather: Decodable {
    public var weatherIconId: String

    public enum CodingsKeys: String, CodingKey {
        case weatherIconId = "icon"
    }
}

public struct City: Decodable {
    public var name: String
    public var coord: [Coord]
}

public struct Coord: Decodable {
    public var lat: String
    public var lon: String
}
