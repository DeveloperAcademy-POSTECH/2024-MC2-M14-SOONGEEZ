//
//  PlayMusic.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/17/24.
//

import Foundation

struct Music: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let length: String
    let imageURL: URL

}
