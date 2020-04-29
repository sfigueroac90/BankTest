//
//  UIImageViewExtension.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 29/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    print ("Got Image")
                    DispatchQueue.main.async {
                        print("Image loaded")
                        self?.image = image
                    }
                }
            }
        }
    }
}
