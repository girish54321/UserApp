//
//  SelectedUserViewController.swift
//  UserApp
//
//  Created by Girish Parate on 10/10/22.
//

import UIKit
import SDWebImage

class SelectedUserViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var selectedUser: UserListData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail.text = selectedUser?.email
        userImage.sd_setImage(with: URL(string: selectedUser?.avatar ?? ""))
        title = selectedUser?.firstName ?? ""
        
    }
}
