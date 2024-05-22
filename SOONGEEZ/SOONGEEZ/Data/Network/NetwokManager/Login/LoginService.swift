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
    
    var responseUrl : String = ""
    var responseCode : String = ""
    
    func makeRequestBody(client_id: String, scope: String) -> Data? {
        do {
            let data = LoginRequestBody(client_id: client_id, scope: scope)
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    
    func makeRequest(body: Data?) -> URLRequest {
        
        let baseURL = Bundle.main.object(forInfoDictionaryKey: Config.keys.Plist.baseURL) as? String ?? ""
        let url = URL(string: baseURL + "/members/google-oauth-url")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
    
    func PostRegisterData(client_id: String,
                          scope: String) async throws -> String {
        do {
            guard let body = makeRequestBody(client_id: client_id, scope: scope)
            else {
                throw NetworkError.requstEncodingError
            }
            
            let request = self.makeRequest(body: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw NetworkError.responseError
            }
            
            let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            self.responseUrl = decodedResponse.result.googleOauthUrl
            self.responseCode = decodedResponse.result.code
            
            return self.responseUrl
            
        } catch {
            print("에러세요: \(error)")
            throw error
        }
    }
    

    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}

