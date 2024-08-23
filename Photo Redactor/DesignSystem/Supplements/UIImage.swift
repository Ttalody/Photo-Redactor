//
//  UIImage.swift
//  Photo Redactor
//
//  Created by Артур on 23.08.2024.
//

import UIKit

extension UIImage {
    func apply(transform: CGAffineTransform) -> UIImage? {
        let imageViewSize = CGSize(width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(imageViewSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: imageViewSize.width / 2, y: imageViewSize.height / 2)
        context.concatenate(transform)
        context.translateBy(x: -imageViewSize.width / 2, y: -imageViewSize.height / 2)
        
        draw(in: CGRect(origin: .zero, size: imageViewSize))
        let transformedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return transformedImage
    }
}
