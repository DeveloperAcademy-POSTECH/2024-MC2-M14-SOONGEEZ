//
//  DateExtension.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/23/24.
//

import Foundation
extension Date {
    // 한국 시간대로 변환하는 함수
    func toKoreanTime() -> Date {
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let secondsFromGMT = TimeInterval(koreanTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(secondsFromGMT)
    }
    
    // 현재 한국 시간 가져오는 함수
    static func currentKoreanTime() -> Date {
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let now = Date()
        let secondsFromGMT = TimeInterval(koreanTimeZone.secondsFromGMT(for: now))
        return now.addingTimeInterval(secondsFromGMT)
    }
    
    // 현재 시간과의 차이를 초 단위로 계산하는 함수
    func secondsUntilDate() -> TimeInterval {
        let currentKoreanDate = Date.currentKoreanTime()
        let futureKoreanDate = self.toKoreanTime()
        return futureKoreanDate.timeIntervalSince(currentKoreanDate)
    }
}

//// 예제 사용법
//let dateString = "2024-05-23 01:16:51 +0000"
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//if let date = dateFormatter.date(from: dateString) {
//    let koreanTime = date.toKoreanTime()
//    print("한국 시간으로 변환된 날짜: \(koreanTime)")
//    
//    let secondsUntil = date.secondsUntilDate()
//    print("현재 시간으로부터 남은 초: \(secondsUntil)")
//}
