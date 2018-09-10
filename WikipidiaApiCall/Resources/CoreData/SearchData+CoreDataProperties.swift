//
//  SearchData+CoreDataProperties.swift
//  WikipidiaApiCall
//
//  Created by 3Embed on 09/09/18.
//  Copyright © 2018 3Embed. All rights reserved.
//
//

import Foundation
import CoreData


extension SearchData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchData> {
        return NSFetchRequest<SearchData>(entityName: "SearchData")
    }

    @NSManaged public var tittle: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var mainUrl: String?
    @NSManaged public var discription: String?

}
