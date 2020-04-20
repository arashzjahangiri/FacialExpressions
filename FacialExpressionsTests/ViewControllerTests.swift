//
//  ViewControllerTests.swift
//  ViewControllerTests
//
//  Created by Arash Z.Jahangiri on 12/21/19.
//  Copyright © 2019 Arash. All rights reserved.
//

import XCTest
@testable import FacialExpressions

class ViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsSupported() {
        // Given
        let viewController = ViewController()
        
        // When
        viewController.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewController.isARTrackingSupported())
    }
    
}
