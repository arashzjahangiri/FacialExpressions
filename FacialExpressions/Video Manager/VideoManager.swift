//
//  VideoManager.swift
//  FacialExpressions
//
//  Created by Arash Z.Jahangiri on 12/21/19.
//  Copyright © 2019 Arash. All rights reserved.
//

import AVKit

// MARK: - Protocol
protocol VideoManagerProtocol: class {
    func didReceive(sampleBuffer: CMSampleBuffer)
}

final class VideoManager: NSObject {
    
    // MARK: -- Properties
    
    /// RequestPermissionCompletionHandler
    typealias RequestPermissionCompletionHandler = ((_ accessGranted: Bool) -> Void)
    
    /// delegate of VideoManager
    weak var delegate: VideoManagerProtocol?
    
    /// An object that manages capture activity.
    let captureSession = AVCaptureSession()
    
    /// A device that provides input (such as audio or video) for capture sessions.
    let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    
    /// A Core Animation layer that displays the video as it’s captured.
    lazy var videoLayer: AVCaptureVideoPreviewLayer = {
        return AVCaptureVideoPreviewLayer(session: captureSession)
    }()
    
    /// A capture output that records video and provides access to video frames for processing.
    lazy var videoOutput: AVCaptureVideoDataOutput = {
        let output = AVCaptureVideoDataOutput()
        let queue = DispatchQueue(label: "VideoOutput", attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit)
        output.setSampleBufferDelegate(self, queue: queue)
        output.alwaysDiscardsLateVideoFrames = true
        return output
    }()
    
    // MARK: -- Methods
    override init() {
        guard let videoDevice = videoDevice, let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            fatalError("No `Video Device` detected!")
        }
        
        super.init()
        
        captureSession.addInput(videoInput)
        captureSession.addOutput(videoOutput)
    }
    
    func startVideoCapturing() {
        captureSession.startRunning()
    }
    
    func stopVideoCapturing() {
        captureSession.stopRunning()
    }
    
    func requestPermission(completion: @escaping RequestPermissionCompletionHandler) {
        AVCaptureDevice.requestAccess(for: .video) { (accessGranted) in
            completion(accessGranted)
        }
    }
}

extension VideoManager {
    
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension VideoManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.didReceive(sampleBuffer: sampleBuffer)
    }
}
