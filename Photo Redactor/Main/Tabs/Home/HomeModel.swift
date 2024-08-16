//
//  HomeModel.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit
import CoreImage

class HomeModel {
    private let context = CIContext()

    func applyFilter(to image: UIImage, filterName: String) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgOutputImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgOutputImage)
    }
}
