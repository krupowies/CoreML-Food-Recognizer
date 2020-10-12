//
//  ViewController.swift
//  Projekt BIAI
//
//  Created by Wojtek Krupowies on 16/04/2020.
//  Copyright © 2020 Wojtek Krupowies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var galleryOrCamera = 0;
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func galleryButtonClick(_ sender: Any) {
        galleryOrCamera = 0
        performSegue(withIdentifier: "selectSourceSegue", sender: nil)
    }
    
    
    @IBAction func cameraButtonClick(_ sender: Any) {
        galleryOrCamera = 1
        performSegue(withIdentifier: "selectSourceSegue", sender: nil)
        //openCamera()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "selectSourceSegue"){
        let control = segue.destination as! SecondViewController
        control.sourceType = galleryOrCamera
        }
    }
}

