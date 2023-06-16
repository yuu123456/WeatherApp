//
//  SearchResponse.swift
//  WeatherApp
//

//

import Foundation
/// 取得した結果を表す型
public struct SearchResponse<WeatherData: Decodable>: Decodable {
    public var weatherDatas: [WeatherData]

    public enum CodingKeys: String, CodingKey {
        case weatherDatas = "list"
    }
}
