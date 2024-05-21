//
//  AudioPlayerViewModel.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import Foundation
import AVKit


class AudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    @Published var PlayList: [Music] =
    [
        Music(title: "Cookie", artist: "NeaJeans", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
    ]

    var currentSongIndex = 0
    @Published var currentSong: Music? //


    
    @Published var isPlaying = false//@Published
    

    
    
    @Published var progress: CGFloat = 0.0
    @Published var currentTime: TimeInterval = 0.0 //@Published
    

    
    
    var formattedDuration: String = "20:00" //총 길이
    var formattedProgress: String = "00:00" //재생된 시간
    
    
    var duration: Double = 0.0
    
    
    
//
//    init(PlayList: [Music]) {
//        self.PlayList = PlayList
//    }
    
    
    override init() {
        super.init()
        initialiseAudioPlayer()
    }
    
    
    
    func initialiseAudioPlayer(){
        currentSong = PlayList[currentSongIndex]
        
        let path = Bundle.main.path(forResource: currentSong?.musicURL, ofType: "mp3")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
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
            
        }
        
        
        
    }
    
    func nextSong() {
        currentSongIndex = (currentSongIndex + 1) % PlayList.count
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
