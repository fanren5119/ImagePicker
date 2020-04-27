//
//  WIIPhotoViewController.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit
import SnapKit
import Photos
import RxSwift
import RxCocoa

class WIIPhotoViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var collectionViewModel = WIIPhotoCollectionViewModel()
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindManager()
        loadData()
    }
    
    func setupUI() {
        setupNavigationItem()
        setupCollectionView()
    }
    
    func setupNavigationItem() {
        self.navigationItem.title = "图片"
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(respondsToBackItem))
        self.navigationItem.leftBarButtonItem = backItem
        
        let rightItem = UIBarButtonItem(title: "下一步", style: .plain, target: self, action: #selector(respondsToCommitItem))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let contentW = UIScreen.main.bounds.width - 6
        let width = Int(contentW) / 4
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        self.collectionViewModel.itemSize = CGFloat(width)
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView.dataSource = self.collectionViewModel
        self.collectionView.delegate = self.collectionViewModel
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.register(WIIPhotoCollectionCell.self, forCellWithReuseIdentifier: "WIIPhotoCollectionCell")
    }
    
    // MARK: - responds
    
    @objc func respondsToBackItem() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func respondsToCommitItem() {
        let array = WIISelectImageManager.shared.selectedAssets()
        var observerArray = [Observable<UIImage?>]()
        for asset in array {
            let observer = WIIImageManager.shared.downloadOrigin(asset: asset)
            observerArray.append(observer)
        }
        Observable.zip(observerArray).subscribe(onNext: { (images) in
            print(images)
        }).disposed(by: self.bag)
    }
    
    
    // MARK: - bindManager
    
    func bindManager() {
        let observer = WIISelectImageManager.shared.selectAsset.asObservable()
        observer.skip(1).subscribe(onNext: { [weak self] (_) in
            self?.reloadVisiableCells()
        }).disposed(by: self.bag)
    }
    
    
    // MARK: - loadData
    
    func loadData() {
        let option = PHFetchOptions()
        option.predicate = NSPredicate(format: "mediaType=%d", PHAssetMediaType.image.rawValue)
        
        let albumResults = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard albumResults.count > 0 else {
            return
        }
        let album = albumResults[0]
        let assetArray = PHAsset.fetchAssets(in: album, options: option)
        self.reloadDataSource(assets: assetArray)
    }
    
    // MARK: - reload
    
    func reloadDataSource(assets: PHFetchResult<PHAsset>) {
        self.collectionViewModel.reloadDataSource(assets: assets)
        self.collectionView.reloadData()
        
        let time = DispatchTime.now() + DispatchTimeInterval.nanoseconds(Int(0.005 * Double(NSEC_PER_SEC)))
        DispatchQueue.main.asyncAfter(deadline: time) {
            let row = self.collectionView.numberOfItems(inSection: 0)
            let indexPath = IndexPath(row: row - 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
    
    func reloadVisiableCells() {
        for cell in self.collectionView.visibleCells {
            (cell as? WIIPhotoCollectionCell)?.resetCountLabel()
        }
    }
}
