//
//  SelectMusicModel.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/15/24.
//

import Foundation

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageURL: URL
}
