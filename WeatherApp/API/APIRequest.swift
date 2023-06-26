//
//  APIRequest.swift
//  WeatherApp
//

//

import Foundation
/// APIクライアントサーバに対する要求に関する決まり事（URLの書き換えがないため、ゲッタのみ）
public protocol APIRequest {
    // 連想型。リクエストの型からレスポンスの型を決定できるようにする（型を指定しない）
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get } // ?から始まり&で接続されている箇所
//    var body: Encodable? { get } 今回は未使用
}

public extension APIRequest {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }

    /// リクエストを表す型をそのままでは渡せないため、URLRequest型に変換する
    func buildURLRequest() -> URLRequest {
        // baseURLにpathを統合する
        let url = baseURL.appendingPathComponent(path)
        // 統合したURLをURLComponentsにすることで、さまざまな要素にアクセス可能にする
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // 今回は.get以外は考慮しない
        switch method {
        case .get:
            // クエリパラメータをURLに追加する
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported method \(method)")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    /// サーバーから受け取ったData型とHTTPURLResonse型を元に、レスポンスを表す型に変換
    // エラーを投げる可能性があるため、throwsとし、エラーを投げる可能性のある処理を記述。
    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        // HTTPステータスコードが２００番台であれば成功。
        if (200..<300).contains(urlResponse.statusCode) {
            // JSONからモデルをインスタンス化
            return try decoder.decode(Response.self, from: data)
        } else {
            // JSONからAPIエラーをインスタンス化
            throw try decoder.decode(APIError.self, from: data)
        }

    }
}
