//
//  SelectMusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct SelectMusicView: View {
    
    @Environment(\.dismiss) var dismiss

    
    @State private var searchText = ""
    @State private var filteredSongs: [Music] = []
    @State private var clickedSong: Music?
    @Binding var selectSong: Music?
    
    let songs: [Music] = [
        Music(title: "Cookie", artist: "가수1", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "가수2", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),        Music(title: "Cookie", artist: "가수3", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
    ]
    
    
    let searchSongs: [Music] = [
        Music(title: "Cookie", artist: "가수1", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "가수2", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),        Music(title: "Cookie", artist: "가수3", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "가", artist: "가수1", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "나", artist: "가수2", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),        Music(title: "Cookie", artist: "가수3", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Music(title: "다", artist: "Muse", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),
        
        
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
                                self.filteredSongs = []
                                self.clickedSong = nil
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
                            self.filteredSongs = []
                            self.clickedSong = nil
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
                        ForEach($filteredSongs, id: \.id) { song in
                            HStack(spacing: 12){
                                AsyncImage(url: song.wrappedValue.imageURL)
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(11)
                                
                                VStack(alignment: .leading, spacing: 0){
                                    Text(song.wrappedValue.title)
                                        .font(.system(size: 17))
                                        .frame(width: 260, height: 22, alignment: .leading)
                                    Text(song.wrappedValue.artist)
                                        .font(.system(size: 15))
                                        .foregroundColor(.customGray)
                                        .frame(width: 260, height: 20, alignment: .leading)
                                }
                                Text(song.wrappedValue.length)
                                    .font(.system(size: 12))
                                    .foregroundColor(.customGray)
                            }.onTapGesture {
                                clickedSong = song.wrappedValue
                                print("선택함")
                                print(clickedSong!)
                            }
                            
                        }
                        .frame(maxHeight: 300)
                        
                        if clickedSong != nil {
                            VStack{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 353, height: 80)
                                        .background(Color.customGray100)
                                        .cornerRadius(16)
                                    
                                    
                                    HStack(spacing: 16){
                                        AsyncImage(url: clickedSong!.imageURL) //이미지 바꾸기
                                            .frame(width: 44, height: 44)
                                            .cornerRadius(11)
                                        
                                        VStack(alignment: .leading, spacing: 0){
                                            Text(clickedSong!.title)
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
                                    .frame(width: 353, height: 50)
                                    .font(.system(size: 17))
                                    .foregroundStyle(Color.white)
                                
                                    .background{
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.customPurple100)
                                    }
                                
                                    .onTapGesture {
                                        selectSong = clickedSong!
                                        dismiss()
                                    }
                            }
                            .padding(.bottom, 84)
                        }
                        
                }
            }
            
        }
    }
}



#Preview {
    SelectMusicView(selectSong: .constant(nil))
}

