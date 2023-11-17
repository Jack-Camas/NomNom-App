//
//  CameraController.swift
//  Camera
//
//  Created by Life on 3/13/23.
//

import AVFoundation

class CameraController: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let session = AVCaptureSession()
    private let output = AVCaptureVideoDataOutput()
    
    override init(){
        super.init()
        
        guard let device = AVCaptureDevice.default(for: .video) else {
            fatalError("No video device found")
            
        }
        
        let input = try! AVCaptureDeviceInput(device: device)
        
        if session.canAddInput(input){
            session.addInput(input)
        }
        
        let queue = DispatchQueue(label: "com.app.captureQueue")
        output.setSampleBufferDelegate(self, queue: queue)
        
        session.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //Process the captured frame and extract text using OCR
    }
}



