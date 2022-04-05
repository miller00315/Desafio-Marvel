//
//  KFImageLoader.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 05/04/22.
//

import Foundation
import Kingfisher

class KFImageLoader {
    public func load(imageURL: String, placeholder: UIImage, imageView: UIImageView) {
        guard let imageURL = URL(string: imageURL) else { return }
        let resource = ImageResource(downloadURL: imageURL)
        let processor = RoundCornerImageProcessor(cornerRadius: 10)
        
        imageView.kf.setImage(with: resource, placeholder: placeholder, options: [.processor(processor)], progressBlock: { (receivedSize, totalSize) in
            let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
            print("Downloading progress: \(percentage)%")
        })
    }
}
