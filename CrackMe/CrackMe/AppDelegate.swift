//
//  AppDelegate.swift
//  CrackMe
//
//  Created by Giuliano Cioffi on 4/14/17.
//  Copyright © 2017 Giuliano Cioffi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var codeTextField: NSTextField!
    @IBOutlet weak var licenceStatusLabel: NSTextField!
    
    func MD5(_ string: String) -> [UInt8] {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return digest
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidLicence(email: String, code: String) -> Bool {
        return validate(email, code)
    }
    
    func printStatusMessage(message: String) {
        licenceStatusLabel.stringValue = message
    }
    
    @IBAction func handleOK(_ sender: Any) {
        if !(isValidEmail(testStr: emailTextField.stringValue)) {
            printStatusMessage(message: "email address is invalid")
            return
        }
        

        if (isValidLicence(email: emailTextField.stringValue, code: codeTextField.stringValue)) {
            printStatusMessage(message: "thanks for registering")
        } else {
            printStatusMessage(message: "invalid licence code")
        }
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}



