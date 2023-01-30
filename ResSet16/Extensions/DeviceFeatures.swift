//
//  Respring.swift
//  Appabetical
//
//  Created by exerhythm on 17.12.2022.
//

import SwiftUI

func xpc_crash(_ serviceName: String) {
    let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: serviceName.utf8.count)
    defer { buffer.deallocate() }
    strcpy(buffer, serviceName)
    xpc_crasher(buffer)
}

extension Color {
    static var lightGray:Color {
        return Color(UIColor.init(hue: 0, saturation: 0, brightness: 0.7, alpha: 0.2))
    }
}

extension Image {
    static var appIcon:Image {
        return Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
    }
}
