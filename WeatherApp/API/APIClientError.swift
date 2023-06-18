//
//  APIClientError.swift
//  WeatherApp
//

//

import Foundation
/// APIクライアント内部で発生するエラーを表す型
public enum APIClientError: Error {
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // APIからエラーレスポンスを受け取った
    case apiError(APIError)
}
