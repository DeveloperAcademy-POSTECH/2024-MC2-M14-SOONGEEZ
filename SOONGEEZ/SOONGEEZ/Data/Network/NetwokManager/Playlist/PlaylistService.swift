//
//  PlaylistService.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation

class PlaylistService {
    static let shared = PlaylistService()
    private init() {}
    
    var responseLength : Int = 0
    var responseVideoInfo: [SearchModel] = []

    func makeRequestBody(restTime: Int, finaleInfo: (title: String, artist: String, videoId: String)) -> Data? {
        do {
            let finaleInfoStruct = PlaylistRequestBody.FinaleInfo(title: finaleInfo.title, artist: finaleInfo.artist, videoId: finaleInfo.videoId)
            
            let data = PlaylistRequestBody(restTime: restTime, finaleInfo: finaleInfoStruct)
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
        let url = URL(string: baseURL + "/videos/playlist")!
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
    
    func PostPlaylistData(restTime: Int, finaleInfo: (title: String, artist: String, videoId: String)) async throws -> [SearchModel] {
        do {
            guard let body = makeRequestBody(restTime: restTime, finaleInfo: (title: finaleInfo.title, artist: finaleInfo.artist, videoId: finaleInfo.videoId))
            else {
                throw NetworkError.requstEncodingError
            }
            
            let request = self.makeRequest(body: body)
            print("네트워크 요청 생성됨") // 네트워크 요청 생성 로그
            
            let (data, response) = try await URLSession.shared.data(for: request)
            print("네트워크 응답 수신됨") // 네트워크 응답 수신 로그
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw NetworkError.responseError
            }
            
            let decodedResponse = try JSONDecoder().decode(PlaylistResonse.self, from: data)
            let videoInfoList = decodedResponse.result.videoInfoList
            self.responseLength = decodedResponse.result.playlistLength
            
            let searchModels = videoInfoList.compactMap { videoInfo -> SearchModel? in
                        guard let url = URL(string: videoInfo.thumbnail) else {
                            print("Invalid URL: \(videoInfo.thumbnail)")
                            return nil
                        }
                        return SearchModel(
                            videoId: videoInfo.videoId,
                            thumbnail: url,
                            title: videoInfo.title,
                            artist: videoInfo.artist,
                            duration: videoInfo.duration.convertDuration()
                        )
                    }
            
                    return searchModels
            
        } catch {
            print("플레이리스트 에러: \(error)") // 에러 발생시 로그
            throw error
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}

