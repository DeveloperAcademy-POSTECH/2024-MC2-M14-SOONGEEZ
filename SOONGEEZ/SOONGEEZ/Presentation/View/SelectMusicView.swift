//
//  SelectMusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct SelectMusicView: View {
    
    @State private var searchText = ""
    
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 8){
            Text("피날레 곡")
                .padding(.leading, 20)
                .fontWeight(.bold)
                .font(.system(size: 24))
            Text("오늘의 피날레를 장식할 곡을 선택해 주세요.")
                .padding(.leading, 20)
                .font(.system(size: 17))
            
            SearchBar(text: $searchText)
                .padding(EdgeInsets(top: 18, leading: 0, bottom: 16, trailing: 0))
            
            
        }
        
        
       
    }
}

#Preview {
    SelectMusicView()
}
