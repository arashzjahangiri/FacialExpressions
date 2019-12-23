//
//  ViewController.swift
//  FacialExpressions
//
//  Created by Arash Z.Jahangiri on 12/21/19.
//  Copyright © 2019 Arash. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    // MARK: -- Properties
    
    /// sceneview
    var sceneView = ARSCNView()
    
    var facialLabel: UILabel!
    
    /// Is responsible to start the flow of data from the inputs to the outputs connected to the AVCaptureSession.
    /// In simple words it returns video layer. Then we add this to the `self.view`.
    lazy var videoManager: VideoManager = {
        return VideoManager()
    }()
    
    lazy var face: FaceAnchor = {
        return FaceAnchor()
    }()
    
    // MARK: -- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        if isARTrackingSupported() {
            requestPermission()
        } else {
            fatalError("ARKit is not supported on this device")
        }
    }
    
    func requestPermission() {
        videoManager.requestPermission { [weak self] (granted) in
            if granted {
                DispatchQueue.main.async {
                    self?.setupARFaceTracking()
                    self?.setupVideoAndDetectFaceExpressions()
                    self?.makeFacialLabel()
                }
            } else {
                fatalError("Facial Expressions can't be work because it needs camera.")
            }
        }
    }
    
    func setupARFaceTracking() {
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.frame = view.frame
        sceneView.session.run(configuration)
        sceneView.delegate = self
        face.delegate = self
        self.view.addSubview(self.sceneView)
    }
    
    func setupVideoAndDetectFaceExpressions() {
        videoManager.startVideoCapturing()
        addCameraToView()
    }
    
    func addCameraToView() {
        let videoLayer = videoManager.videoLayer
        videoLayer.frame = self.view.frame
        videoLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(videoLayer)
    }
    
    func makeFacialLabel() {
        facialLabel = UILabel()
        facialLabel.text = "😐"
        facialLabel.font = UIFont.systemFont(ofSize: 150)
        view.addSubview(facialLabel)
        
        // Set constraints.
        facialLabel.translatesAutoresizingMaskIntoConstraints = false
        facialLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facialLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func isARTrackingSupported() -> Bool {
        guard ARFaceTrackingConfiguration.isSupported else {
            return false
        }
        
        return true
    }
}

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        face.analyze(faceAnchor: faceAnchor)
    }
}

extension ViewController: FaceAnchorDelegate {
    
    func update(expression: String) {
        facialLabel.text = expression
    }
}
