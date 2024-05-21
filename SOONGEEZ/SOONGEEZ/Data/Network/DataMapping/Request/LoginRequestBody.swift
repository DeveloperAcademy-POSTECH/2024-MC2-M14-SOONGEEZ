//
//  LoginRequestBody.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//

import Foundation

struct LoginRequestBody: Codable {
    let client_id: String
    let scope: String
}
