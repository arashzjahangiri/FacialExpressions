//
//  FaceAnchorTests.swift
//  FacialExpressionsTests
//
//  Created by Arash Z.Jahangiri on 4/20/20.
//  Copyright © 2020 Arash. All rights reserved.
//

import XCTest
import ARKit
@testable import FacialExpressions

class FaceAnchorTests: XCTestCase {

    class MockFaceAnchor: FaceAnchorDelegate {
        var updateExpressionWasCalled = false
        var analyzeWasCalled = false
        let face = FaceAnchor()
        
        init() {
            face.delegate = self
        }
        
        func update(expression: String) {
            updateExpressionWasCalled = true
        }
        
        func analyze(faceAnchor: ARFaceAnchor) {
            analyzeWasCalled = true
            face.analyze(faceAnchor: faceAnchor)
        }
        
        func showSmileWith(value: CGFloat) {
            face.showSmileWith(value: value)
        }
        
        func showFretWith(value: CGFloat) {
            face.showFretWith(value: value)
        }
        
        func showLeftBlink(value:  CGFloat) {
            face.showLeftBlink(value: value)
        }
        
        func showRightBlink(value:  CGFloat) {
            face.showRightBlink(value: value)
        }
        
        func showTongueOut(value:  CGFloat) {
            face.showTongueOut(value: value)
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
/*
    func testAnalyzeFace() {
        // Given
        let faceAnchor = MockFaceAnchor()
        let ar = ARAnchor(name: "testAR", transform: simd_float4x4.init())
        let face = ARFaceAnchor(anchor: ar)

        // When
        faceAnchor.analyze(faceAnchor: face)

        // Then
        XCTAssertTrue(faceAnchor.analyzeWasCalled)
    }
  */
    func testShowSmileWith80() {
        // Given
        let faceAnchor = MockFaceAnchor()

        // When
        faceAnchor.showSmileWith(value: 0.8)
        
        // Then
        XCTAssertTrue(faceAnchor.updateExpressionWasCalled)
    }
    
    func testShowSmile30() {
        // Given
        let faceAnchor = MockFaceAnchor()
        
        // When
        faceAnchor.showSmileWith(value: 0.3)
        
        // Then
        XCTAssertTrue(faceAnchor.updateExpressionWasCalled)
    }

    func testShowSmileWith0() {
        // Given
        let faceAnchor = MockFaceAnchor()
        
        // When
        faceAnchor.showSmileWith(value: 0.0)
        
        // Then
        XCTAssertTrue(faceAnchor.updateExpressionWasCalled)
    }
    
    func testShowFretWith80() {
        // Given
        let faceAnchor = MockFaceAnchor()
        
        // When
        faceAnchor.showFretWith(value: 0.8)
        
        // Then
        XCTAssertTrue(faceAnchor.updateExpressionWasCalled)
    }
    
    func testShowFretWith50() {
        // Given
        let faceAnchor = MockFaceAnchor()
        
        // When
        faceAnchor.showFretWith(value: 0.5)
        
        // Then
        XCTAssertTrue(faceAnchor.updateExpressionWasCalled)
    }
    
    func testShowFretWith0() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showFretWith(value: 0.0)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowLeftBlinkWith50() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showLeftBlink(value: 0.5)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowLeftBlinkWith20() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showLeftBlink(value: 0.2)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowRightBlinkWith50() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showRightBlink(value: 0.5)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowRightBlinkWith20() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showRightBlink(value: 0.2)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowTongueOutWith20() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showTongueOut(value: 0.2)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
    
    func testShowTongueOutWith0() {
        // Given
        let faceAnchorMock = MockFaceAnchor()
        
        // When
        faceAnchorMock.showTongueOut(value: 0.0)
        
        // Then
        XCTAssertTrue(faceAnchorMock.updateExpressionWasCalled)
    }
}
