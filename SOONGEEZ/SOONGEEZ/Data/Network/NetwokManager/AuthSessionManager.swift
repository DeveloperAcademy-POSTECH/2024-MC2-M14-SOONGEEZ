//
//  TempNetworkManager.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI
import AuthenticationServices

class AuthSessionManager: NSObject, ObservableObject {
    var webAuthSession: ASWebAuthenticationSession?
    
    // 이 메서드를 호출하여 인증 세션을 시작
    func authenticate(with authURL: URL) {
        
//    func authenticate() {
//        guard let authURL = URL(string: "서버통신해서 받아온 url ") else {
//            print("Invalid URL")
//            return
//        }
        
        // 콜백 URL을 처리하기 위한 세션 생성
        webAuthSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "https") { callbackURL, error in
            
            print("before : \(callbackURL)")
            
            // 오류 처리
            if let error = error {
                print("Authentication error: \(error.localizedDescription)")
                return
            }
            
            // URL에서 액세스 토큰 추출
            guard let callbackURL = callbackURL, let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: true) else {
                return
            }
            
            print("after : \(callbackURL)")
            
            let accessToken = components.fragment.flatMap { URLComponents(string: "?\($0)")?.queryItems?.first(where: { $0.name == "access_token" })?.value }
            
            if let token = accessToken {
                print("Access Token: \(token)")
                // 액세스 토큰을 서버로 전송하는 메서드 호출
                self.sendTokenToServer(token: token)
            }
        }
        webAuthSession?.presentationContextProvider = self
        webAuthSession?.start()
    }
    
    // 서버로 토큰 전송
    private func sendTokenToServer(token: String) {
        // 네트워크 코드로 서버에 POST 요청
    }
}

extension AuthSessionManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
