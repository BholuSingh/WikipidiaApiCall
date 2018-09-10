//
//  WikipidiaApiCallTests.swift
//  WikipidiaApiCallTests
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import XCTest
@testable import WikipidiaApiCall

class WikipidiaApiCallTests: XCTestCase {
    
    var apiCallM = ApiCallClass()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// for Api testing following test Cases Have Been Deployed
    func testCallApiForSearch() {
        apiCallM.apiCall(searchString: "Neha", requestType: RequestType.searchApi) { (response) in
            XCTAssert(response.data["query"] != nil, "Api Call Is Sucess")
        }
        
        apiCallM.apiCall(searchString: "Neha+Dhupia", requestType: RequestType.searchApi) { (response) in
            XCTAssert(response.data["query"] != nil, "Api Call Is Sucess")
        }
        
        apiCallM.apiCall(searchString: "gajhdgsaj+kajdshadkjfasd", requestType: RequestType.searchApi) { (response) in
            XCTAssert(response.data["query"] == nil, "we  did got any Data For The String")
        }
        
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
