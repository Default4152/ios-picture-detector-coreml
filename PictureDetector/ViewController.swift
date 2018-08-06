//
//  ViewController.swift
//  PictureDetector
//
//  Created by Conner on 8/6/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    var resnet50Model = Resnet50()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let image = imageView.image {
            whatIsThis(image: image)
        }
    }
    
    func whatIsThis(image: UIImage) {
        if let model = try? VNCoreMLModel(for: resnet50Model.model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    print(results)
                }
            }
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello"
        return cell
    }
}

