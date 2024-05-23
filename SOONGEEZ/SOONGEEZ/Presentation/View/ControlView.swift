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
    @State var selectSong: SearchModel?
    
    @State var PlaylistSongs: [SearchModel] = []


//    
//    @State var PlayList0: [SearchModel] =
//    [
//        SearchModel(videoId: "viosad", thumbnail: URL(string: "https://example.com/image1.jpg")!, title: "카사노바", artist: "에스파", duration: "PT3M1S"),
//        SearchModel(videoId: "viosad", thumbnail: URL(string: "https://example.com/image1.jpg")!, title: "카사노바", artist: "에스파", duration: "PT3M1S"),
//        SearchModel(videoId: "viosad", thumbnail: URL(string: "https://example.com/image1.jpg")!, title: "카사노바", artist: "에스파", duration: "PT3M1S"),
//    ]
//    
    
    var body: some View {
        
        if !makePlaylist {
            FinaleSelctedView(PlaylistSongs: $PlaylistSongs, makePlaylist: $makePlaylist, selectSong: $selectSong)
        }
        
        else
        {
            MakePlaylistView(selectSong: $selectSong, finish: $finish, PlaylistSongs: $PlaylistSongs)
            
            
//            //@StateObject var PlayerModel = AudioPlayerViewModel(PlayList: PlayList0, lastSong: selectSong!)
//
//            if !finish  {  MusicView(PlayerModel: PlayerModel, finish: $finish)  }
//
//            else    {   FinishView(makePlaylist: $makePlaylist, finish: $finish).onAppear(){
//                
//                selectSong = nil
//            }    }

        }
    }
}



#Preview {
    ControlView()
}
