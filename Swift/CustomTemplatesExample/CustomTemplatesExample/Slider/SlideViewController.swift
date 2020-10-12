//
//  SlideViewController.swift
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 6.10.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

import UIKit
import Leanplum

class SlideViewController: UIViewController {
    var imageName:String?
    var titleText:String?
    var titleColor:UIColor?
    var pageIndex:Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        if let text = titleText {
            self.titleLabel.text = text
        }
        
        if let color = titleColor {
            self.titleLabel.textColor = color
        }
        
        if let fileName = imageName {
            // try to download the image
            // if the image is already downloaded it will not trigger the onComplete callback
            let willDownload = LPFileManager.maybeDownloadFile(fileName, defaultValue: "", onComplete: {
                self.setImage(img: self.getImageFile(fileName))
            })
            
            if !willDownload {
                setImage(img: getImageFile(fileName))
            }
        }
    }
    
    func setImage(img:UIImage?) {
        if let image = img {
            self.imageView.image = image
        }
    }
    
    func getImageFile(_ fileName: String) -> UIImage? {
        let fl = LPFileManager.fileValue(fileName, withDefaultValue: fileName)
        if let file = fl {
            let img = UIImage.init(contentsOfFile: file)
            return img
        }
        return nil
    }
}
