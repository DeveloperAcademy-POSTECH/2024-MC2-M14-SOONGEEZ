import SwiftUI


extension Color{
    static let customGray = Color(hex: "8A8A8E") 
    static let customGray100 = Color(hex: "F5F5F5") 
    static let customGray200 = Color(hex: "F1F1F1")
    static let customPurple = Color(hex: "DBD9EE")
    static let customPurple100 = Color(hex: "7E70EC")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
