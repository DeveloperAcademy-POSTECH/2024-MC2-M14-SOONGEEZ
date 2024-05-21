//
//  FinaleControlView.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import SwiftUI

struct ControlView: View {
    
    @State var makePlaylist = false
    @State var finish = false

    
    @State var viewNum = 0
    @State var selectSong: Music?


    
    @State var PlayList0: [Music] =
    [
        Music(title: "Cookie", artist: "NeaJeans", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
    ]
    
    
    var body: some View {
        
        if !makePlaylist {
            FinaleSelctedView(makePlaylist: $makePlaylist, selectSong: $selectSong)
        }
        
        else
        {
            @StateObject var PlayerModel = AudioPlayerViewModel(PlayList: PlayList0, lastSong: selectSong!)

            if !finish  {  MusicView(PlayerModel: PlayerModel, finish: $finish)  }
            
            else    {   FinishView(makePlaylist: $makePlaylist, finish: $finish).onAppear(){
                
                selectSong = nil
            }    }

        }
    }
}



#Preview {
    ControlView()
}
