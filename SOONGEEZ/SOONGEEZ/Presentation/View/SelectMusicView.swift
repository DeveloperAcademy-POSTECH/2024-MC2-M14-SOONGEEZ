//
//  SelectMusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct SelectMusicView: View {
    
    @State private var searchText = ""
    @State private var filteredSongs: [SearchMusic] = []
    @State private var clickedSongs = false
    
    let songs: [LastFinaleMusic] = [
        LastFinaleMusic(title: "노래 제목 1", artist: "가수 1", imageURL: URL(string: "https://example.com/image1.jpg")!),
        LastFinaleMusic(title: "노래 제목 2", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "Starlight", artist: "Muse", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    
    let searchSongs: [SearchMusic] = [
        SearchMusic(title: "가", artist: "가수 1", playtime: "3-30", imageURL: URL(string: "https://example.com/image1.jpg")!),
        SearchMusic(title: "나", artist: "가수 2", playtime: "3-30", imageURL: URL(string: "https://example.com/image2.jpg")!),
        SearchMusic(title: "다", artist: "Muse", playtime: "3-30", imageURL: URL(string: "https://example.com/image2.jpg")!),
        SearchMusic(title: "라", artist: "가수 4", playtime: "3-30", imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    func performSearch() {
        filteredSongs = searchSongs.filter { song in
            song.title.lowercased().contains(searchText.lowercased())
        }
    }
    
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
                
                HStack { //검색 창
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onCommit: performSearch)
                            .foregroundColor(.primary)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .padding(EdgeInsets(top: 7, leading: 8, bottom: 7, trailing: 8))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Text("Cancel")
                                .foregroundColor(.blue)
                                .font(.system(size: 17))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 8, trailing: 0))
                
                if searchText.isEmpty { //입력 창 텍스트 없을 때
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
                    
                    ForEach(filteredSongs, id: \.id) { song in
                        VStack(spacing: 9){
                            HStack(spacing: 12){
                                AsyncImage(url: song.imageURL)
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(11)
                                
                                VStack(alignment: .leading, spacing: 0){
                                    Text(song.title)
                                        .font(.system(size: 17))
                                        .frame(width: 260, height: 22, alignment: .leading)
                                    Text(song.artist)
                                        .font(.system(size: 15))
                                        .foregroundColor(.customGray)
                                        .frame(width: 260, height: 20, alignment: .leading)
                                }
                                Text(song.playtime)
                                    .font(.system(size: 12))
                                    .foregroundColor(.customGray)
                            }.onTapGesture {
                                self.clickedSongs = true
                            }
                            Divider()
                            
                            if clickedSongs {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 353, height: 80)
                                        .background(Color.customGray100)
                                        .cornerRadius(16)
                                    
                                    
                                    HStack(spacing: 16){
                                        AsyncImage(url: song.imageURL) //이미지 바꾸기
                                            .frame(width: 44, height: 44)
                                            .cornerRadius(11)
                                        
                                        VStack(alignment: .leading, spacing: 0){
                                            Text(song.title)
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .frame(width: 260, height: 22, alignment: .leading)
                                            Text("오늘의 피날레 곡으로 선택할게요.")
                                                .font(.system(size: 16))
                                                .frame(width: 260, height: 20, alignment: .leading)
                                        }
                                    }
                                }.padding(.bottom, 16)
                                    .padding(.top, 360)
                                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                
                                Text("확인")
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 160)
                                    .font(.system(size: 17))
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                            
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
