//
//  FaceAnchor.swift
//  FacialExpressions
//
//  Created by Arash Z.Jahangiri on 12/23/19.
//  Copyright © 2019 Arash. All rights reserved.
//

import Foundation
import ARKit

protocol FaceAnchorDelegate: class {
    func update(expression: String)
}

class FaceAnchor: NSObject {
    // MARK: -- Properties
    weak var delegate: FaceAnchorDelegate?
    private var expression: String!
    
    // MARK: -- Methods
    required init(anchor: ARAnchor) {
        fatalError("init(anchor:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {}
    
    func showSmileWith(value: CGFloat) {
        switch value {
        case 0.5..<1 :
            expression = "😁"
        case 0.2..<0.5 :
            expression = "🙂"
        default:
            expression = "😐"
        }
        
        delegate?.update(expression: expression)
    }
    
    func showFretWith(value: CGFloat) {
        switch value {
        case 0.7..<1 :
            expression = "😡"
        case 0.5..<0.7 :
            expression = "😠"
        default:
            break
        }
        
        delegate?.update(expression: expression)
    }
    
    func showLeftBlink(value:  CGFloat) {
        switch value {
        case 0.3..<1 :
            expression = "😉"
        default:
            expression = "😐"
        }
        
        delegate?.update(expression: expression)
    }
    
    func showRightBlink(value:  CGFloat) {
        switch value {
        case 0.3..<1 :
            expression = "😉"
        default:
            expression = "😐"
        }
        
        delegate?.update(expression: expression)
    }
    
    func analyze(faceAnchor: ARFaceAnchor) {
        let mouthSmileLeft = faceAnchor.blendShapes[.mouthSmileLeft] as? CGFloat ?? 0
        let mouthSmileRight = faceAnchor.blendShapes[.mouthSmileRight] as? CGFloat ?? 0
        let smile = (mouthSmileLeft + mouthSmileRight) / 2.0
        DispatchQueue.main.async {
            self.showSmileWith(value: smile)
        }
        
        let browDownLeft = faceAnchor.blendShapes[.browDownLeft] as? CGFloat ?? 0
        let browDownRight = faceAnchor.blendShapes[.browDownRight] as? CGFloat ?? 0
        let fret = (browDownLeft + browDownRight) / 2.0
        DispatchQueue.main.async {
            self.showFretWith(value: fret)
        }
        
        let eyeBlinkLeft = faceAnchor.blendShapes[.eyeBlinkLeft] as? CGFloat ?? 0
        if eyeBlinkLeft > 0.6 {
            DispatchQueue.main.async {
                self.showLeftBlink(value: eyeBlinkLeft)
            }
        }
        
        let eyeBlinkRight = faceAnchor.blendShapes[.eyeBlinkRight] as? CGFloat ?? 0
        if eyeBlinkRight > 0.6 {
            DispatchQueue.main.async {
                self.showRightBlink(value: eyeBlinkRight)
            }
        }
    }
}
