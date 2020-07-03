//
//  ServerManager.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
import UIKit

class ServerManager: NSObject {

    static let sharedInstance = ServerManager()
    
    /// Function to get articles from server
    /// - Parameters:
    ///   - pageCount: page number
    ///   - handler: handler to provide results back to view model
    func getArticleListFromServer(pageCount: Int, handler:@escaping ([Article]?, Error?)->Void) {
        
        //create the url with URL
        if let url = URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pageCount)&limit=10") {

            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            let request = URLRequest(url: url)

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    handler(nil, error)
                    return
                }

                guard let data = data else {
                    return
                }

               do {
                  // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode([Article].self, from: data)
                handler(response,nil)
               } catch let error {
                handler(nil, error)
               }
            })
            task.resume()
        }

    }
}

