//
//  MusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI
import AVKit

struct MusicView: View {
    var body: some View {
        ZStack{
            Image("img_musicViewBackground") //백그라운드 이미지 들어갈 것
                .ignoresSafeArea()
            VStack(spacing:0){
                TopLogo
                CurrentOrder
                MusicPlayerView()
                Spacer()
            }
        }
    }
}

var TopLogo: some View {
    HStack{
    
        Image("img_logo")//텍스트 로고
            .resizable()
            .scaledToFit()
            .frame(width:69, height: 21)
            .padding([.top], 62)
            .padding([.bottom], 24)
            .padding([.horizontal], 20)
        Spacer()
    }
}

var CurrentOrder: some View {
    VStack(spacing: 0){
        HStack{
            Text("오늘의 플레이리스트")
                .padding([.bottom],5)
            Spacer()
        }
        HStack{
            Text("첫 번째 곡이에요")//data:노래 순서
            Image(systemName: "music.note")
            Spacer()
        }
    }
    .font(.system(size: 24, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
    .padding([.horizontal],20)
    .padding([.bottom],24)
}


#Preview {
    MusicView()
}
