//
//  PlaylistRequestBody.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation

struct PlaylistRequestBody: Codable {
    let restTime: Int
    let finaleInfo: FinaleInfo
    
    struct FinaleInfo: Codable {
        let videoId: String
        let thumbnail: String
        let title: String
        let artist: String
        let length: Int
        let viewCount: Int
    }
}
