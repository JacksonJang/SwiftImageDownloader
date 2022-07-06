//
//  ViewController.swift
//  SwiftImageDownloader
//
//  Created by 장효원 on 2022/07/06.
//

import UIKit
import Photos

class ViewController: UIViewController {
    let imageUrlString = "https://images.unsplash.com/photo-1657088746570-0218626e8f55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: imageUrlString) {
            downloadImage(url: url)
        }
    }
    
    private func downloadImage(url:URL) {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "image/jpeg"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
                return
            }
            guard let image = UIImage(data: data!) else {
                print("No image")
                return
            }
            
            // Success
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            },completionHandler: {_,_ in 
                print("completed")
            })
        }
        task.resume()
    }


}

