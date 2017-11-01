//
//  LaunchViewController.swift
//  Dinar Back
//
//  Created by bo on 10/24/17.
//  Copyright © 2017 Jixtra Technologies LLP. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var failedToLoadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if RestAPI.shared.isInternetAvailable(){
            failedToLoadLabel.isHidden = true
            retryBtn.isHidden = true
            self.automaticLogin()
        }else{
            failedToLoadLabel.isHidden = false
            retryBtn.isHidden = false
        }
        
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func automaticLogin(){
        if let expireDate = UserDefaults.standard.object(forKey: UserAccessTokenExpireDate) as? Date{
            if expireDate.isExpire(){
//                SVProgressHUD.show()
                PKGIFHUD.setGifWithImageName("Loading.gif")
                PKGIFHUD.showWithOverlay()
                RestAPI.shared.refreshAccessToken(completionHandler: { (success, data, error) in
                    if(success){
                        if(data != nil){
                            AppDelegate.updateUserSessionData(data as! [String : Any])
                            RestAPI.shared.getLoginData(completionHandler: { (success, data, error) in
                                SVProgressHUD.dismiss()
                                if(success){
                                    if(data != nil){
                                        AppDelegate.loginSuccessful(data)
                                    }
                                }
                            })
                        }
                    }else{
//                        SVProgressHUD.dismiss()
                        PKGIFHUD.dismiss()
                    }
                })
            }else{
//                SVProgressHUD.show()
                PKGIFHUD.setGifWithImageName("Loading.gif")
                PKGIFHUD.showWithOverlay()
                RestAPI.shared.getLoginData(completionHandler: { (success, data, error) in
//                    SVProgressHUD.dismiss()
                    PKGIFHUD.dismiss()
                    if(success){
                        if(data != nil){
                            AppDelegate.loginSuccessful(data)
                        }else{
                           
                        }
                    }else{
                       
                        
                    }
                })
            }
        }else{
            let welcomViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            self.navigationController?.pushViewController(welcomViewController, animated: true)
            
        }
    }
    

    @IBAction func retryClicked(_ sender: UIButton) {
        if RestAPI.shared.isInternetAvailable(){
            failedToLoadLabel.isHidden = true
            retryBtn.isHidden = true
            self.automaticLogin()
        }else{
            failedToLoadLabel.isHidden = false
            retryBtn.isHidden = false
        }
    }
   

}
