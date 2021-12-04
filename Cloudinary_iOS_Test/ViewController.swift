//
//  ViewController.swift
//  Cloudinary_iOS_Test
//
//  Created by Adi Mizrahi on 16/11/2021.
//

import UIKit
import Cloudinary
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uploadImageToCloudinary()
    }
    
    func uploadImageToCloudinary() {
        let config = CLDConfiguration(cloudName: "db0edm7to", secure: true)
        let cloudinary = CLDCloudinary(configuration: config)
        
        
        let params: CLDUploadRequestParams = CLDUploadRequestParams().setUploadPreset("sample").setPublicId("newImage14").setFolder("").setResourceType(.image) as! CLDUploadRequestParams
        guard let data = UIImage(named: "test")?.pngData() else {
            return
        }
        let request = cloudinary.createUploader().signedUpload(data: data) { response, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                print("hello")
            }
        }
    }
    
}

