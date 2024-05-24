//
//  FinishView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct FinishView: View {
    @Binding var makePlaylist: Bool
    
    @Binding var finish: Bool
    
    
    var body: some View {
        ZStack() {
            
            Image("img_FinishView")
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Button(action: {
                    finish = false
                    makePlaylist = false
                }, label: {
                    Text("다른 피날레 만들기")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .underline()
                })
            }.padding(.bottom, 110)
        }
    }
}


#Preview {
    FinishView(makePlaylist: .constant(true), finish: .constant(true))
}
