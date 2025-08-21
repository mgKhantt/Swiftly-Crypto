//
//  LocalFileManager.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 21/08/2025.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        //create folder
        createFolderIfNeeded(folderName: folderName)
        
        //get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, foldernName: folderName)
        else { return }
        
        //save image to path
        do {
            try data.write(to: url)
            print("✅ Image saved at path: \(url.path)")
        } catch let error {
            print("Error saving image. 🌌Image name: \(imageName). 🔥Error: \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, foldernName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil}
        
        return UIImage(contentsOfFile: url.path)
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. 📁Folder name: \(folderName). 🔥Error:\(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil}
        
        return url.appendingPathComponent(folderName)
        
    }
    
    private func getURLForImage(imageName: String, foldernName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: foldernName) else { return nil }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}

