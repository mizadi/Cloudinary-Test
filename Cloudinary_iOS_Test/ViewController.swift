//
//  ViewController.swift
//  Cloudinary_iOS_Test
//
//  Created by Adi Mizrahi on 16/11/2021.
//

import UIKit
import Cloudinary
class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originalImageView: UIImageView!
    var cloudinary: CLDCloudinary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "test") else {
            return
        }
        originalImageView.frame = CGRect(x: originalImageView.bounds.origin.x, y: originalImageView.bounds.origin.y, width: 240, height: 240 * image.size.width / image.size.height)
        originalImageView.image = image
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCloudinary()
            //uploadImageToCloudinary()
        generateURL()
    }
    
    func initCloudinary() {
        let config = CLDConfiguration(cloudName: "db0edm7to")
        cloudinary = CLDCloudinary(configuration: config)
        CLDCloudinary.logLevel = CLDLogLevel.debug
    }
    
    func generateURL() {
        let transformation = CLDTransformation().setCrop(.fit).setRadius(50)
        guard let url = cloudinary.createUrl().setTransformation(transformation).generate("corgi.png") else {
            return
        }
        downloadImage(url)
    }
    
    func downloadImage(_ url: String) {
        cloudinary.createDownloader().fetchImage(url, nil, completionHandler: {  image, error in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }
    
    func uploadImageToCloudinary() {
        
        let params: CLDUploadRequestParams = CLDUploadRequestParams().setUploadPreset("boj7jh4o").setPublicId("newImage14").setFolder("").setResourceType(.image) as! CLDUploadRequestParams
        guard let data = UIImage(named: "test")?.pngData() else {
            return
        }
        let request = cloudinary.createUploader().upload(data: data, uploadPreset: "boj7jh4o") { response, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                print("hello")
            }
        }
    }
    
}

