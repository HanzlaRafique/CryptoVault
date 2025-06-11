//
//  LocalFileManager.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/13/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {return}
        
        do {
            try data.write(to: url)
            
        } catch let error {
            print("Error while write file: Image Name \(imageName).. \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard 
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {return nil}
        
        return UIImage(contentsOfFile: url.path)
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        
        guard let folderUrl = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)
                
            } catch let error {
                print("Error while creating folder: Folder Name \(folderName).. \(error)")
            }
        }
    }
    
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(folderName)
    }
     
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        
        guard let folderName = getURLForFolder(folderName: folderName) else {return nil}
        
        return folderName.appendingPathComponent(imageName + ".png")
    }
    
    
}
