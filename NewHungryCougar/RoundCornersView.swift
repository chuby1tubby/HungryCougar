//
//  roundCornersView.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/1/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.customInit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.customInit();
    }
    
    func customInit() {
        self.layer.cornerRadius = 10;
    }
}
