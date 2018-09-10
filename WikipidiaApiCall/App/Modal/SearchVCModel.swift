//
//  SearchVCModel.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class SearchVCModel: NSObject {

    struct searchedPages {
        var tittle              : String
        var discription         : String
        var pageUrl             : String
        var imageUrl            : String
        
        
        init(tittle: String, discription: String, pageUrl: String, imageUrl: String) {
            self.tittle         = tittle
            self.discription    = discription
            self.pageUrl        = pageUrl
            self.imageUrl       = imageUrl
        }
    }
    
    var statusCode: Int!
    var requestType: RequestType!
    var totallSearchData: [searchedPages]!
    
    func initializeModel(dataDict: [String: Any], httpResponseCode: Int, requestType: RequestType) {
        totallSearchData = []
        totallSearchData.removeAll()
        if dataDict[ResponseString.query] != nil {
            let querPages = GenericUtility.dictionaryForObj(object: dataDict[ResponseString.query]!)
            let pageArray = GenericUtility.arrayForObj(object: querPages[ResponseString.pages])
            for data in pageArray {
                let searchStruct = searchedPages.init(
                    tittle: GenericUtility.strForObj(object: data[ResponseString.title]!),
                    discription: getDiscription(GenericUtility.dictionaryForObj(object:data)),
                    pageUrl: GenericUtility.strForObj(object: data[ResponseString.fullurl]!),
                    imageUrl: getImageUrl(GenericUtility.dictionaryForObj(object:data)))
                totallSearchData.append(searchStruct)
            }
        }
        statusCode = httpResponseCode
        self.requestType = requestType
    }
    
    
    func getDiscription(_ data: [String: Any])-> String {
        let dicDict = GenericUtility.dictionaryForObj(object: data[ResponseString.terms])
        let disArray = GenericUtility.arrayForObj(object: dicDict[ResponseString.description])
        if disArray.count == 0 {
            return ""
        }
        return  GenericUtility.strForObj(object: disArray[0])
    }
    
    func getImageUrl(_ data: [String: Any])-> String {
        let thumnailDict = GenericUtility.dictionaryForObj(object: data[ResponseString.thumbnail])
        return GenericUtility.strForObj(object: thumnailDict[ResponseString.source])
    }
    
}
