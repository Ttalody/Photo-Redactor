//
//  HomeViewModel.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit
import Photos

final class HomeViewModel: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Properties
    var didUpdateImage: (() -> Void)?
    
    private var pickerController: UIImagePickerController?
    
    private var model: HomeModel {
        didSet {
            self.didUpdateImage?()
        }
    }

    // MARK: - Init
    init(model: HomeModel) {
        self.model = model
    }
    
    // MARK: - Public methods
    func requestPhotoLibraryAccess(from viewController: UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        self.openPhotoLibrary(from: viewController)
                    }
                } else {
                    // Обработка случая, когда доступ не предоставлен
                }
            }
        } else if status == .authorized {
            openPhotoLibrary(from: viewController)
        } else {
            // Обработка случая, когда доступ не предоставлен
        }
    }
    
    func getImage() -> UIImage {
        guard let image = model.image else {
            return .init()
        }
        return image
    }
    
    // MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.originalImage] as? UIImage {
            self.model.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    private func openPhotoLibrary(from viewController: UIViewController) {
        pickerController = UIImagePickerController()
        pickerController?.delegate = self
        pickerController?.sourceType = .photoLibrary
        pickerController?.allowsEditing = false
        viewController.present(pickerController!, animated: true, completion: nil)
    }
}
