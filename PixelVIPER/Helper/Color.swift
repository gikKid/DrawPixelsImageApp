//
//  Color.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 22.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

enum Pencil {
  case black
  case grey
  case red
  case darkblue
  case lightBlue
  case green
  case purple
  case white
  case orange
  case yellow

  init?(tag: Int) {
    switch tag {
    case 0:
      self = .black
    case 1:
      self = .grey
    case 2:
      self = .orange
    case 3:
      self = .green
    case 4:
      self = .yellow
    case 5:
      self = .lightBlue
    case 6:
      self = .purple
    case 7:
      self = .red
    case 8:
      self = .darkblue
    case 9:
      self = .white
    default:
      return nil
    }
  }
  
  var color: UIColor {
    switch self {
    case .black:
      return .black
    case .grey:
      return UIColor(white: 105/255.0, alpha: 1.0)
    case .red:
      return UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
    case .darkblue:
      return UIColor(red: 0, green: 0, blue: 1, alpha: 1.0)
    case .lightBlue:
      return UIColor(red: 51/255.0, green: 204/255.0, blue: 1, alpha: 1.0)
    case .green:
      return UIColor(red: 0, green: 1, blue: 0, alpha: 1.0)
    case .purple:
        return UIColor(red: 138.0/255, green: 43.0/255, blue: 226.0/255, alpha: 1.0)
    case .white:
        return .white
    case .orange:
      return UIColor(red: 1, green: 102/255.0, blue: 0, alpha: 1.0)
    case .yellow:
      return UIColor(red: 1, green: 1, blue: 0, alpha: 1.0)
    }
  }

}

