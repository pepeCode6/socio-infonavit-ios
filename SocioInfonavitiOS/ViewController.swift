//
//  ViewController.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ivLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ivLogo.alpha = 0.0
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn, animations: {
            self.ivLogo.alpha = 1.0
        })
        animator.addCompletion { position in
            self.selectScreen()
        }
        animator.startAnimation()
    }
    
    private func selectScreen() {
        // LocalStorageManager.shared.removeJWT()
        LocalStorageManager.shared.getJWT { (jwt) in
            if jwt.count > 0 {
                self.goHome()
            } else {
                self.goLogin()
            }
        }
    }
    
    private func goLogin() {
        if let viewController = LoginViewController.storyboardInstance() {
            // self.present(viewController, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    private func goHome() {
        

        if let viewController = HomeViewController.storyboardInstance() {
            let navController = ContainerViewController()
            let mainView = viewController
            navController.viewControllers = [mainView]
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
        
        
//
//        if let viewController = HomeViewController.storyboardInstance() {
//            // self.present(viewController, animated: true, completion: nil)
//            present(viewController, animated: true, completion: nil)
//        }
    }
    
    
}

