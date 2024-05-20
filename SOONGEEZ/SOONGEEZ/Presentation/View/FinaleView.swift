//
//  FinaleView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct FinaleView: View {
    @State var date = Date()
    @State var showDatepicker = false
    @State private var showSelectMusicView = false
    
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
                    .padding(.leading, 56)
                    .padding(.bottom, 5)
                
                Text(formatDate(date))
                    .font(.system(size: 34))
                    .padding(.leading, 56)
                    .onTapGesture {
                        showDatepicker = true
                    }
                Path { path in
                    path.move(to: CGPoint(x: 56, y: 0)) // 선을 시작할 위치를 설정합니다.
                    path.addLine(to: CGPoint(x: 220, y: 0)) // 선으로 이어질 위치를 설정합니다.
                }
                .stroke(Color.black, lineWidth: 1)
                .frame(height: 1)
                
                Text("피날레 곡")
                    .fontWeight(.semibold)
                    .font(.system(size:17))
                    .padding(.leading, 56)
                    .padding(.top, 29)
                    .padding(.bottom, 9)
                
                
                ZStack{
                    RoundedRectangle(cornerRadius:  16)
                        .fill(.thickMaterial)
                        .strokeBorder(Color.black)
                        .frame(width:282, height:341)
                        .padding(.leading, 56)
                    
                    VStack(spacing:0){
                        
                        Image("recordAudio") //오디오이미지
                            .resizable()
                            .scaledToFit()
                            .frame(width:250, height:249)
                        //                        .padding(.bottom, 14)
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.customPurple)
                            }
                        
                        
                        Text("피날레 곡을 선택해주세요")
                            .font(.system(size:17))
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                            .padding(.top, 14)
                        
                        
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                        
                        
                    }.padding(.leading, 56)
                } // 피날레음악선택버튼
                .onTapGesture{
                    showSelectMusicView = true
                }
            }
            Button(action: {
                
            }, label: {
                HStack{
                    Image(systemName: "play.fill")
                        .foregroundStyle(Color.gray)
                    Text(" 플레이리스트 생성하고 재생")
                        .foregroundStyle(Color.gray)
                }.padding([.vertical],16.5)
                    .padding([.horizontal],70.5)
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    }
            }).padding(.top ,65)
            
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
                SelectMusicView()
                    .padding(.top, 40)
                    .presentationDragIndicator(.visible)

            }
            
            
    }
        
    }

        
}


func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "a hh:mm" // 오전/오후와 시간을 표시합니다.
    formatter.locale = Locale(identifier: "ko_KR") // 한국 시간 형식으로 설정합니다.
    return formatter.string(from: date)
}



#Preview {
    FinaleView()
}
