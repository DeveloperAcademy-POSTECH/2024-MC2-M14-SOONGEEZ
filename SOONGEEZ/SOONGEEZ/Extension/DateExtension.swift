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

