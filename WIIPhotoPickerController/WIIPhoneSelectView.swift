//
//  WIIPhoneSelectView.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit

class WIIPhoneSelectView: UIView {
    
    var circleLayer: CALayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCircleLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCircleLayer() {
        self.circleLayer = CALayer()
        self.circleLayer.frame = self.bounds
        let radius = self.frame.height / 2
        self.circleLayer.cornerRadius = radius
        self.circleLayer.masksToBounds = true
        
        self.circleLayer.borderWidth = 2
        self.circleLayer.borderColor = UIColor.white.cgColor

        self.circleLayer.shadowOffset = CGSize(width: 12, height: -12)
        self.circleLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.circleLayer.shadowRadius = 6
        self.circleLayer.shadowOpacity = 1
        self.layer.addSublayer(self.circleLayer)
    }

}
