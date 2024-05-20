//
//  AudioPlayerView.swift
//  SOONGEEZ
//
//  Created by 이윤지 on 5/18/24.
//

import SwiftUI
import AVKit


class AudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isPlaying = false//@Published
    @Published var progress: CGFloat = 0.0
    @Published var currentSong: Music? //
    
    @Published var currentTime: TimeInterval = 0.0 //@Published
    
    
    var formattedDuration: String = "20:00" //총 길이
    var formattedProgress: String = "00:00" //재생된 시간
    
    
    @State var duration: Double = 0.0
    
    var currentSongIndex = 0
    
    var audioPlayer: AVAudioPlayer?
    
    
    let songs = [
        Music(title: "Song 1", artist: "Artist 1", length: "102", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")! ),
        Music(title: "Song 2", artist: "Artist 2", length: "102", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")! ),
        Music(title: "Song 3", artist: "Artist 3", length: "102", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")! ),
    ]
    
    
    override init() {
        super.init()
        initialiseAudioPlayer()
    }
    
    
    
    func initialiseAudioPlayer(){
        currentSong = songs[currentSongIndex]
        
        let path = Bundle.main.path(forResource: currentSong?.musicURL, ofType: "mp3")!
        print(currentSongIndex)
        
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            audioPlayer?.currentTime = 0
            currentTime = 0
            
            
        } catch{
            print("오류")
        }
        
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        
        
        
        duration = self.audioPlayer!.duration
        
        
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            if !audioPlayer!.isPlaying{
                isPlaying = false
            }
            
            progress = CGFloat(audioPlayer!.currentTime / audioPlayer!.duration)
            
            formattedProgress = formatter.string(from: TimeInterval(audioPlayer!.currentTime))!
            
            formattedDuration = formatter.string(from: TimeInterval(audioPlayer!.duration))!
            
            print(progress, formattedProgress)
        }
        
        
        
    }
    
    func nextSong() {
        currentSongIndex = (currentSongIndex + 1) % songs.count
        initialiseAudioPlayer()
        
        if isPlaying {
            audioPlayer?.play()
        }
    }
    
    func playPause() {
        guard let player = audioPlayer else { return }
        
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        nextSong()
    }
    
    
    
}


struct MusicPlayerView: View {
    
    //    @State var audioPlayer: AVAudioPlayer!
    //    @State var progress:CGFloat = 0.0
    //    @State private var playing: Bool = false
    //    @State var duration: Double = 0.0
    //    @State var formattedDuration: String = "20:00" //총 길이
    //    @State var formattedProgress: String = "00:00" //재생된 시간
    //
    //    @State var currentSongIndex = 0
    
    //    @StateObject var viewModel = AudioPlayerViewModel(progress: 0.0, formattedDuration: "20:00", formattedProgress: "00:00", duration: 0.0, audioPlayer: AVAudioPlayer!)
    
    
    
    
    @StateObject var viewModel = AudioPlayerViewModel()
    
    
    var body: some View{
        let songs = viewModel.songs
        let currentSongIndex = viewModel.currentSongIndex
        var audioPlayer = viewModel.audioPlayer
        var isPlaying = viewModel.isPlaying
        var progress = viewModel.progress
        
        
        
        
        VStack(spacing:0){
            VStack(spacing:0){
//                Image("img_recordAudio")
                AsyncImage(url: songs[currentSongIndex].imageURL)
//                    .resizable()
                    .scaledToFill()
                    .frame(width:305, height:305)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .padding([.bottom],20)
                
                HStack(alignment:.center,spacing: 5) {
                    VStack(spacing:12){//songinfo
                        HStack{
                            Text(songs[currentSongIndex].title)//data: 노래제목
                                .font(.system(size: 24, weight:.semibold))
                            Spacer()
                        }
                        HStack{
                            Text(songs[currentSongIndex].artist)//data: 가수
                                .font(.system( size: 20))
                            Spacer()
                        }
                    }
                    
                    
                    
                    Button(action:{
                        //                        if audioPlayer.isPlaying {
                        //                            playing = false
                        //                            self.audioPlayer.pause()
                        viewModel.nextSong()
                        
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
                        Text(viewModel.formattedProgress)//data: 현재 재생시간
                            .font(.system( size: 16).monospacedDigit())
                        Spacer()
                        Text(viewModel.formattedDuration)//data: 총 재생길이
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
            viewModel.initialiseAudioPlayer()
        }
        
        Button {
            viewModel.playPause()
        } label: {
            if viewModel.isPlaying{
                PauseButtonView
            } else {
                PlayButtonView
            }
        }
        
    }
    
    
    
    
    
    
    //    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    //        if flag {
    //            nextSong()
    //        }
    //    }
}

//extension MusicPlayerView: AVAudioPlayerDelegate {
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        if flag {
//            nextSong()
//        }
//    }
//}


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








#Preview {
    MusicPlayerView()
}

