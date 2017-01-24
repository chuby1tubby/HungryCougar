//
//  Day.swift
//  Open Den
//
//  Created by Kyle Nakamura on 7/31/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import Foundation

class Day {
    // Base variables
    fileprivate var _openTime: Int = 0
    fileprivate var _closeTime: Int = 0
    fileprivate var _hasNoHours: Bool = false
    
    // Getters
    var openTime: Int {
        get {
            return _openTime
        }
        set(value) {
            _openTime = value
        }
    }
    var closeTime: Int {
        get {
            return _closeTime
        }
        set(value) {
            _closeTime = value
        }
    }
    var hasNoHours: Bool {
        get {
            return _hasNoHours
        }
        set(value) {
            _hasNoHours = value
        }
    }
    
    // Initializer
    init(openTime: Int, closeTime: Int, hasNoHours: Bool) {
        self._openTime = openTime
        self._closeTime = closeTime
        self._hasNoHours = hasNoHours
    }
}
