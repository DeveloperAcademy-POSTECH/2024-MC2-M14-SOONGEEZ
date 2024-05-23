//
//  ExportResponse.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation

struct ExportResponse: Decodable {
    let timeStamp: String
    let code: String
    let message: String
    let result: Result

    struct Result: Decodable {
        let playlistId: String
    }
}
