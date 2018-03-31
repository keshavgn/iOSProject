//
//  iOSProjectTests.swift
//  iOSProjectTests
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import XCTest
@testable import iOSProject

class iOSProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testHomeViewModel() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.numberOfRows, 3)
        XCTAssertEqual(viewModel.segueId(at: 0),"FireBaseSegueId")
    }
    
}
