//
//  AuthSessionManager.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/21/24.
//


import SwiftUI
import AuthenticationServices

class AuthSessionManager: NSObject, ObservableObject {
    
    var webAuthSession: ASWebAuthenticationSession?
    
    func authenticate(with authURL: URL) {
        // 콜백 URL을 처리하기 위한 세션 생성
        webAuthSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "https") { callbackURL, error in
            
            print("before : \(String(describing: callbackURL))")
            
            if callbackURL == nil {
                print("nil Authentication error: \(String(describing: error?.localizedDescription))")
                // 오류 발생 시 API 호출
                Task {
                    await postToken()
                }
            }
        }
        webAuthSession?.presentationContextProvider = self
        webAuthSession?.start()
    }
}

extension AuthSessionManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

func postToken() async {
    do {
        let code = LoginService.shared.responseCode
        print("함수 내에서 토큰 찍어보기", code)
        let result = try await TokenService.shared.PostTokenData(code: code)
        print("PostTokenData 결과: \(result)")
    } catch {
        print("auth 토큰 실패: \(error)")
    }
}
