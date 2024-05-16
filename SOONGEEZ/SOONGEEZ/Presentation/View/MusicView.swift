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
                
                AudioPlayerView()
                
                
                
                
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

struct AudioPlayerView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var progress:CGFloat = 0.0
    @State private var playing: Bool = false
    @State var duration: Double = 0.0
    @State var formattedDuration: String = "20:00" //총 길이
    @State var formattedProgress: String = "00:00" //재생된 시간
    
    var body: some View{
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
                
                StatusBar
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
        
        Button(action: {
            if audioPlayer.isPlaying{
                playing = false
                self.audioPlayer.pause()
            } else if !audioPlayer.isPlaying {
                playing = true
                self.audioPlayer.play()
            }
        }){
            // playing ? PauseButton : PlayButton //버튼...
        }
    }
    
}
extension AudioPlayerView {
    var StatusBar: some View{
        VStack(spacing:0){//songLength
            GeometryReader{ gr in
                Capsule()
                    .fill(Color.customLightGray)
                    .background(
                        Capsule()
                            .foregroundColor(Color.primaryPurple)
                            .frame(width: gr.size.width * progress, height: 8), alignment: .leading)
            }.frame( height: 8)
                .padding([.bottom],4)
            HStack{
                Text(formattedProgress)//data: 현재 재생시간
                    .font(.system( size: 16).monospacedDigit())
                Spacer()
                Text(formattedDuration)//data: 총 재생길이
                    .font(.system( size: 16).monospacedDigit())
            }
        }
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
        .padding([.horizontal],37.5)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
    }
    
    var PlayButton: some View{
        Button(action:{
            print("재생")
        }, label: {
            HStack(spacing:4){
                Image(systemName: "play.fill")
                Text("재생")
            }.foregroundColor(.primaryPurple)
        }
        )
        .padding([.vertical],14)
        .padding([.horizontal],53.5)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
    }
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





#Preview {
    MusicView()
}
