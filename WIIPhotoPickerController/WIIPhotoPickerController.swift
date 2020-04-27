//
//  WIIPhotoPickerController.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit

protocol WIIPhotoPickerControllerDelegate: NSObjectProtocol {
    
}

class WIIPhotoPickerController: UINavigationController {
    
    init() {
        let controller = WIIPhotoViewController()
        super.init(rootViewController: controller)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
