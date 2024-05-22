////
////  MusicView.swift
////  SOONGEEZ
////
////  Created by 조세연 on 5/14/24.
////
//
//import SwiftUI
//import AVKit
//
//struct MusicView: View {
//    @Environment(\.dismiss) var dismiss
//    @State var showPlayList = false
//    
//    @ObservedObject var PlayerModel: AudioPlayerViewModel
//    @Binding var finish: Bool
//    
//    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
//    @State private var currentDragOffsetY: CGFloat = 0
//    @State private var endingOffsetY: CGFloat = 0
//    
//    var body: some View {
//        
//        ZStack {
//            Color.customGray100.ignoresSafeArea()
//            Image("backgroundDecoration") //백그라운드 이미지 들어갈 것
//                .resizable()
//                .scaledToFit()
//                .frame(width:393, height:486)
//                .padding(.top, 330)
//                .ignoresSafeArea()
//            
//            
//            VStack(alignment: .leading){
//                    TopLogo
//                    CurrentOrder
//                
//                PlayerView(PlayerModel: PlayerModel)
//                
//            }
//            
//            VStack(spacing: 20){
//                PlaylistView(PlayList: $PlayerModel.PlayList, finish: $finish)
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color.white)
//            .cornerRadius(30)
//            .offset(y: startingOffsetY)
//            .offset(y: currentDragOffsetY)
//            .offset(y: endingOffsetY + 30)
//
//            .gesture(
//                DragGesture()
//                    .onChanged({ value in
//                        withAnimation(.spring()) {
//                            currentDragOffsetY = value.translation.height
//                        }
//                    })
//                    .onEnded({ value in
//                        withAnimation(.spring()) {
//                            if currentDragOffsetY < -150 {
//                                endingOffsetY = -startingOffsetY
//                                currentDragOffsetY = .zero
//                            } /*덜올라감*/
//                            else if endingOffsetY != 0 && currentDragOffsetY > 150 {
//                                endingOffsetY = .zero
//                                currentDragOffsetY = .zero
//                            } /*내리기*/
//                            else {
//                                currentDragOffsetY = .zero
//                            } /*올리기*/
//                        }
//                    })
//            )
//        }
//        .ignoresSafeArea(edges: .bottom)
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //
//    
//    
//    var TopLogo: some View {
//        Image("img_logo")//텍스트 로고
//            .resizable()
//            .scaledToFit()
//            .frame(width:69, height: 21)
//
//    }
//    
//    var CurrentOrder: some View {
//        VStack(alignment: .leading, spacing: 0){
//            Text("오늘의 플레이리스트")
//                .padding([.bottom],5)
//            HStack{
//                Text("\(PlayerModel.currentSongIndex+1)번째 곡이에요")//data:노래 순서
//                Image(systemName: "music.note")
//            }
//        }
//        .font(.system(size: 24, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        // @StateObject 사용
//        MusicView(PlayerModel: AudioPlayerViewModel(
//            PlayList: [
//                Music(title: "Cookie", artist: "가수1", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
//                Music(title: "starlight", artist: "가수2", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),  ],
//            lastSong: Music(title: "집에 언제가노", artist: "김은정", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!)),
//                  finish: .constant(false))
//    }
//}
//
//
