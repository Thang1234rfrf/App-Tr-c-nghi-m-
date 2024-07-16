//
//  testController.swift
//  AppTracNgiem
//
//  Created by thắng on 7/8/24.
//

import UIKit
import SwiftUI

final class testController {
    static var testController: UIViewController, U {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
            
        }
        guard let root = screen.windows.first?.testController else {
            return .init()
        }
      return root
    }
}
