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
        Music(title: "Starlight", artist: "Muse", lenght: "4:12"),
        Music(title: "Cookie", artist: "NeaJeans", lenght: "3:13"),
        Music(title: "Starlight", artist: "Muse", lenght: "4:12"),
        Music(title: "Cookie", artist: "NeaJeans", lenght: "3:13"),
        Music(title: "Starlight", artist: "Muse", lenght: "4:12"),
        Music(title: "Cookie", artist: "NeaJeans", lenght: "3:13"),
        Music(title: "Starlight", artist: "Muse", lenght: "4:12"),
        Music(title: "Cookie", artist: "NeaJeans", lenght: "3:13"),
        Music(title: "Starlight", artist: "Muse", lenght: "4:12"),
    ]
    @State private var showingAlert = false
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            Text("5월 12일의 플레이리스트")
                .font(.system(size: 24, weight: .semibold))
                .padding(.leading, 20)
            
            
            HStack{
                Spacer()
                Text("13분 25초")
                    .padding(.trailing, 20)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            ZStack(alignment: .bottom){
                
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
                                .font(.caption)
                            
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.inset)
                .frame(maxHeight: 560)
                
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        Spacer()
                        Text("플레이리스트 종료하기")
                            .font(Font.custom("Inter", size: 14))
                            .underline()
                            .foregroundColor(.gray)
                            .onTapGesture {
                                showingAlert = true
                            }
                        Spacer()
                    }
                }
                .frame(width: 393, height: 87)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white.opacity(0), location: 0.00),
                            Gradient.Stop(color: .white, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0.18),
                        endPoint: UnitPoint(x: 0.5, y: 0.5)
                    ))
                
            }
        }
        
        .alert("플레이리스트 종료", isPresented: $showingAlert) {
            Button("종료하기", role: .destructive) {}
            Button("취소", role: .cancel) {}
            
        } message: {
            Text("지금 재생하고 있는 플레이리스트를 종료하시겠습니까?")
        }
        

        
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
