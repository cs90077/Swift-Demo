//
//  OpenCameraViewController.swift
//  Camera-Demo
//
//  Created by TonyLin on 2020/9/5.
//  Copyright © 2020 TonyLin. All rights reserved.
//

import UIKit

class OpenCameraViewController: UIViewController {

    @IBOutlet weak var previewImageView:UIImageView!

    @IBOutlet var saveImageButton: UIButton!

    var mainImage:UIImage = UIImage.init(named: "addPhotoNormal")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openCameraPressed(sender:UIButton) {
        openCamera()
    }

}

extension OpenCameraViewController {

    func openCamera() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera
        self.present(pickerController, animated: true, completion: nil)
    }

}

// MARK: Camera

extension OpenCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let originalImage = info[.originalImage] as? UIImage else { return }

        picker.dismiss(animated: true) {
            DispatchQueue.main.async() {
                // save
                self.mainImage = originalImage
                self.previewImageView.image = originalImage
            }
        }
    }

}
