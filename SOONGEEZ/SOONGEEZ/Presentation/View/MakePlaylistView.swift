//
//  MakePlaylist.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/22/24.
//

import SwiftUI


struct MakePlaylistView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showPlayList = false
    
    @Binding var playListLoading : Int
    
    @State var playListId: String = ""
    
    @Binding var selectSong: SearchModel?
    @Binding var finish: Bool
    
    @Binding var makePlaylist: Bool
    
    @Binding var PlaylistSongs: [SearchModel]
    
    
    func createExportRequestBody(from playlistSongs: [SearchModel]) -> ExportRequestBody {
        let videoList = playlistSongs.map { $0.videoId }
        return ExportRequestBody(videoList: videoList)
    }
    
    
    func postExport() async {
        do {
            
            let exportRequestBody = createExportRequestBody(from: PlaylistSongs)
            
            playListId = try await ExportService.shared.PostExportData(videoList: exportRequestBody.videoList)
            
            print(playListId)
            
            
        } catch {
            print("에러 발생: \(error)")
        }
    }
    
    func performExport() {
        Task {
            await postExport()
        }
    }
    
    
    
    var totalLen = "13분 25초"
    
    var body: some View {
        
        ZStack {
            Color.customGray100.ignoresSafeArea()
            Image("backgroundDecoration") //백그라운드 이미지 들어갈 것
                .resizable()
                .scaledToFit()
                .frame(width:393, height:486)
                .padding(.top, 330)
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading, spacing: 16){
                TopLogo
                    .padding(.horizontal, 20)
                
                HStack{
                    Text("오늘의 피날레곡")
                    Image(systemName: "music.note")
                }
                .font(.system(size: 24, weight:.bold))
                .padding(.horizontal, 20)
                
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .frame(width: 353, height: 104)
                    
                    HStack(spacing: 8){
                        AsyncImage(url: $selectSong.wrappedValue?.thumbnail){ image in
                            image.image?.resizable()
                        }
                        .scaledToFit()
                        .frame(width: 140, height: 79)
                        .scaledToFit()
                        .cornerRadius(8)
                        
                        
                        
                        VStack(alignment: .leading)
                        {
                            Text(selectSong!.title)
                            Text(selectSong!.artist)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(selectSong!.duration)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .padding(12)
                    .frame(width: 353, height: 104)
                }
                .padding(.horizontal, 20)
                
                
                Text("\(Date(), formatter: Self.KoreanFormatter)의 플레이리스트")
                    .font(.system(size: 24, weight:.bold))
                    .padding(.horizontal, 20)
                
                if playListLoading == 0 {
                    
   
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(2.0, anchor: .center)
                        .padding(.leading, 185)
                        .frame(height: 496)
              
                }
                
                
                else {
                    
                    HStack{
                        Spacer()
                        Text("총 \(PlaylistService.shared.responseLength)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    
                    
                    List{
                        ForEach(PlaylistSongs, id: \.id) { item in
                            SongView(thissong: item)
                            
                        }
                        .listRowBackground(Color.clear)
                        
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) { print("삭제") } label: {
                                Label("delete", systemImage: "trash") }
                            Button(role: .cancel) { print("붐따") } label: {
                                Label("dislike", systemImage: "hand.thumbsdown.fill") }
                        }
                    }
                    .listStyle(.inset)
                    .frame(height: 384)
                    .scrollContentBackground(.hidden)
                    .background(Color.customGray100.opacity(0.9))
                    
                    HStack(spacing: 14){
                        
                        HStack{
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundStyle(Color.primaryPurple)
                            Text("다시 만들기")
                                .foregroundStyle(Color.primaryPurple)
                        }
                        
                        .frame(width: 168, height: 49, alignment: .center)
                        .background(.white)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.makePlaylist = false
                            
                            self.PlaylistSongs = []
                            //self.selectSong = nil
                        }
                        
                        
                        HStack{
                            Image(systemName: "headphones")
                                .foregroundStyle(Color.white)
                            Text("들으러 가기")
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 168, height: 49, alignment: .center)
                        .background(Color.primaryPurple)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.performExport()
                            self.finish = true
                            
                            self.PlaylistSongs = []
                            //self.selectSong = nil
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    
                }
            }
            
        }
        
    }
    
    
    var TopLogo: some View {
        Image("img_logo")//텍스트 로고
            .resizable()
            .scaledToFit()
            .frame(width:69, height: 21)
            .padding(.bottom, 4)
        
    }
    
    var CurrentOrder: some View {
        VStack(alignment: .leading, spacing: 0){
            //                .padding([.bottom],5)
            HStack{
                Text("오늘의 피날레곡")
                Image(systemName: "music.note")
            }
        }
        .font(.system(size: 24, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
    }
    
}


extension MakePlaylistView{
    static let KoreanFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일"
        return formatter
    }()
}


struct SongView: View {
    var thissong: SearchModel
    
    init(thissong: SearchModel) {
        self.thissong = thissong
    }
    
    var body: some View {
        HStack{
            
            AsyncImage(url: thissong.thumbnail){ image in
                image.image?.resizable()
            }
            .scaledToFit()
            .cornerRadius(4)
            .frame(width: 64, height: 36)
            
            VStack(alignment: .leading)
            {
                Text(thissong.title)
                Text(thissong.artist)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Text(thissong.duration)
                .foregroundColor(.gray)
                .font(.caption)
        }
        
        //        .background(.white.opacity(0.75))
    }
}


//#Preview {
//    MakePlaylistView(finish: .constant(false), PlaylistSongs: PlaylistSongs)
//}
//


