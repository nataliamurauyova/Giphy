//
//  GifDownloaderTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GifDownloaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func gifWithUrl_success() {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let gif = UIImage.gif(url: path)
        XCTAssertNotEqual(gif, nil)
    }
    func gifWithUrl_failure() {
        let path = " "
        let gif = UIImage.gif(url: path)
        XCTAssertEqual(gif, nil)
    }
    
    func gifWithData_success() {
        let gifUrl = URL(string: "https://media2.giphy.com/media/fCTq9mvXq8tajg0zp0/giphy-preview.gif?cid=e1bb72ff5b8ce93132684241638e1516")
        let data = try? Data(contentsOf: gifUrl!)
        XCTAssertNotEqual(data, nil)
    }
    
    func gifWithData_failure() {
        let gifUrl = URL(string: " ")
        let data = try? Data(contentsOf: gifUrl!)
        XCTAssertEqual(data, nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
