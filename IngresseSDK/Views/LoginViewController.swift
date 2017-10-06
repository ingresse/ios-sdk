//
//  LoginViewController.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 01/09/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: AphTextField!
    @IBOutlet weak var txtPassword: AphTextField!

    public var service: IngresseService!
    public var loginDelegate: LoginDelegate!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLoginPressed(_ sender: AphButton) {
        
        service.auth.loginWithEmail(self.txtEmail.text!, andPassword: self.txtPassword.text!, onSuccess: { (user) in
            
            self.loginDelegate.didLoginUser(user)
            
        }) { (apiError) in
            
            self.loginDelegate.didFailLogin(error: apiError)
            
        }
        
    }
    
    static public func getViewController() -> LoginViewController {
        
        let sdkBundle = Bundle(for: LoginViewController.self)
        return sdkBundle.loadNibNamed("LoginViewController", owner: nil, options: nil)?.first as! LoginViewController
        
    }

}

public protocol LoginDelegate {
    
    func didLoginUser(_ user: IngresseUser)
    
    func didFailLogin(error: APIError)
    
}
