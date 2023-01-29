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

func xpc_crash(_ serviceName: String) {
    let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: serviceName.utf8.count)
    defer { buffer.deallocate() }
    strcpy(buffer, serviceName)
    xpc_crasher(buffer)
}
