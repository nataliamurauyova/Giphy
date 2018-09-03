//
//  FileManagerTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class FileManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFileManager_success() {
       
       let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
      
        let result = GiphyFileManager.copy(toCache: URL(string: docPath))
        XCTAssertNotNil(result)
        
    }
    
    func testFileManager_failure() {
        //let docPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let docPath = "https://www.tut.by/?crnd=40939"
        
        let result = GiphyFileManager.copy(toCache: URL(string: docPath))
        let resString = try? String(contentsOf: result!)
        XCTAssertNil(resString)
        
        
    }
    
    
}
