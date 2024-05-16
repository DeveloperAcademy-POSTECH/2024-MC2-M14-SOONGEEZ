//
//  MusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        ZStack{
            Image("img_musicViewBackground") //백그라운드 이미지 들어갈 것
                .ignoresSafeArea()
                
            
            VStack(spacing:0){
                
                TopLogo
                
                CurrentOrder
                
                CurrentPlayingSong
                
                HStack{
                    PauseButton
                }
                
                
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
            Text("첫번째 곡이에요")//data:노래 순서
            Image(systemName: "music.note")
            Spacer()
        }
    }
    .font(.system(size: 24, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
    .padding([.horizontal],20)
    .padding([.bottom],24)
}

var CurrentPlayingSong: some View {
    VStack(spacing:0){
        VStack(spacing:0){
            Image("img_recordAudio")
                .resizable()
                .scaledToFill()
                .frame(width:305, height:305)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .padding([.bottom],20)
            
            HStack(alignment:.center,spacing: 5) {
                VStack(spacing:12){//songinfo
                    HStack{
                        Text("노래제목")//data: 노래제목
                            .font(.system(size: 24, weight:.semibold))
                        Spacer()
                    }
                    HStack{
                        Text("가수")//data: 가수
                            .font(.system( size: 20))
                        Spacer()
                    }
                }
                SkipButton
            }.padding([.bottom], 20)
            
            VStack(spacing:0){//songLength
               RoundedRectangle(cornerRadius: 5) //재생바
                    .foregroundColor(.customLightGray)
                    .frame(height:8)
                    .padding([.bottom],4)
                HStack{
                    Text("0:30")//data: 현재 재생시간
                        .font(.system( size: 16))
                    Spacer()
                    Text("3:56")//data: 총 재생길이
                        .font(.system( size: 16))
                }
            }
        }
    }
    .padding(24)
    .background{
        RoundedRectangle(cornerRadius: 16)
            .fill(.ultraThickMaterial)
            .strokeBorder(Color.black, lineWidth:1)
         
            
    }
    .padding([.horizontal],20)
    .padding([.bottom],16)
}

var SkipButton: some View {
    Button(action:{
        print("이 곡 넘기기")
    }, label: {
        Image(systemName: "forward.end.fill")
            .font(.system( size: 20))
            .foregroundColor(.customGray)
            .frame(width:40, height:40)
    }
    )
}

var PauseButton: some View{
    Button(action:{
        print("일시정지 하고 플레이리스트 갱신")
    }, label: {
        HStack(spacing:4){
            Image(systemName: "pause.fill")
            Text("일시정지")
        }.foregroundColor(.primaryPurple)
    }
    )
    .padding([.vertical],14)
    .padding([.horizontal],17.5)
    .background{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
    }
}





#Preview {
    MusicView()
}
