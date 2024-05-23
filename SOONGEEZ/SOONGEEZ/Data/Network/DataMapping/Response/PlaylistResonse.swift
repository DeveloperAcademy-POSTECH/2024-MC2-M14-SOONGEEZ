//
//  PlaylistResonse.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation

struct PlaylistResonse: Decodable {
    let timeStamp: String
    let code: String
    let message: String
    let result: Result

    struct Result: Decodable {
        let videoInfoList: [VideoInfo]
        let playlistLength: Int
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
