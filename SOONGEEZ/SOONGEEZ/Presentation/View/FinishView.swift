//
//  FinishView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct FinishView: View {
    var body: some View {
        ZStack() {
            
            Image("backgroundOfFinish")
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                Text("다음 피날레도 기대할게요!")
                    .font(.title2)
                    .padding(.top, 280)
                Spacer()
                Button(action: {
                    print("")
                }, label: {
                    Text("다른 피날레 만들기")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .underline()
                })
                .padding(.bottom, 110)
            }
        }
    }
}

#Preview {
    FinishView()
}
