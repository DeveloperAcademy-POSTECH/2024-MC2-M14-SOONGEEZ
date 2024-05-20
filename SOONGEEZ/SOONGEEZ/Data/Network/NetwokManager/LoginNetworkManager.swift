//
//  LoginNetworkManager.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/20/24.
//

import Foundation

class LoginNetworkManager: ObservableObject {
    @Published var fetchedUrl: String?

    func fetchUrl(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("유효하지 않은 URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("받은 데이터 없음")
                return
            }

            do {
                let urlResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                DispatchQueue.main.async {
                    self.fetchedUrl = urlResponse.url
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }

        task.resume()
    }
}

