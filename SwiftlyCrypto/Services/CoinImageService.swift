//
//  CoinImageService.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 21/08/2025.
//

import Foundation
import SwiftUI

class CoinImageService: ObservableObject {
    @Published var image: UIImage? = nil
    
    private var imageName: String
    private var imageURL: String
    private let currentFolderName: String = "coins"
    private let fileManager = LocalFileManager.instance
    
    init(imageName: String, imageURL: String) {
        self.imageName = imageName
        self.imageURL = imageURL
        
        getImage()
        
    }
    
    private func getImage() {
        // 1. Check cache first
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: currentFolderName) {
            image = savedImage
            print("✅ Loaded image from cache: \(imageName)")
            return
        } else {
            downloadImage()
            print("⬇️ Downloading image: \(imageName)")
        }
        
        
    }
    
    private func downloadImage() {
        // 2. Download from network
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            if let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
                
                // Save in background
                DispatchQueue.global(qos: .background).async {
                    self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.currentFolderName)
                }
            }
        }.resume()
    }
}
