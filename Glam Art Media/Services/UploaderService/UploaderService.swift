//
//  UploaderService.swift
//  Glam Art Media
//
//  Created by Amza Andrei on 8/4/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import Zip

class UploaderService: NSObject {
    
    static let sharedInstance = UploaderService()
    
    func createTempDirectory() -> URL? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dir = documentDirectory.appendingPathComponent("temp-dir-\(UUID().uuidString)")
            do {
                try FileManager.default.createDirectory(atPath: dir.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
            return dir
        } else {
            return nil
        }
    }
    
    func saveImages(data: [Data]) -> URL? {
        guard let directory = createTempDirectory() else { return nil }

        do {
            for (i, imageData) in data.enumerated() {
                try imageData.write(to: directory.appendingPathComponent("image\(i).jpg"))
            }
            return directory
        } catch {
            return nil
        }
    }
    
    func zipImages(data: [Data], completion: @escaping ((URL?) -> ())) {
        DispatchQueue.main.async {
            guard let directory = self.saveImages(data: data) else {
                completion(nil)
                return
            }

            do {
                let zipFilePath = try Zip.quickZipFiles([directory], fileName: "archive-\(UUID().uuidString)")
                completion(zipFilePath)
            } catch {
                completion(nil)
            }
        }
    }
    
}
