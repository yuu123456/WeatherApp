//
//  HTTPClient.swift
//  WeatherApp
//

//

import Foundation
/// サーバーと情報をやり取りするための決まり事
public protocol HTTPClient {
    /// APIに対してリクエストを送信し、レスポンスを受け取るメソッド
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)

}
//URLSessionクラスをHTTPクライアントとして使用できるようにする
 extension URLSession: HTTPClient {
    public func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(Result.failure(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))
            default:
                fatalError("invalid response combination\(String(describing: (data, urlResponse, error))).")
            }
        }
        task.resume()
    }
 }
