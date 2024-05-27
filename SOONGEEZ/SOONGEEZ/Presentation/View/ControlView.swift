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
    
    @State var playListLoading : Int = 0
    
    @State var resetSelectSong = 0
    
    @State var selectSong: SearchModel?
    
    @State var PlaylistSongs: [SearchModel] = []
    
    
    
    var body: some View {
        
        if !makePlaylist {
            FinaleSelctedView(playListLoading: $playListLoading, PlaylistSongs: $PlaylistSongs, makePlaylist: $makePlaylist, resetSelectSong: $resetSelectSong, selectSong: $selectSong)
        }
        
        else if finish && makePlaylist {
            
            FinishView(makePlaylist:  $makePlaylist, finish: $finish)
        }
        
        else if makePlaylist && !finish {
            
            MakePlaylistView(playListLoading: $playListLoading, selectSong: $selectSong, finish: $finish, resetSelectSong: $resetSelectSong, makePlaylist: $makePlaylist, PlaylistSongs: $PlaylistSongs)
        }
        
        //            else {
        //                FinaleSelctedView(PlaylistSongs: $PlaylistSongs, makePlaylist: $makePlaylist, selectSong: $selectSong)
        //            }
        //
        
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




#Preview {
    ControlView()
}
