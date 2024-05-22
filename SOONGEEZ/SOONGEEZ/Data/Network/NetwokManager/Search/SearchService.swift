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
    
    var responseVideoInfo: [SearchResponse.VideoInfo] = []

    func makeRequest(query: String) -> URLRequest {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: Config.keys.Plist.baseURL) as? String ?? ""
        
        guard var components = URLComponents(string: baseURL + "/videos/search") else {
            fatalError("Invalid base URL")
        }
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
   
    func GetSearchData(query: String) async throws -> Array<Any> {
        do {
           
            let request = self.makeRequest(query: query)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw NetworkError.responseError
            }
            
            let decodedResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
            self.responseVideoInfo = decodedResponse.result.videoInfoList
            
            print(responseVideoInfo)
            return responseVideoInfo
            
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

