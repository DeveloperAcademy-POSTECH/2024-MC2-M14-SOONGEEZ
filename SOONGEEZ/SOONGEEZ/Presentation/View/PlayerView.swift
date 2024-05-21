//
//  PlayerView.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import SwiftUI


struct PlayerView: View {
    @State var showPlayList = false
    
    @ObservedObject var PlayerModel: AudioPlayerViewModel

    var body: some View{
        let playlist = PlayerModel.PlayList
        let currentSongIndex = PlayerModel.currentSongIndex
        let isPlaying = PlayerModel.isPlaying
        let progress = PlayerModel.progress
        
        
        
        VStack{
            VStack(spacing:0){
                VStack(spacing:0){
                    AsyncImage(url: playlist[currentSongIndex].imageURL)
                    //                    .resizable()
                        .scaledToFill()
                        .frame(width:305, height:305)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                        .padding([.bottom],20)
                    
                    HStack(alignment:.center,spacing: 5) {
                        VStack(spacing:12){//songinfo
                            HStack{
                                Text(playlist[currentSongIndex].title)//data: 노래제목
                                    .font(.system(size: 24, weight:.semibold))
                                Spacer()
                            }
                            HStack{
                                Text(playlist[currentSongIndex].artist)//data: 가수
                                    .font(.system( size: 20))
                                Spacer()
                            }
                        }
                        
                        
                        
                        Button(action:{
                            PlayerModel.nextSong()
                            
                        }, label: {
                            Image(systemName: "forward.end.fill")
                                .font(.system( size: 20))
                                .foregroundColor(.customGray)
                                .frame(width:40, height:40)
                        }
                        )
                    }.padding([.bottom], 20)
                    
                    //Status bar
                    VStack(spacing:0){
                        //songLength
                        ZStack{
                            Capsule()
                                .fill(Color.customLightGray)
                                .frame(height:8)
                            GeometryReader{ gr in
                                Capsule()
                                    .foregroundColor(.blue)
                                    .opacity(0.0)
                                
                                    .background(
                                        Capsule()
                                            .foregroundColor(Color.primaryPurple)
                                            .frame(width: gr.size.width * progress, height: 8), alignment: .leading)
                                
                            }
                            .frame( height: 8)
                        }
                        .padding([.bottom],4)
                        HStack{
                            Text(PlayerModel.formattedProgress)//data: 현재 재생시간
                                .font(.system( size: 16).monospacedDigit())
                            Spacer()
                            Text(PlayerModel.formattedDuration)//data: 총 재생길이
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
                PlayerModel.initialiseAudioPlayer()
            }
            
            Button {
                PlayerModel.playPause()
            } label: {
                if isPlaying{
                    PauseButtonView
                } else {
                    PlayButtonView
                }
            }
            
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




//#Preview {
////    PlayerView()
//}
