//
//  LoginResponse.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//

import Foundation

struct LoginResponse: Decodable {
    let timeStamp: String
    let code: String
    let message: String
    let result: Result

    struct Result: Decodable {
        let googleOauthUrl: String
        let code: String
    }
}
