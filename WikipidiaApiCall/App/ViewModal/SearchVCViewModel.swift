//
//  SearchVCViewModel.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class SearchVCViewModel: NSObject {
    var apiCal = ApiCallClass.sharedInstance()
    var searchM = SearchVCModel()
    
    var searchString = ""
    
    /// Get the Tittle of search
    ///
    /// - Parameter index: index path
    /// - Returns: it returns the tittle
    func getTittle(index: Int)-> String {
        if searchM.totallSearchData.count > index {
            return searchM.totallSearchData[index].tittle
        }
        return ""
    }
    
    /// get discription of the Search Item
    ///
    /// - Parameter index: index path
    /// - Returns: it returns The Discription String
    func getDiscription(index: Int)-> String {
        if searchM.totallSearchData.count > index {
            return searchM.totallSearchData[index].discription
        }
        return ""
    }
    
    /// Get Image Url of the Index
    ///
    /// - Parameter index: index Path
    /// - Returns: it returns the imageUrl String
    func getImageUrl(index: Int)-> String {
        if searchM.totallSearchData.count > index {
            return searchM.totallSearchData[index].imageUrl
        }
        return ""
    }
    
    /// Get main Url of the search Item
    ///
    /// - Parameter index: Index path
    /// - Returns: it return the MainUrl
    func getmainUrl(index: Int)-> String {
        if searchM.totallSearchData.count > index {
            return searchM.totallSearchData[index].pageUrl
        }
        return ""
    }
    
    /// get the totall number of reponse itmes
    ///
    /// - Returns: it return the count
    func getTotallNumOfCells()->Int {
        if searchM.totallSearchData != nil {
            return searchM.totallSearchData.count
        }else {
            return 0
        }
    }
    
}

extension SearchVCViewModel {
    
    /// Api call For the result
    ///
    /// - Parameters:
    ///   - searchText: text to be searched
    ///   - completionHandler: to send the Api Response 
    func searchTextInWikipidiaApiCall(searchText: String, completionHandler: @escaping((Bool) -> Void)) {
        searchString = searchText
        DispatchQueue.background(background: {
            self.apiCal.apiCall(searchString: searchText, requestType: RequestType.searchApi) { (response) in
                self.searchM.initializeModel(dataDict: response.data, httpResponseCode: response.httpStatusCode, requestType: response.responseType!)
                DispatchQueue.main.async() {
                    completionHandler(true)
                }
            }
        }, completion:{
            
        })
        
    }
    
}


