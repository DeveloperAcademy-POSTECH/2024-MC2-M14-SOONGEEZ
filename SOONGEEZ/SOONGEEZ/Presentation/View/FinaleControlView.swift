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

    
    
    var body: some View {
        
        if !makePlaylist {
            FinaleView(makePlaylist: $makePlaylist)
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
