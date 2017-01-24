//
//  dontCutMe.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/20/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

// Purpose:
// Prevent UILabel from cutting off the right-side of right-indented italic characters
class DontCutMe: UILabel {
    override func drawText(in rect: CGRect) {
        let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
}
