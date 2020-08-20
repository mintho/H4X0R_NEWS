//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(_ searchTerm: String? = nil) {
        var urlString = ""
        if searchTerm == nil || searchTerm == "" {
            urlString = "https://hn.algolia.com/api/v1/search?tags=front_page"
        } else {
            urlString = "http://hn.algolia.com/api/v1/search?query="+searchTerm!+"&tags=story"
        }
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error!)
                }
            }
            task.resume()
        }
    }
}
