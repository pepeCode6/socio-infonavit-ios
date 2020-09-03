//
//  HomeViewController.swift
//  SocioInfonavitiOS
//
//  Created by pepe on 02/09/20.
//  Copyright © 2020 pepeMalpica. All rights reserved.
//

import UIKit
import SideMenu
import SkeletonView

class HomeViewController: BaseViewController, HomeViewDelegate {

    var homePresenter: HomePresenter!

    var menu: SideMenuNavigationController?
    
    @IBOutlet weak var tvWallets: UITableView!
    static func storyboardInstance() -> HomeViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return  storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        let ivLogo = UIImageView(image: UIImage(named: "logo"))
        ivLogo.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        ivLogo.contentMode = .scaleAspectFit
        self.navigationItem.titleView = ivLogo
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "red")
        
 
        
        tvWallets.dataSource = self
        tvWallets.delegate = self
        
        tvWallets.rowHeight = 275
        tvWallets.estimatedRowHeight = 275
        
        
        homePresenter = HomePresenter(viewDelegate: self)
        
        self.homePresenter.getWallets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tvWallets.isSkeletonable = true
        tvWallets.showSkeleton()
        tvWallets.startSkeletonAnimation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
    
    //MARK:-- home view delegate implementation
    func onGetOrdenedBenefitsSuccess(benefits: [OrdenedBenefit]) {
        print("pintar: \(benefits.count) collections view")
        tvWallets.stopSkeletonAnimation()
        self.view.hideSkeleton()
        tvWallets.reloadData()
    }
    
    func onGetOrdenedBenefitsFailure(msg: String) {
        print("ª(msg)")
    }
    
}

extension HomeViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homePresenter.ordenedBenefits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvWallets.dequeueReusableCell(withIdentifier: "cell_wallet") as! WalletTableViewCell
        
        cell.renderCell(ordenedBenefit: homePresenter.ordenedBenefits[indexPath.row])
        return cell
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell_wallet"
    }
    
    
    
    
    
}

class MenuListController: UITableViewController, MenuViewDelegate {
    
    var menuPresenter: MenuPresenter!
    
    //MARK:-- menu view delegate implementation
    func onLogoutSuccess(msg: String) {
        if let viewController = LoginViewController.storyboardInstance() {
            // self.present(viewController, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func onLogoutError(msg: String) {
        print("Error al cerrar cesión")
    }
    
    
    var items = ["Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        menuPresenter = MenuPresenter(viewDelegate: self)
        tableView.backgroundColor = UIColor(named: "red")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(named: "red")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row] == "Logout" {
            print("hacer el logout")
            
            let alert = UIAlertController(title: "cerrar sesión", message: "Estas seguro que deseas cerrar sesión.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive, handler: { (action) in
                self.menuPresenter.doLogout()
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alert, animated: true)
            
            
        }
    }
}

