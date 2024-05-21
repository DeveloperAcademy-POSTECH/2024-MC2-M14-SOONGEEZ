//
//  Config.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/20/24.
//

import Foundation

enum Config {
    enum keys {
        enum Plist {
            static let baseURL = "BASE_URL"
//            static let Client_ID = "CLIENT_ID"
        }
    }
    private static let infoDictionaty: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist 찾지 못함")
        }
        return dict
    }()
}
