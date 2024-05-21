//
//  LoginView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authSessionManager = AuthSessionManager()
    
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
        do {
            let urlString = try await LoginService.shared.PostRegisterData(client_id: "749492689389-j067tspanbra266amsk4funtf4bunc1o.apps.googleusercontent.com", scope: "https://www.googleapis.com/auth/youtube")
        
            guard let url = URL(string: urlString) else {
                print("URL 변환 실패")
                return
            }
            print("URL 변환 성공: \(url)")
            print("Login code", LoginService.shared.responseCode)
            
            await authSessionManager.authenticate(with: url)
            
        } catch {
            print("에러 발생: \(error)")
        }
    }
}

#Preview {
    LoginView()
}
