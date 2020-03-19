//
//  extensions.swift
//  Rebels
//
//  Created by Samuel Brasileiro on 19/03/20.
//  Copyright © 2020 Samuel. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func jpegData(withCompressionQuality quality: CGFloat) -> Data? {
        return autoreleasepool(invoking: {() -> Data? in
            return self.jpegData(compressionQuality: quality)
        })
    }
}
