//
//  LoginView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack() {
            
            Image("backgroundOfLogin")
                .scaledToFill()
                .ignoresSafeArea()
            VStack() {
                Spacer()
                Button(action: {
                    print("")
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
                        .strokeBorder(lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    LoginView()
}
