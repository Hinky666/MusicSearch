//
//  DataController.swift
//  Search Music
//
//  Created by mabookpro4 on 12/11/19.
//  Copyright © 2019 mabookpro4. All rights reserved.
//

import Foundation

let BASE_URL = "​​https://itunes.apple.com/search?term=jack"

class DataController {
    
    static let instance = DataController()
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        
        
        //let url = URL(string: "\(BASE_URL)\(searchString)")
        //let myurl = URL(string: "https://itunes.apple.com/search?term=jack")
        
        let session = URLSession.shared
        session.dataTask(with: URL(string: "\(BASE_URL)\(searchString)")!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json["results"] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo["artistName"] as? String else {return}
                                guard let artworkUrl30 = albumInfo["artworkUrl30"] as? String else {return}
                                guard let contentPrice = albumInfo["contentPrice"] as? String else {return}
                                guard let collectionId = albumInfo["collectionId"] as? Int else {return}
                                guard let collectionName = albumInfo["collectionName"] as? String else {return}
                                let albumInstance = Album(artistName: artistName, artworkUrl30: artworkUrl30, contentPrice: contentPrice, collectionName: collectionName, collectionId: collectionId)
                                albums.append(albumInstance)
                            }
                        }
                        complition(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
            }.resume()
    }
    
    
}
