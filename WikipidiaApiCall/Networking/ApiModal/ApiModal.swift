//
//  ApiModal.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class APIResponseModel {
    
    var httpStatusCode:Int = 0
    /// Data in DIctionary format
    var data: [String: Any] = [:]
    var responseType: RequestType? = nil
    
    
    init(statusCode:Int, dataResponse:[String:Any], responseType: RequestType?) {
        
        httpStatusCode = statusCode
        data = dataResponse
        self.responseType = responseType
    }
}
