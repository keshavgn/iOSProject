//
//  MachineLearningViewController.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import CoreML
import Vision

final class MachineLearningViewController: UIViewController {
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var camaraBarButtonItem: UIBarButtonItem!
    
    private struct Constant {
        static let vowels: [Character] = ["a", "e", "i", "o", "u"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = camaraBarButtonItem
    }
    
    @IBAction func openCameraOrPhotosApp(_ sender: Any) {
        let actionSheetViewController = UIAlertController()
        let cameraButton = UIAlertAction(title: Localized.cameraButtonTitle, style: .default, handler: { [weak self] _ in
            if let weakSelf = self {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = .camera
                    imagePickerController.allowsEditing = false
                    weakSelf.present(imagePickerController, animated: true, completion: nil)
                }
            }
        })
        actionSheetViewController.addAction(cameraButton)
        let galleryButton = UIAlertAction(title: Localized.galleryButtonTitle, style: .default, handler: { [weak self] _ in
            if let weakSelf = self {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.allowsEditing = false
                    weakSelf.present(imagePickerController, animated: true, completion: nil)
                }
            }
        })
        actionSheetViewController.addAction(galleryButton)
        let cancelButton = UIAlertAction(title: Localized.cancelButtonTitle, style: .cancel, handler: { [weak self] _ in
            if let weakSelf = self {
                weakSelf.dismiss(animated: true, completion: nil)
            }
        })
        actionSheetViewController.addAction(cancelButton)
        present(actionSheetViewController, animated: true, completion: nil)
    }
    
}

extension MachineLearningViewController {
    
    func detectScene(image: CIImage) {
        answerLabel.text = Localized.answerLabelDefault
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else { return }
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else { return }
            
            let article = Constant.vowels.contains(topResult.identifier.first!) ? "an" : "a"
            DispatchQueue.main.async { [weak self] in
                self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}

extension MachineLearningViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        scene.image = image
        guard let ciImage = CIImage(image: image) else { return }
        detectScene(image: ciImage)
    }
}

