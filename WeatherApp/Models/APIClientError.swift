//
//  APIClientError.swift
//  WeatherApp
//

//

import Foundation

public enum APIClientError: Error {
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // APIからエラーレスポンスを受け取った
    case apiError(APIError)
}
