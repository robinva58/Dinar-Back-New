//
//  LoginViewController.swift
//  Dinar Back
//
//  Created by Madhup Yadav on 18/07/17.
//  Copyright © 2017 Jixtra Technologies LLP. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: LoginUIControlsViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var emailCell: JTSTableViewCell!
    @IBOutlet weak var passwordCell: JTSTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.cells = [emailCell, passwordCell]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return emailCell
        default:
            return passwordCell
        }
    }
    
    @IBAction func loginClicked(){
        self.view.endEditing(true)
//        SVProgressHUD.show()
        PKGIFHUD.setGifWithImageName("Loading.gif")
        PKGIFHUD.showWithOverlay()
        RestAPI.shared.login(email: emailCell.textField.text!, password: passwordCell.textField.text!.encrypt()) { (success, data, error) in
//            SVProgressHUD.dismiss()
            PKGIFHUD.dismiss()
            if(success){
                if data != nil{
                    AppDelegate.loginSuccessful(data)
                }
            }
        }
    }

}
