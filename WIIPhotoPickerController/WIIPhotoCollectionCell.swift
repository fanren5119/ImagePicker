//
//  WIIPhotoCollectionCell.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit
import Photos

class WIIPhotoCollectionCell: UICollectionViewCell {
    
    var contentImageView: UIImageView!
    var selectView: UIView!
    var countLabel: UILabel!
    var selectButton: UIButton!
    var requestId: PHImageRequestID?
    var asset: PHAsset?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        setupContentImageView()
        setupSelectView()
        setupCountLabel()
        setupSelectButton()
    }
    
    func setupContentImageView() {
        self.contentImageView = UIImageView()
        self.contentImageView.contentMode = .scaleAspectFill
        self.contentImageView.clipsToBounds = true
        self.contentView.addSubview(self.contentImageView)
        
        self.contentImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupSelectView() {
        self.selectView = UIView()
        self.selectView.layer.cornerRadius = 6
        self.selectView.layer.masksToBounds = true
        self.selectView.layer.borderWidth = 1
        self.selectView.layer.borderColor = UIColor.white.cgColor
        self.selectView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.selectView.layer.shadowOpacity = 1
        self.selectView.layer.shadowOffset = CGSize(width: 0.5, height: -0.5)
        self.contentView.addSubview(self.selectView)
        self.selectView.layer.shouldRasterize = true
        self.selectView.layer.rasterizationScale = UIScreen.main.scale
        
        self.selectView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 12, height: 12))
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
        }
    }
    
    func setupCountLabel() {
        self.countLabel = UILabel()
        self.countLabel.backgroundColor = UIColor(red: 223 / 255.0, green: 223 / 255.0, blue: 223 / 255.0, alpha: 1.0)
        self.countLabel.layer.cornerRadius = 6
        self.countLabel.layer.masksToBounds = true
        self.contentView.addSubview(self.countLabel)
        
        self.countLabel.font = UIFont.systemFont(ofSize: 9.0)
        self.countLabel.textColor = UIColor(red: 0.0, green: 136 / 255.0, blue: 194 / 255.0, alpha: 1.0)
        self.countLabel.textAlignment = .center
        
        self.countLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.selectView)
        }
    }
    
    func setupSelectButton() {
        self.selectButton = UIButton(type: .custom)
        self.selectButton.addTarget(self, action: #selector(respondsToSelectButton), for: .touchUpInside)
        self.contentView.addSubview(self.selectButton)
        
        self.selectButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    @objc func respondsToSelectButton() {
        guard let asset = self.asset else {
            return
        }
        WIISelectImageManager.shared.didSelect(asset: asset)
    }
    
    func resetCell(asset: PHAsset, size: CGFloat) {
        self.asset = asset
        self.resetCountLabel()
        self.resetImageView(asset: asset, size: size)
    }
    
    func resetCountLabel() {
        guard let asset = self.asset else {
            self.countLabel.isHidden = true
            return
        }
        guard let index = WIISelectImageManager.shared.selectIndexFor(asset: asset) else {
            self.countLabel.isHidden = true
            return
        }
        self.countLabel.isHidden = false
        self.countLabel.text = "\(index + 1)"
    }
    
    func resetImageView(asset: PHAsset, size: CGFloat) {
        self.requestId = WIIImageManager.shared.download(asset: asset, size: size) { (image) in
            self.contentImageView.image = image
        }
    }
    
    func cancelCell() {
        if let requestId = self.requestId {
            WIIImageManager.shared.cancelDownload(requestId: requestId)
        }
    }
}
