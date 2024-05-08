//
//  NetworkingManager.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/07.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    
    private let apiKey = "2a44868b8868a34c1ff294ecd8bafb75"
    private let baseURL = "https://dapi.kakao.com/v3/search/book"
    
    func searchBooks(query: String, completion: @escaping (Result<Data, Error>) -> Void) {
        // 검색어를 인코딩하여 쿼리스트링에 추가
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            let error = NSError(domain: "EncodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to encode query"])
            completion(.failure(error))
            return
        }
        
        // 요청 URL 생성
        let urlString = "\(baseURL)?query=\(encodedQuery)"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "URLCreationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create URL"])
            completion(.failure(error))
            return
        }
        
        // HTTP 요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 요청 헤더에 API 키 추가
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // URLSession을 사용하여 데이터 요청
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "InvalidResponseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        // 요청 실행
        task.resume()
    }
}
