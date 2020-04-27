//
//  ViewController.swift
//  WIIPhotoPickerController
//
//  Created by freshera on 2020/4/26.
//  Copyright © 2020 wiseinfoiotDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        self.view.addSubview(button)
        
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(respondsToButton), for: .touchUpInside)
        
        let selectView = WIIPhoneSelectView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        selectView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        selectView.layer.shadowRadius = 3
        selectView.layer.shadowOpacity = 1
        selectView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.view.addSubview(selectView)
    }


    @objc func respondsToButton() {
        let controller = WIIPhotoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

