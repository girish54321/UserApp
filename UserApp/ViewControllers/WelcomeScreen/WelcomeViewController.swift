//
//  WelcomeViewController.swift
//  UserApp
//
//  Created by Girish Parate on 01/10/22.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    @IBOutlet weak var userListTableView: UITableView!
    
    var usersList: UserListResponse?
    var orignalUsersList: UserListResponse?
    var isLoading: Bool = true
    
    // For Seaech
    var resultSearchController = UISearchBar()
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        addBarButton()
        getUserList()
        setUpTableView()
        // Load Search View
        resultSearchController.delegate = self
        resultSearchController.showsScopeBar = true
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.automaticallyShowsSearchResultsController = false
        searchController.showsSearchResultsController = false
        searchController.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setUpTableView(){
        userListTableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        userListTableView.delegate = self
        userListTableView.dataSource = self
    }
    
    func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(onLogOutClick))
    }
    
    @objc func onLogOutClick(){
        let yesButton = Alert().makeUIAlertButton(title: "Yes", style: .default, actionFunction: {
            AppStorage().logoutUser()
            let vc = LoginViewController()
            NavigationHelper().createNewRootNavigation(vc: self, rootVC: vc, style: .fullScreen, prefersLargeTitles: true)
        })
        
        let noButton = Alert().makeUIAlertButton(title: "No", style: .destructive, actionFunction: {
        })
        
        Alert().showNormlaAleat(title: "Log Out?", message: "Are you sure", vc: self, actionsList: [yesButton,noButton])
    }
    
    func loadMoreUsers(){
        if(usersList != nil && usersList?.page ?? 0 <= usersList?.totalPages ?? 1){
            getUserList()
        }
    }
    
    // Search Views OnText Changes
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            print("Search Query not found")
            return
        }
        if(query == ""){
            usersList = orignalUsersList
            self.userListTableView.reloadData()
            return
        }
        
        let newArray = orignalUsersList?.data?.filter({ return $0.firstName?.contains(query) as! Bool })
        usersList?.data = newArray
        self.userListTableView.reloadData()
        print(query)
    }
    // Search View On Search / Enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("On Search Taped")
        
    }
    // Search View On Remove
    func didDismissSearchController(_ searchController: UISearchController) {
        print("On Search Close")
    }
    
}

extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersList?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = userListTableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell {
            // Set Data on Cell
            let item: UserListData = usersList!.data![indexPath.row]
            cell.userEmail.text = item.email!
            cell.userName.text = item.firstName!
            cell.userImage.sd_setImage(with: URL(string: item.avatar ?? ""))
            return cell
        }
        fatalError("Cant Create cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goToVC = SelectedUserViewController()
        let item: UserListData = usersList!.data![indexPath.row]
        
        goToVC.selectedUser = item
        NavigationHelper().goToScreen(vc: self, goToVC: goToVC)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > userListTableView.contentSize.height - 50 - scrollView.frame.size.height {
            loadMoreUsers()
        }
    }
}

extension WelcomeViewController {
    func getUserList(){
        let params : [String: Any] = [
            "page": usersList?.page ?? 1
        ]
        isLoading = true
        UserServices().getUserList(parameters: params){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                if(self.usersList == nil){
                    self.usersList = data
                    self.orignalUsersList = data
                }else{
                    self.usersList?.data?.append(contentsOf: data.data!)
                    self.usersList?.page = data.page! + 1
                    self.usersList?.totalPages = data.totalPages
                    
                    self.orignalUsersList?.data?.append(contentsOf: data.data!)
                    self.orignalUsersList?.page = data.page! + 1
                    self.orignalUsersList?.totalPages = data.totalPages
                }
          
                self.userListTableView.reloadData()
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                  print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
    
}
