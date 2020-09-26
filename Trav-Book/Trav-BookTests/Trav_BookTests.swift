//
//  Trav_BookTests.swift
//  Trav-BookTests
//
//  Created by Mohamed Mahmoud Zaki on 8/21/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import XCTest
import Cuckoo
@testable import Trav_Book

class Trav_BookTests: XCTestCase {

    var viewmodel: MockDashboardViewModel?
    override func setUp() {
        super.setUp()
        viewmodel = MockDashboardViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewmodel = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
//       let x = viewmodel?.add(x: 5, y: 4)
//        XCTAssertEqual(x, 9)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
