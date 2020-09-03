//
//  LoginViewController.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var presenter: LoginPresenter!
    
    static func storyboardInstance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return  storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(viewDelegate: self)
        tfEmail.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 0.5)
        tfPassword.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 0.5)
        btnLogin.layer.cornerRadius = 24
        tfEmail.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
    
        
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !tfEmail.text!.isEmpty && !tfPassword.text!.isEmpty {
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = UIColor(named: "red")
        } else {
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = UIColor(named: "gray")
        }
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        makeLogin()
    }
    
    @IBAction func tfPrimaryactionTrigger(_ sender: UITextField) {
        makeLogin()
    }
    

}

//MARK:-- view delegate implementation
extension LoginViewController: LoginViewDelegate{
    
    func makeLogin() {
        let email = tfEmail.text
        let password = tfPassword.text
        self.showActivityIndicator()
        presenter.doLogin(email: email ?? "", password: password ?? "")
    }
    
    func onLoginSuccess(msg: String) {
        self.hideActivityIndicator()
                if let viewController = HomeViewController.storyboardInstance() {
            let navController = ContainerViewController()
            let mainView = viewController
            navController.viewControllers = [mainView]
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
    
    func onLoginFailure(msg: String) {
        self.showError(msg: msg)
        self.hideActivityIndicator()
    }

}


enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}
