//
//  ExportService.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation

class ExportService {
    static let shared = ExportService()
    private init() {}
    
    var responsePlaylistId: String = ""
    
    func makeRequestBody(videoList: [String]) -> Data? {
        do {
            let data = ExportRequestBody(videoList: videoList)
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
        let url = URL(string: baseURL + "/videos/playlist/export")!
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
    
    func PostExportData(videoList: [String]) async throws -> String {
        do {
            guard let body = makeRequestBody(videoList: videoList)
            else {
                throw NetworkError.requstEncodingError
            }
            
            let request = self.makeRequest(body: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw NetworkError.responseError
            }
            
            let decodedResponse = try JSONDecoder().decode(ExportResponse.self, from: data)
            self.responsePlaylistId = decodedResponse.result.playlistId
           
            return self.responsePlaylistId
            
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

