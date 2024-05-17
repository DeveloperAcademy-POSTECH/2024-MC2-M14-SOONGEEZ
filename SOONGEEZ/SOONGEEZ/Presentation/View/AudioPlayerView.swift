//
//  AudioPlayerView.swift
//  SOONGEEZ
//
//  Created by 이윤지 on 5/17/24.
//

import SwiftUI
import AVKit

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
                
                //Status bar
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
        }
        .padding(24)
        .background{
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThickMaterial)
                .strokeBorder(Color.black, lineWidth:1)
        }
        .padding([.horizontal],20)
        .padding([.bottom],16)
        .onAppear {
            initialiseAudioPlayer()
        }
        
        
        Button {
            if audioPlayer.isPlaying {
                playing = false
                self.audioPlayer.pause()
            }else if !audioPlayer.isPlaying{
                playing = true
                self.audioPlayer.play()
            }
        } label: {
            if playing {
                PauseButtonView
            } else {
                PlayButtonView
            }
                
        }
    }
    
    func initialiseAudioPlayer(){

            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = [.pad]
           
            let path = Bundle.main.path(forResource: "music_test2", ofType: "mp3")!
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            self.audioPlayer.prepareToPlay()
            
//            formattedDurtaion = formatter.string(from: TimeInterval(self.audioPlayer.duration))!
            
            duration = self.audioPlayer.duration
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if !audioPlayer.isPlaying{
                    playing = false
                }
                
                progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
                
                formattedProgress = formatter.string(from: TimeInterval(self.audioPlayer.currentTime))!
            }
        }
}

var PauseButton: some View{
    Button{
        print("일시정지 하고 플레이리스트 갱신")
    }label: {
        HStack(spacing:4){
            Image(systemName: "pause.fill")
            Text("일시정지")
        }.foregroundColor(.primaryPurple)
    }
    .padding([.vertical],14)
    .padding([.horizontal],37.5)
    .background{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
    }
}

var PauseButtonView: some View{
    HStack(spacing:4){
        Image(systemName: "pause.fill")
        Text("일시정지")
    }.foregroundColor(.primaryPurple)
        .padding([.vertical],14)
        .padding([.horizontal],37.5)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
}

var PlayButtonView: some View{
    HStack(spacing:4){
        Image(systemName: "play.fill")
        Text("재생")
    }.foregroundColor(.primaryPurple)
        .padding([.vertical],14)
        .padding([.horizontal],53.5)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
}


var PlayButton: some View{
    Button {
        print("재생")
    } label: {
        HStack(spacing:4){
            Image(systemName: "play.fill")
            Text("재생")
        }
        .foregroundColor(.primaryPurple)
    }
    .padding([.vertical],14)
    .padding([.horizontal],53.5)
    .background{
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
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
    AudioPlayerView()
}
