//
//  CityData.swift
//  WeatherApp
//

//

import Foundation
// 都市名もWeatherDataに含んでも良さげ？
public struct CityData: Decodable {
    public var name: String?
    public var lat: Double?
    public var lon: Double?
}
