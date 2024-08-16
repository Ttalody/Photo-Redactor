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
    var filteredImage: ((UIImage?) -> Void)?
    
    private var model: HomeModel
    private var pickerController: UIImagePickerController?
    
    private var originalImage: UIImage? {
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
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                self.openPhotoLibrary(from: viewController)
            }
        default:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        self.openPhotoLibrary(from: viewController)
                    }
                }
            }
        }
    }
    
    func getImage() -> UIImage {
        guard let image = originalImage else {
            return .init()
        }
        return image
    }
    
    func applyFilter(option: Int) {
        guard let originalImage else {
            return
        }
        switch option {
        case 0:
            filteredImage?(originalImage)
        case 1:
            let filteredImage = model.applyFilter(to: originalImage, filterName: "CIPhotoEffectMono")
            self.filteredImage?(filteredImage)
        default:
            break
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.originalImage] as? UIImage {
            self.originalImage = selectedImage
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
