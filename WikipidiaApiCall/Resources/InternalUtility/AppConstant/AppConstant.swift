//
//  AppConstant.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import Foundation

struct SearchVC {
    static let tableViewEstimatedHeight = 400
}

struct TableViewCell {
    static let seacrhTableViewCell        = "searchCell"
    static let noNetworkCell              = "noNetworkCell"
}


struct SegueID {
    static let SearchVCToDetailWebVC = "ShowWebPage"
}


enum RequestType: Int {
    case searchApi
}

struct ResponseString {
    static let query                    = "query"
    static let pages                    = "pages"
    static let title                    = "title"
    static let fullurl                  = "fullurl"
    static let terms                    = "terms"
    static let description              = "description"
    static let thumbnail                = "thumbnail"
    static let source                   = "source"
}

struct UserDefaultString {
    static let networkRechability       = "NetworkRechability"
}


