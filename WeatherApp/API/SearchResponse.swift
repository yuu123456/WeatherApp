//
//  SearchResponse.swift
//  WeatherApp
//

//

import Foundation
/// 取得した結果（全データ）を表す型
public struct SearchResponse<WeatherData: Decodable>: Decodable {
    // 当該APIからのレスポンスにおいて、”list”及び"city"の中に取得したい情報があるため以下モデルに合わせ変換させる
    public var list: [List]
    public var city: City
}
