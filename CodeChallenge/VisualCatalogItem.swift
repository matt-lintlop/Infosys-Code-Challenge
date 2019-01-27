//
//  VisualCatalogItem.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import UIKit

// Catalog Object
class VisualCatalogItem: Pizza  {
    let imageReference:ImageReference?
    var image:UIImage?
    
    private enum DictionaryKeys:String {
        case objectImage = "image"
    }
    override init?(pizzaIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        guard let imageRefrenceDict = objectDict[DictionaryKeys.objectImage.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let imageReference =  ImageReference(withDictionary:imageRefrenceDict) else {
            return nil
        }
        self.imageReference = imageReference
        super.init(pizzaIdentifier:pizzaIdentifier, objectDict:objectDict)
        self.downloadedImage()
    }
   
    func downloadedImage() {
        enum DownloadError:Error {
            case errorDownloadingFile
        }
        guard let imageUrlPath = self.imageReference?.imageUrlPath,
            let url = URL(string: imageUrlPath) else {
            self.delegate?.pizza(self, didLoadImageImage:nil, withError:DownloadError.errorDownloadingFile)
            return
        }
        URLSession.shared.dataTask(with:url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data:data)
                else {
                    self.delegate?.pizza(self, didLoadImageImage:nil, withError:DownloadError.errorDownloadingFile)
                    return
            }
            self.image = image
            self.delegate?.pizza(self, didLoadImageImage:image, withError:nil)
            }.resume()
    }
 }
