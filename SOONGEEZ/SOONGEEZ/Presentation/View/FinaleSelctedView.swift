//
//  FinaleSelctedView.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import SwiftUI

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
}


struct FinaleSelctedView: View {
    
    func postPlaylist() async {
        do {
            let finishTime = date.secondsUntilDate()
            
            print("끝나는 시간", finishTime)
            
            PlaylistSongs = try await PlaylistService.shared.PostPlaylistData(restTime: Int(finishTime), finaleInfo: (title: selectSong!.title, artist: selectSong!.artist, videoId: selectSong!.videoId))
            
            print(PlaylistSongs)
            
        } catch {
            print("에러 발생: \(error)")
        }
    }
    
    func performPlaylist() { //필터링
        Task {
            await postPlaylist()
        }
    }
    
    @Environment(\.dismiss) var dismiss
    

    @Binding var PlaylistSongs: [SearchModel]
    
    @Binding var makePlaylist: Bool
    
    @State var date = Date()
    @State var showDatepicker = false
    
    @State private var showSelectMusicView = false
    @Binding var selectSong: SearchModel?

    
    var body: some View {
        ZStack{
            
            Image("img_finaleView")
                .scaledToFill()
                .ignoresSafeArea()
        
            VStack {
                HStack {
                    Image("textLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 69, height: 21)
                        .padding(.top, 74)
                    Spacer()
                }
                .padding(.leading, 20)
                Spacer()
                    .frame(height: 58)
            
                VStack(alignment: .leading, spacing: 8){
                    Text("종료시간")
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                    
                    Text("플레이리스트가 종료될 시간을 선택해 주세요.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 353, height: 60)
                            .background(.white)
                            .cornerRadius(16)
                        
                        Text(formatDate(date))
                            .font(.system(size: 28))
                            
                    }
                        .onTapGesture {
                            showDatepicker = true
                        }
                    
                    Text("피날레 곡")
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                        .padding(.top, 41)
                    
                    
                    Text("플레이리스트의 마지막을 장식할 피날레 곡을 선택해 주세요.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    
                        VStack{
                            if selectSong != nil {
                            finale
                            }
                            else {
                                recode
                        }
                    }
                        //.padding(.bottom, 75)
                    .onTapGesture { showSelectMusicView = true }
                }
                .padding(.bottom, 75)
                
                if selectSong != nil {
                    ActivePlaylistMakeBtn
                        .padding(.bottom, 59)
                        .onTapGesture{
                            makePlaylist = true
                            self.performPlaylist()
                        }
                }
                else {
                    PlaylistMakeBtn
                        .padding(.bottom, 59)
                }
                
            }
            .sheet(isPresented: $showDatepicker){
                VStack(alignment: .leading){
                    Text("종료시간")
                        .font(.system(size:24))
                        .fontWeight(.semibold)
                        .padding(.bottom, 8)
                    
                    Text("플레이리스트가 종료 될 시간을 선택해주세요.")
                        .font(.system(size:17))
                    
                    HStack{
                        Spacer()
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: [.hourAndMinute]
                        )
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        Spacer()
                    }
                    Button(action: {
                        showDatepicker = false
                        print(date)
                    }) {
                        Text("확인")
                            .foregroundStyle(Color.white)
                            .padding([.vertical], 16.5)
                            .padding([.horizontal], 161)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.customPurple100)
                            }
                    }
                }
                .padding(20)
                .datePickerStyle(.wheel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showSelectMusicView) {
                SelectMusicView(selectSong: $selectSong)
                    .padding(.top, 40)
                    .presentationDragIndicator(.visible)
                
            }
            
        }
        
    }
    
    var recode: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .frame(width: 353, height: 272)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 0)
            
            VStack(alignment: .center){
                
                Image("img_radio") //오디오이미지
                    .resizable()
                    .frame(width: 321, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaledToFit()
                
                VStack(alignment: .center, spacing: 8){
                    Text("피날레 곡을 선택해주세요")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .frame(height: 20)
                        .padding(.top, 8)
                    
                    Image(systemName: "plus.circle.fill")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.gray)
                        .frame(height: 15)
                        .padding(.top, 1)
                        .padding(.bottom, 8)
                }
            }
            .frame(width: 321, height: 181)
        }
    }
    
    
    
    
    var finale: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .frame(width: 353, height: 272)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 0)
            
            VStack(alignment: .leading){
                AsyncImage(url: $selectSong.wrappedValue?.thumbnail){ image in
                    image.image?.resizable()
                }
                    .scaledToFit()
                    .frame(width: 321, height: 180)
                    .scaledToFit()
                    .cornerRadius(10)

                
                VStack(alignment: .leading, spacing: 8){
                    Text(selectSong!.title)
                        .font(.title3.weight(.semibold))
                        .frame(height: 20)
                    
                    
                    Text(selectSong!.artist)
                        .foregroundColor(.gray)
                        .frame(height: 15)
                    
                }

            }
            .frame(width: 353, height: 272)
        }
    }
    
    
    var PlaylistMakeBtn: some View {
        HStack{
            Text("플레이리스트 생성하기")
                .foregroundStyle(Color.white)
        }
        .frame(width: 353, height: 50)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.78, green: 0.78, blue: 0.8))
        }
    }
    
    var ActivePlaylistMakeBtn: some View {
        HStack{
            Text("플레이리스트 생성하기")
                .foregroundStyle(Color.white)
        }
        .frame(width: 353, height: 50)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customPurple100)
        }
    }
    
}












//
//#Preview {
//    FinaleSelctedView(makePlaylist: .constant(false), PlaylistSongs: PlaylistView, selectSong: .constant(nil))
//
//}
