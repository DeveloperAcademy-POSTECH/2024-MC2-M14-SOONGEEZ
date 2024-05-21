//
//  LoginView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authSessionManager = AuthSessionManager()
    @State private var isLoading = false // 로딩 상태 관리
    //var loginService = LoginService()
    
    var body: some View {
        ZStack() {
            
            Image("backgroundOfLogin")
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                Spacer()
                Button(action: {
                    Task{ 
                        await loginAndAuthenticate()
                    }
                    //authSessionManager.authenticate(with: )
                }, label: {
                    Image("iconOfYoutube")
                        . frame(width: 30,height: 30)
                    Text("Youtube Music 연결하기")
                        .foregroundColor(.primary)
                    
                })
                .frame(maxWidth: .infinity)
                .fontWeight(.regular)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 80)
            }
        }
    }
    
    
    func loginAndAuthenticate() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let urlString = try await LoginService.shared.getLoginURL()
            guard let url = URL(string: urlString) else {
                print("URL 변환 실패")
                return
            }
            
            await authSessionManager.authenticate(with: url)
        } catch {
            print("에러: \(error)")
        }
    }
}

#Preview {
    LoginView()
}
