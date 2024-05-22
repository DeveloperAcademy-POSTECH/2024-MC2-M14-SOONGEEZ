//
//  SearchResponse.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//

import Foundation

struct SearchResponse: Decodable {
    let timeStamp: String
    let code: String
    let message: String
    let result: Result

    struct Result: Decodable {
        let videoInfoList: [VideoInfo]
    }

    struct VideoInfo: Decodable {
        let videoId: String
        let thumbnail: String
        let title: String
        let artist: String
        let duration: String
        let viewCount: Int
    }
}
