//
//  ClassificationService.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import CoreML
import Vision

protocol ClassificationServiceDelegate: class {
    func classificationService(_ service: ClassificationService, didDetectSentiment sentiment: String)
}

/// Service used to perform gender, age and emotion classification
final class ClassificationService {
    /// The service's delegate
    weak var delegate: ClassificationServiceDelegate?
    /// Array of vision requests
    private var requests = [VNRequest]()
    
    /// Create CoreML model and classification requests
    func setup() {

    }
    
    /// Run individual requests one by one.
    func classify(image: CIImage) {
        do {
            for request in self.requests {
                let handler = VNImageRequestHandler(ciImage: image)
                try handler.perform([request])
            }
        } catch {
            print(error)
        }
    }

}
