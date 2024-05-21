//
//  SearchManager.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//

import Foundation

class SearchService {
    static let shared = SearchService()
    private init() {}
    
    
//    func makeRequestBody(code: String) -> Data? {
//        do {
//            let data = TokenRequestBody(code: code)
//            let jsonEncoder = JSONEncoder()
//            let requestBody = try jsonEncoder.encode(data)
//            return requestBody
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//    
//    func makeRequest(body: Data?) -> URLRequest {
//        let baseURL = Bundle.main.object(forInfoDictionaryKey: Config.keys.Plist.baseURL) as? String ?? ""
//        let url = URL(string: baseURL + "members/google-oauth-token")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let header = ["Content-Type": "application/json"]
//        header.forEach {
//            request.addValue($0.value, forHTTPHeaderField: $0.key)
//        }
//        if let body = body {
//            request.httpBody = body
//        }
//        
//        return request
//    }
//    
//    func PostTokenData(code: String) async throws -> String {
//        do {
//            guard let body = makeRequestBody(code: code)
//            else {
//                throw NetworkError.requstEncodingError
//            }
//            
//            let request = self.makeRequest(body: body)
//            let (_, response) = try await URLSession.shared.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print(response)
//                throw NetworkError.responseError
//            }
//            return "성공"
//            
//        } catch {
//            print("토큰서비스 에러: \(error)")
//            throw error
//        }
//    }
//
//
//    private func configureHTTPError(errorCode: Int) -> Error {
//        return NetworkError(rawValue: errorCode)
//        ?? NetworkError.unknownError
//    }
//}
//
