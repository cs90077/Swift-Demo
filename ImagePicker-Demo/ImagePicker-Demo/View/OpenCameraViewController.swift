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

    @IBAction func saveImagePressed(sender:UIButton) {
        saveImageToPhotos()
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

    func saveImageToPhotos() {
        // save
        UIImageWriteToSavedPhotosAlbum(mainImage, imageSaveSuccess(), nil, nil)
    }

    @objc func imageSaveSuccess() {
        let alert = UIAlertController(title: "相片儲存", message: "成功", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
