//
//  WIIImageManager.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import RxCocoa

class WIIImageManager: NSObject {
    
    static let shared = WIIImageManager()
    
    func download(asset: PHAsset, size: CGFloat, complete: @escaping ((UIImage?) -> Void)) -> PHImageRequestID {
        let option = PHImageRequestOptions()
        option.resizeMode = .fast
        let targetSize = CGSize(width: size, height: size)
        let requestId = PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: option) { (image, info) in
            if let image = image {
                complete(image)
                return
            }
            let isCloud = info?[PHImageResultIsInCloudKey] as? Bool
            if isCloud ?? false {
                self.downloadCloud(asset: asset, size: size, complete: complete)
            }
        }
        return requestId
    }
    
    func downloadCloud(asset: PHAsset, size: CGFloat, complete: @escaping ((UIImage?) -> Void)) {
        let option = PHImageRequestOptions()
        option.resizeMode = .fast
        option.isNetworkAccessAllowed = true
        let targetSize = CGSize(width: size, height: size)
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: option) { (image, _) in
            if let image = image {
                complete(image)
                return
            }
        }
    }
    
    func cancelDownload(requestId: PHImageRequestID) {
        PHImageManager.default().cancelImageRequest(requestId)
    }
    
}


extension WIIImageManager {
    func downloadOrigin(asset: PHAsset) -> Observable<UIImage?> {
        return Observable.create { (observer) -> Disposable in
            let option = PHImageRequestOptions()
            option.resizeMode = .fast
            option.isNetworkAccessAllowed = true
            PHImageManager.default().requestImageData(for: asset, options: nil) { (data, _, _, _) in
                if let data = data {
                    let image = UIImage(data: data)
                    observer.onNext(image)
                } else {
                    observer.onNext(nil)
                }
            }
            return Disposables.create()
        }
    }
}
