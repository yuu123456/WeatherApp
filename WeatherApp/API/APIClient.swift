//
//  APIClient.swift
//  WeatherApp
//

//

import Foundation
/// APIに対してリクエストを送信し、レスポンスを受け取る役割を担う
public class APIClient {
    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    /// APIに対してリクエストを送信し、レスポンスを受け取るメソッド
    public func send<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.Response, APIClientError>) -> Void) {
        let urlRequest = request.buildURLRequest()

        // リクエストを送信
        httpClient.sendRequest(urlRequest) { result in
            // 受け取ったレスポンスに対する処理（非同期）
            // resultは送信結果を表す列挙型で、成功と失敗の２ケースある
            switch result {
            case .success((let data, let urlResponse)):
                do {
                    let response = try
                    request.response(from: data, urlResponse: urlResponse)
                    completion(Result.success(response))
                } catch _ as APIError {
                    completion(Result.failure(.apiError))
                } catch {
                    completion(Result.failure(.responseParseError))
                }
            case .failure:
                completion(.failure(.connectionError))
            }
        }
    }
}
