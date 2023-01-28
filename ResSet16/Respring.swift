//
//  Respring.swift
//  Appabetical
//
//  Created by exerhythm on 17.12.2022.
//

import UIKit

extension UIDevice {
    func respring() {
#if targetEnvironment(simulator)
#else
        guard let window = UIApplication.shared.windows.first else { return }
        while true {
            window.snapshotView(afterScreenUpdates: false)
        }
#endif
    }
}
