//
//  PlaylistView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI


struct Music: Identifiable {
    var id = UUID()
    var title: String
    var artist: String
    var lenght: String
}



struct PlaylistView: View {
    @State var MusicList: [Music] = [
        Music(title: "Cookie", artist: "NeaJeans", lenght: "3:13"),
        Music(title: "Starlight", artist: "Muse", lenght: "4:12")

        
    ]
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("5월 12일의 플레이리스트")
                .font(.system(size: 24, weight: .semibold))
                .padding(.leading, 20)
            
            
            HStack{
                Spacer()
                Text("13분 25초")
                    .padding(.trailing, 20)
            }
            
            
            List{
                ForEach(MusicList, id: \.id) { item in
                    HStack{
                        Rectangle()
                            .cornerRadius(11)
                            .frame(width: 44, height: 44)
                        
                        
                        
                        VStack(alignment: .leading)
                        {
                            Text(item.title)
                            Text(item.artist)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(item.lenght)
                            .foregroundColor(.gray)
                        
                    }
                    
                }
                .onDelete(perform: delete)
            }
            .listStyle(.inset)
            .frame(maxHeight: 540)
            
            
            HStack{
                Spacer()
                Text("플레이리스트 종료하기")
                    .font(Font.custom("Inter", size: 14))
                    .underline()
                    .foregroundColor(.gray)
                Spacer()
            }
            
        }
        
//        .padding(20)
        
        
        
        
        
    }
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            MusicList.remove(at: first)
        }
    }
    
}





#Preview {
    PlaylistView()
}
