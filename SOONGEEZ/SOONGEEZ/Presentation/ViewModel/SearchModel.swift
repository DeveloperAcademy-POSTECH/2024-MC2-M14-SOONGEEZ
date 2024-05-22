//
//  SearchModel.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/22/24.
//

import Foundation

struct SearchModel: Identifiable {
    let id = UUID()
    
    let videoId: String
    let thumbnail: URL
    let title: String
    let artist: String
    let duration: String
}
