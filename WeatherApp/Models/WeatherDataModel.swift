//
//  WeatherDataModel.swift
//  WeatherApp
//

//

import Foundation

public struct WeatherDataModel: Decodable {
    public var dateString: String?
    public var weatherIconId: String? //idでアイコン画像を判別するため（https://openweathermap.org/img/wn/{icon-id}@2x.png）
    public var maxTemp: Double?
    public var minTemp: Double?
    public var humidity: Int?
    public var rainyPercent: Double?

    public enum CodingsKeys: String, CodingKey {
        case dateString = "dt_txt"
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case humidity
        case rainyPercent = "pop"
    }
}
