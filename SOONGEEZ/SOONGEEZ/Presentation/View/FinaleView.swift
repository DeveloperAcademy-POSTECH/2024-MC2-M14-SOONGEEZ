//
//  FinaleSelctedView.swift
//  SOONGEEZ
//
//  Created by 김은정 on 5/21/24.
//

import SwiftUI


struct FinaleView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var makePlaylist: Bool
    
    @State var date = Date()
    @State var showDatepicker = false
    
    @State private var showSelectMusicView = false
    @State var selectSong: Music?

    
    
    var body: some View {
        ZStack{
            Color.customGray200.edgesIgnoringSafeArea(.all)
            Image("backgroundDecoration")
                .resizable()
                .scaledToFit()
                .frame(width:393, height:486)
                .padding(.top, 330)
            
            VStack{
                HStack{
                    Image("textLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:69, height:21)
                        .padding(20)
                    Spacer()
                } //피날레로고
                Spacer()
                    .frame(height:29)
                
                VStack(alignment: .leading, spacing: 11){
                    Text("종료시간")
                        .fontWeight(.semibold)
                        .font(.system(size:17))
                    //                        .padding(.leading, 56)
                        .padding(.bottom, 6)
                    
                    Text(formatDate(date))
                        .font(.system(size: 34))
                    //                        .padding(.leading, 56)
                        .onTapGesture {
                            showDatepicker = true
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 1)
                        .background(Color(red: 0.26, green: 0.26, blue: 0.26))
                    
                    Text("피날레 곡")
                        .fontWeight(.semibold)
                        .font(.system(size:17))
                        .padding(.top, 29)
                        .padding(.bottom, 9)
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.thickMaterial)
                            .strokeBorder(Color.black)
                            .frame(width: 282, height: 341)
                        
                        if selectSong != nil {  finale  }
                        else {  recode  }
                    }
                    .onTapGesture { showSelectMusicView = true }
                    
                }
                .padding(.horizontal, 56)
                .padding(.bottom, 75)
                
                if selectSong != nil {
                    ActivePlaylistMakeBtn
                        .onTapGesture{  makePlaylist = true }
                }
                else {  PlaylistMakeBtn  }
                
            }
            .sheet(isPresented: $showDatepicker){
                VStack(alignment: .leading){
                    Text("종료시간")
                        .font(.system(size:24))
                        .fontWeight(.semibold)
                    Text("플레이리스트가 종료 될 시간을 선택해주세요.")
                        .font(.system(size:17))
                    
                    HStack{
                        Spacer()
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: [.hourAndMinute]
                        )/*.datePickerStyle(.wheel)*/
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        Spacer()
                    }
                    Button(action: {
                        showDatepicker = false
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
        VStack(alignment: .center){
            
            Image("recordAudio") //오디오이미지
                .resizable()
                .frame(width:250, height:249)
                .background(Color.customPurple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaledToFit()
            
            
            VStack(alignment: .center, spacing: 8){
                Text("피날레 곡을 선택해주세요")
                //                        .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(height: 20)
                
                Image(systemName: "plus.circle.fill")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.gray)
                    .frame(height: 15)
            }
        }
        .frame(width:250, height: 309)
    }
    
    
    
    
    var finale: some View {
        ZStack{
            RoundedRectangle(cornerRadius:  16)
                .fill(.thickMaterial)
                .strokeBorder(Color.black)
                .frame(width:282, height:341)
            
            VStack(alignment: .leading){
                AsyncImage(url: $selectSong.wrappedValue?.imageURL)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaledToFit()
                    .frame(width:250, height:249)
                
                VStack(alignment: .leading, spacing: 8){
                    Text(selectSong!.title)
                        .font(.title3.weight(.semibold))
                        .frame(height: 20)
                    
                    
                    Text(selectSong!.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(height: 15)
                    
                }
                //                .frame(width:200, height: 43)
                
            }
            .frame(width:250, height: 309)
        }
    }
    
    
    var PlaylistMakeBtn: some View {
        HStack{
            Image(systemName: "play.fill")
                .foregroundStyle(Color.gray)
            Text(" 플레이리스트 생성하고 재생")
                .foregroundStyle(Color.gray)
        }
        .frame(width: 353, height: 50)
        .background{
            RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)}
    }
    
    var ActivePlaylistMakeBtn: some View {
        HStack{
            Image(systemName: "play.fill")
                .foregroundStyle(Color.white)
            Text(" 플레이리스트 생성하고 재생")
                .foregroundStyle(Color.white)
        }
        .frame(width: 353, height: 50)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customPurple100)
            
        }
    }
    
}


#Preview {
    FinaleView(makePlaylist: .constant(false))
}
