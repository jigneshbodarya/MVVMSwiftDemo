//
//  MainDataProvider.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import Foundation
import Alamofire
import PromiseKit

class MainDataProvider {
    
    //MARK: Api Call for Get Song List
    func getSongsList(strUrl: String, params: [String:Any]) -> Promise<Any> {
        
        let fullURL = String.init(format: "%@%@", arguments: [Base_URL,strUrl])
        return Promise { seal in
            Alamofire
                .request(fullURL.toUrl(), method: .get,parameters: params, encoding: URLEncoding(destination: .queryString, boolEncoding: .literal), headers: nil)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let dictionary = json  as? [String: AnyObject] else {
                            seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                            return
                        }
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dictionary as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
                            guard let songResponse = try? JSONDecoder().decode(SongsResponse.self, from: jsonData) else {
                                seal.reject(RuntimeError("Invalid JSON"))
                                return
                            }
                            seal.fulfill(songResponse)
                        } catch let error {
                            seal.reject(error)
                        }
                    case .failure(let error):
                        var strError: String?
                        if let data = response.data {
                            let json = String(data: data, encoding: String.Encoding.utf8)
                            if let dictData = json?.toJSON() as? [String: AnyObject] {
                                if let errors: [AnyObject] = dictData["modelError"] as? [AnyObject] {
                                    print("ERROR ARRAY : \(errors)")
                                    
                                    if let dictError: [String: Any] = errors[0] as? [String: Any] {
                                        print("ERROR ARRAY : \(dictError)")
                                        
                                        if let err : [String] = dictError["value"] as? [String] {
                                            strError = err[0]
                                        }
                                    }
                                } else {
                                    if let message = dictData["message"] as? String {
                                        strError = message
                                    }
                                }
                            }
                        }
                        if let message = strError {
                            seal.fulfill(message)
                        } else {
                            seal.reject(error)
                        }
                    }
                }
        }
    }
}
