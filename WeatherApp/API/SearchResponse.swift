//
//  SearchResponse.swift
//  WeatherApp
//

//

import Foundation
/// 取得した結果（全データ）を表す型
public struct SearchResponse<WeatherData: Decodable>: Decodable {
    // 当該APIからのレスポンスにおいて、”list”の中に情報がある
    public var list: [List]
    public var city: City
}
