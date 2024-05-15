//
//  SelectMusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct SelectMusicView: View {
    
    @State private var searchText = ""
    @State private var isSearching = false
    
    let songs: [LastFinaleMusic] = [
        LastFinaleMusic(title: "노래 제목 1", artist: "가수 1", imageURL: URL(string: "https://example.com/image1.jpg")!),
        LastFinaleMusic(title: "노래 제목 2", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "Starlight", artist: "Muse", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    
    let searchSongs: [SearchMusic] = [
        SearchMusic(title: "가", artist: "가수 1", playtime: 30, imageURL: URL(string: "https://example.com/image1.jpg")!),
        SearchMusic(title: "나", artist: "가수 2", playtime: 30, imageURL: URL(string: "https://example.com/image2.jpg")!),
        SearchMusic(title: "다", artist: "Muse", playtime: 40, imageURL: URL(string: "https://example.com/image2.jpg")!),
        SearchMusic(title: "라", artist: "가수 4", playtime: 50, imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,
                   spacing: 8){
                Text("피날레 곡")
                    .padding(.leading, 20)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text("오늘의 피날레를 장식할 곡을 선택해 주세요.")
                    .padding(.leading, 20)
                    .font(.system(size: 17))
                
                SearchBar(text: $searchText, isSearching: isSearching)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 8, trailing: 0))
                    .onTapGesture {
                        isSearching = true
                    }
                
                if !isSearching { //입력 창 텍스트 없을 때
                    Text("최근 선택한 곡")
                        .padding(.leading, 20)
                        .font(.system(size: 14))
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(songs) { song in
                            VStack(alignment: .leading) {
                                AsyncImage(url: song.imageURL)
                                    .frame(width: 168, height: 168)
                                    .cornerRadius(16)
                                    .padding(.bottom, 4)
                                
                                Text(song.title)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                
                                Text(song.artist)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                else {//입력 창에 무언가 입력했을 때
                    Text("검색 결과")
                        .padding(.leading, 20)
                        .font(.system(size: 14))
                    
                    ForEach(searchSongs) { searchSong in
                        VStack(spacing: 9){
                            HStack(spacing: 12){
                                AsyncImage(url: searchSong.imageURL)
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(11)
                                
                                VStack(alignment: .leading, spacing: 0){
                                    Text(searchSong.title)
                                        .font(.system(size: 17))
                                        .frame(width: 200, height: 22, alignment: .leading)
                                    Text(searchSong.artist)
                                        .font(.system(size: 15))
                                        .foregroundColor(.customGray)
                                        .frame(width: 200, height: 20, alignment: .leading)
                                }
                                Text("\(searchSong.playtime)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.customGray)
                            }
                           Divider()
                        }
                    }
                    
                    
                }
                
            }
        }
    }
}


#Preview {
    SelectMusicView()
}
