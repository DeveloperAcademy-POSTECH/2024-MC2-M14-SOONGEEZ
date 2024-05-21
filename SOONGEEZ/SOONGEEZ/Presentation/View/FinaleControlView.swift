//
//  FinaleControlView.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import SwiftUI

struct FinaleControlView: View {
    
    @State var makePlaylist = false
    
    @State var viewNum = 0
    @State var selectSong: Music?


    
    
    var body: some View {
        
        if !makePlaylist {
            FinaleSelctedView(makePlaylist: $makePlaylist)
        }
        
        else
        {
            MusicView()
        }
    }
}

#Preview {
    FinaleControlView()
    
}
