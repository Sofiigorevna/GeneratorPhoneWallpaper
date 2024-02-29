//
//  Networking.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 27.02.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let sharedInstance = NetworkManager()
    let global = DispatchQueue.global(qos: .utility)
    
    private func createURL(baseURL: String, path: String?, queryItems: [URLQueryItem]? = nil) -> URL? {
        // Проверяем, есть ли путь (path)
        if let path = path, !path.isEmpty {
            // Если путь существует и не пуст, создаем URL с полным путем
            var components = URLComponents(string: baseURL)
            components?.path = path
            components?.queryItems = queryItems
            return components?.url
        } else {
            // Если путь отсутствует или пуст, используем базовый URL
            return URL(string: baseURL)
        }
    }
    
    let apiKey = "TouFyL4VyhWWNhqC3DnF5hAdR2fLXxgGY4Gpe4BqC8YGKE2j4NjuNrJAXetE"
    
    func fetchAPIData(prompt: String,
                      completion: @escaping (Result<GenerateImageResponse, Error>) -> Void) {
        let baseURL = "https://stablediffusionapi.com"
        let urlPath = "/api/v3/text2img"
        let queryItem = [URLQueryItem(name: "model_id", value: "protovision-xl-high-fidel"),
                         URLQueryItem(name: "key", value: apiKey),
                         URLQueryItem(name: "width", value: "512"),
                         URLQueryItem(name: "height", value: "512"),
                         URLQueryItem(name: "samples", value: "1"),
                         URLQueryItem(name: "prompt", value: prompt),
                         URLQueryItem(name: "negative_promt", value: "painting, extra fingers, mutated hands, poorly drawn hands, poorly drawn face, deformed, ugly, blurry, bad anatomy, bad proportions, extra limbs, cloned face, skinny, glitchy, double torso, extra arms, extra hands, mangled fingers, missing lips, ugly face, distorted face, extra legs, anime"),
                         URLQueryItem(name: "num_inference_steps", value: "51"),
                         URLQueryItem(name: "guidance_scale", value: "7.5")
        ]
                
        let urlRequest = createURL(baseURL: baseURL, path: urlPath, queryItems: queryItem)
        
        guard let url = urlRequest else {
            return
        }
        
        let parametrs: Parameters = [
            "model_id": "protovision-xl-high-fidel",
            "key": apiKey,
            "width": "512",
            "height": "512",
            "samples": "1",
            "prompt": prompt,
            "negative_promt": "painting, extra fingers, mutated hands, poorly drawn hands, poorly drawn face, deformed, ugly, blurry, bad anatomy, bad proportions, extra limbs, cloned face, skinny, glitchy, double torso, extra arms, extra hands, mangled fingers, missing lips, ugly face, distorted face, extra legs, anime",
            "num_inference_steps": "51",
            "guidance_scale": "7.5"
        ]

        AF.request(
            url,
            method: .post,
            parameters: parametrs,
            encoding: JSONEncoding.default,
            headers: nil,
            interceptor: nil
        ).response { resp in
            switch resp.result {
            case .success(let data):
                do {
                    if let data = data {
                        let jsonData = try JSONDecoder().decode(GenerateImageResponse.self, from: data)
                        completion(.success(jsonData))
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

