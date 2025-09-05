//
//  Network.swift
//  HatchVidAssignment
//
//  Created by Vikas Mehay on 2025-09-04.
//

import Foundation
import UIKit
struct Response : Decodable {
    let videos : [String]
}

class Network {
    func getFeed(completion : @escaping ([URL]) -> Void) {
        guard let url = URL(string: Constants.feedUrl) else {
            print(#function, "Error converting string to URL...###")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(#function, "Error Decoding response...###")
                completion([])
               return
            }
            print(#function, "RESPONSE : \(response)")
            completion(response.videos.compactMap({URL(string: $0)}))
        }.resume()
    }
    
}
