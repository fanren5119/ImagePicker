//
//  WIIPhotoCollectionViewModel.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit
import Photos

class WIIPhotoCollectionViewModel: NSObject & UICollectionViewDataSource & UICollectionViewDelegate {

    var assetArray: PHFetchResult<PHAsset>?
    var itemSize: CGFloat = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WIIPhotoCollectionCell", for: indexPath) as! WIIPhotoCollectionCell
        let asset = self.assetArray![indexPath.row]
        cell.resetCell(asset: asset, size: self.itemSize)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? WIIPhotoCollectionCell)?.cancelCell()
    }
    
    
    func reloadDataSource(assets: PHFetchResult<PHAsset>) {
        self.assetArray = assets
    }
}
