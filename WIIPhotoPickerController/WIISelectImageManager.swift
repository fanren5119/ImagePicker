//
//  WIISelectImageManager.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import RxCocoa

class WIISelectImageManager: NSObject {

    static let shared = WIISelectImageManager()
    
    var selectAsset = Variable<[String]>([])
    var assetDict = [String: PHAsset]()
    
    func didSelect(asset: PHAsset) {
        let identifer = asset.localIdentifier
        var selectAssetValue = self.selectAsset.value
        if self.isSelectAsset(asset: asset) {
            selectAssetValue.removeAll { (id) -> Bool in
                return id == identifer
            }
            self.assetDict[identifer] = nil
        } else {
            selectAssetValue.append(identifer)
            self.assetDict[identifer] = asset
        }
        self.selectAsset.value = selectAssetValue
    }
    
    func isSelectAsset(asset: PHAsset) -> Bool {
        return self.selectAsset.value.contains(asset.localIdentifier)
    }
    
    func selectIndexFor(asset: PHAsset) -> Int? {
        return self.selectAsset.value.firstIndex(of: asset.localIdentifier)
    }
    
    func selectedAssets() -> [PHAsset] {
        var assetArray = [PHAsset]()
        for identifier in self.selectAsset.value {
            if let asset = self.assetDict[identifier] {
                assetArray.append(asset)
            }
        }
        return assetArray
    }
}
