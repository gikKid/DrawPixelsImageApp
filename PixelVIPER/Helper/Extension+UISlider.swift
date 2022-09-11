//
//  Extension+UISlider.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 24.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

extension UISlider {
var thumbCenterX: CGFloat {
    let trackRect = self.trackRect(forBounds: frame)
    let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
    return thumbRect.midX
 }
var thumbCenterY: CGFloat {
    let trackRect = self.trackRect(forBounds: frame)
    let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
    return thumbRect.midY
 }
}
