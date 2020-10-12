//
//  SecondViewController.swift
//  Projekt BIAI
//
//  Created by Wojtek Krupowies on 16/04/2020.
//  Copyright © 2020 Wojtek Krupowies. All rights reserved.
//

import UIKit
import CoreML
import Vision

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    var sourceType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        chooseImage()
    }
    
    func recognizeObject (image: CIImage) {
        
        guard let myModel = try? VNCoreMLModel(for: NewBigger_1().model) else {
            fatalError("Couldn't load ML Model")
        }
        
        let recognizeRequest = VNCoreMLRequest(model: myModel) { (recognizeRequest, error) in
            guard let output = recognizeRequest.results as? [VNClassificationObservation] else {
                fatalError("Your model failed !")
            }
            print(output)
            let resultText = output.first?.identifier
            self.resultLabel.text = resultText
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
        try handler.perform([recognizeRequest])
        } catch {
            print(error)
        }
    }
    
    func chooseImage(){
        
        print(sourceType)
        
        if(sourceType == 0) {
           openGallery()
            print("Image from gallery")
        }
        
        if(sourceType == 1){
           openCamera()
            print("Image from camera")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            
            imageView.image = pickedImage
            guard let imageToRecognize = CIImage(image: pickedImage) else {
                fatalError("Couldn't convert image to type CIImage")
            }
            recognizeObject(image: imageToRecognize)
            
        }
      
        picker.dismiss(animated: true, completion: nil)
    }
    
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
              imagePicker.delegate = self
              imagePicker.sourceType = UIImagePickerController.SourceType.camera
              imagePicker.allowsEditing = false
              self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("camera not avalaible")
        }
    }
    
    func openGallery(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)

    }
    
}
