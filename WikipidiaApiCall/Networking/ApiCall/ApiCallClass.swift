//
//  ApiCallClass.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit


class ApiCallClass: NSObject {
    
    static var apiCallObj: ApiCallClass? = nil
    
    class func sharedInstance()-> ApiCallClass {
        if apiCallObj == nil {
            apiCallObj = ApiCallClass()
        }
        return apiCallObj!
    }

    var url : String = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cinfo%7Cpageterms&generator=prefixsearch&redirects=1&inprop=url&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch="
    var gpsLimit = "&gpslimit=10"
    
    /// api Call For WikiPidia
    ///
    /// - Parameters:
    ///   - searchString: String to be Searched
    ///   - requestType: Request type Of the Api
    ///   - completionHandler: pass the APIResponse Model Object
    func apiCall(searchString: String, requestType: RequestType, completionHandler: @escaping ((APIResponseModel) -> Void)) {
        
    let urlString = URL(string: url + searchString + gpsLimit)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("error \(httpResponse.statusCode)")
                    }
                    print(error!.localizedDescription)
                } else {
                    if let usableData = data {
                        var dataRes: [String: Any]!
                        var errorCode = 0
                        let string = String(data: usableData, encoding: String.Encoding.utf8)
                        if let data = string!.data(using: .utf8) {
                            do {
                                let mainData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                                if let myDictionary = mainData
                                {
                                    dataRes = myDictionary
                                }
                           
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        if let httpResponse = response as? HTTPURLResponse {
                            errorCode = httpResponse.statusCode
                            print("error \(httpResponse.statusCode)")
                        }
                        self.parseApiResponse(dataDict: dataRes, errorCode: errorCode, completion: { (res) in
                            completionHandler(res)
                        })
                        print(string) //JSONSerialization
                    }
                }
            }
            task.resume()
        }
    }
    
    /// Parse the response to a Model
    ///
    /// - Parameters:
    ///   - dataDict: response of the Dictionary
    ///   - errorCode: error code
    ///   - completion: passes the model object
    func parseApiResponse(dataDict: [String: Any], errorCode: Int, completion: @escaping(APIResponseModel)->Void) {
        let responModel = APIResponseModel.init(statusCode: errorCode, dataResponse: dataDict, responseType: RequestType.searchApi)
        completion(responModel)
    }
    
    
}
