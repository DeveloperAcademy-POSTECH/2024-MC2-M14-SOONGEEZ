//
//  LoginService.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//

import Foundation

class LoginService {
    static let shared = LoginService()
    private init() {}
    
    func makeRequest() -> URLRequest {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: Config.keys.Plist.baseURL) as? String ?? ""
        let url = URL(string: baseURL + "/api")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func postLoginURL() async throws -> String {
        do {
            let request = self.makeRequest()
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.responseError
            }
            
            let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            return decodedResponse.url
        } catch {
            throw error
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}
