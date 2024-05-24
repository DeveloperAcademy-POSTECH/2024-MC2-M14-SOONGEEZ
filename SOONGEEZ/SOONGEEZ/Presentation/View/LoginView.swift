//
//  LoginView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authSessionManager = AuthSessionManager()
    
    @Binding var LoginFinsh : Bool
    
    var completion: Int = 0
    
    var body: some View {
        ZStack() {
            
            Image("img_loginView")
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
                    Text("Youtube 연결하기")
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
            let urlString = try await LoginService.shared.PostRegisterData(client_id: "891726102319-daqelg79kkgok5ig581geqbnmieggvl6.apps.googleusercontent.com", scope: "https://www.googleapis.com/auth/youtube")
            
            guard let url = URL(string: urlString) else {
                print("URL 변환 실패")
                return
            }
            print("URL 변환 성공: \(url)")
            print("Login code", LoginService.shared.responseCode)
            
            let result = await authSessionManager.authenticate(with: url)
            
            if result == 1 {
                Task {
                    await postToken()
                }
            } else {
                print("토큰 오류")
            }
                
                } catch {
                    print("에러 발생: \(error)")
                }
    }
    
    
    func postToken() async {
        do {
            let code = LoginService.shared.responseCode
            print("함수 내에서 토큰 찍어보기", code)
            self.LoginFinsh = try await TokenService.shared.PostTokenData(code: code)
            
            print("PostTokenData 결과: \(LoginFinsh)")

            
        } catch {
            print("auth 토큰 실패: \(error)")
        }
    }
    
}

//#Preview {
//    LoginView(makePlaylist: $makePlaylist)
//}
