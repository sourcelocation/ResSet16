//
//  ContentView.swift
//  ResSet16
//
//  Created by sourcelocation on 28/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State var width: Double = UIScreen.main.nativeBounds.width
    @State var height: Double = UIScreen.main.nativeBounds.height
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("Icon")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(16)
                Spacer()
            }
            Text("ResSet16").fontWeight(.bold).font(.system(size: 25))
            Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")").fontWeight(.light).font(.system(size: 18))
            Text("sourcelocation").fontWeight(.light).font(.system(size: 18))
                .padding(.bottom)
            TextField("Height", value: $height, format: .number.grouping(.never))
                .keyboardType(.decimalPad)
                .padding()
                .multilineTextAlignment(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(Color.lightGray, lineWidth: 1)
                )
            TextField("Width", value: $width, format: .number.grouping(.never))
                .keyboardType(.decimalPad)
                .padding()
                .multilineTextAlignment(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(Color.lightGray, lineWidth: 1)
                )
            Button(action: {
                setResolution()
            }) {
                HStack {
                    Spacer()
                    Text("Set Resolution")
                    Spacer()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(999)
            }
            HStack {
                Button(action: {
                    UIApplication.shared.alert(title: "ResSet16", body: "Supports: iOS 15.0-16.1.2. \n100% safe.\nForce reboot to revert changes\n\n Inspired by ResolutionSetterSwift for TrollStore\n\nCredits:\n I copy-pasted a lot of code, so I'll just thank all of you: lemin, Avangelista, haxi0, opa334, Ian Beer, zhuowei.")
                }) {
                    HStack {
                        Spacer()
                        Text("About")
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .background(Color.clear)
                }
                Button(action: {
                    openURL(URL(string: "https://discord.gg/VyVcNjRMeg")!)
                }) {
                    HStack {
                        Spacer()
                        Text("Discord")
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .background(Color.clear)
                }
            }
        }
        .padding()
        .frame(maxWidth: 350)
    }
    
    func setResolution() {
        do {
            let tmpPlistURL = URL(fileURLWithPath: "/var/tmp/com.apple.iokit.IOMobileGraphicsFamily.plist")
            try? FileManager.default.removeItem(at: tmpPlistURL)
            
            try createPlist(at: tmpPlistURL)
            
            let aliasURL = URL(fileURLWithPath: "/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist")
            try? FileManager.default.removeItem(at: aliasURL)
            try FileManager.default.createSymbolicLink(at: aliasURL, withDestinationURL: tmpPlistURL)
            
            xpcRestart()
        } catch {
            UIApplication.shared.alert(body: error.localizedDescription)
        }
    }
    
    func xpcRestart() {
        let processes = [
            "com.apple.cfprefsd.daemon",
            "com.apple.backboard.TouchDeliveryPolicyServer"
        ]
        for process in processes {
            xpc_crash(process)
        }
    }
    
    func createPlist(at url: URL) throws {
        let 💀 : [String: Any] = [
            "canvas_height": Int(height),
            "canvas_width": Int(width),
        ]
        let data = NSDictionary(dictionary: 💀)
        data.write(toFile: url.path, atomically: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
