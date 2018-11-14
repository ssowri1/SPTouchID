/*
 * SPAuthentication
 * This SPAuthentication is main class to handle the biometric opertaions
 * @category   SPTouchID
 * @package    com.SPTouchID
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2018 ssowri1. All rights reserved.
 */
import Foundation
import LocalAuthentication

/// Public class to get authentication status.
@objc public protocol LocalAuthDelegate {
    func authenticationFinished(string: String)
    func authenticationFinishedWithError(error: String)
}

/// Local Authentication class. Note: Must Provide NSFaceIDUsageDescription in your Info,plist file.
@objc public class SPAuthentication: NSObject {
    ///Private key value for store and retrive User's Login details
    private let keyValue: String = "accountDdetains_contusion"
    let localAuthenticationContext = LAContext()
    
    private let keyValueForAuth: String = "accountDetails_contusionAuth"
    
    ///Private success message
    private let successMessage: String = "Authentication successfull"
    
    /// Authentication status.
    @objc public var isAuthenticated = false {
        didSet {
            //            self.keychain.set(isAuthenticated, forKey: keyValueForAuth)
        }
    }
    
    /// Error caused by Local authentication.
    @objc public var authError: NSError?
    
    ///'TimeInterval' for expiry of authentication status. Default is 0.0 (Infinity - no expiry).
    @objc public var authTime = 0.0 { didSet { if authTime != 0.0 { if #available(iOS 10.0, *) {
        _ = Timer.init(timeInterval: TimeInterval.init(authTime), repeats: false) { (timer) in
            self.isAuthenticated = false }
    } else {
        // Fallback on earlier versions
        } } } }
    
    /// Delegate to provide Location authentication status
    @objc public var delegate: LocalAuthDelegate?
    
    /// Bool value to support password support for authentication.
    @objc public var withPassword = false
    
    /// String to show in authentication popup
    @objc public var reasonString = "To authenticate over your Finger Print"
    
    /// Fall back title
    @objc public var fallbackTitle = ""
    
    
    /// Public init method
    @objc public override init() {
        super.init()
        self.isAuthenticated = false
    }
    
    ///Dismiss Biometrics Auth
    @objc public func dismissAuth() {
        self.localAuthenticationContext.invalidate()
    }
    
    
    /// Start the authentication process using Biometrics
    @objc public func start() {
        authError = nil
        localAuthenticationContext.localizedFallbackTitle = fallbackTitle
        DispatchQueue.main.async {
            if self.localAuthenticationContext.canEvaluatePolicy((self.withPassword) ? LAPolicy.deviceOwnerAuthentication : LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &self.authError) {
                self.localAuthenticationContext.evaluatePolicy((self.withPassword) ? LAPolicy.deviceOwnerAuthentication : LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: self.reasonString) { success, evaluateError in
                    if success {
                        if self.delegate != nil {
                            self.isAuthenticated = true
                            self.delegate?.authenticationFinished(string: self.successMessage)
                        }
                    } else {
                        guard let error = evaluateError else {
                            return
                        }
                        self.isAuthenticated = false
                        self.delegate?.authenticationFinishedWithError(error: self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    }
                }
            }
        }
    }
    
    /// Save password and user login details in KeyChain for safer access
    ///
    /// - Parameter value: value to store in Keychain. e.g - "password=PASSWORD@123,username=USER123"
    @objc public func saveAccountDetailsToKeychain(value: String) {
        //        keychain.set(value, forKey: keyValue)
    }
    
    
    /// Evaluating error caused from LocalAuthentications
    ///
    /// - Parameter errorCode: Error Code based on LocalAuthentications
    /// - Returns: String value to give exact Error description
    fileprivate func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    /// Evaluating AuthenticationPolicy Message For Local Authentication
    ///
    /// - Parameter errorCode: Error code
    /// - Returns: Exact Error description
    fileprivate func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
    
}
