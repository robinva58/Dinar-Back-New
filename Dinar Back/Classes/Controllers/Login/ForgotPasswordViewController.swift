//
//  ForgotPasswordViewController.swift
//  Dinar Back
//
//  Created by Madhup Yadav on 22/07/17.
//  Copyright © 2017 Jixtra Technologies LLP. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: LoginUIControlsViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emailCell: JTSTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cells = [emailCell]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return emailCell
    }

    @IBAction func forgotPasswordClicked(_ sender: JTSFormButton) {
        self.view.endEditing(true)
//        SVProgressHUD.show()
        PKGIFHUD.setGifWithImageName("Loading.gif")
        PKGIFHUD.showWithOverlay()
        RestAPI.shared.forgotPassword(email: emailCell.textField.text!) { (success, data, error) in
//            SVProgressHUD.dismiss()
            PKGIFHUD.dismiss()
            if(success){
                if data != nil{
                    appDelegate.showAlert(message: "Instructions have been sent to your registered email.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
