//
//  ProfileViewController.swift
//  Spotify
//
//  Created by miguel tomairo on 3/12/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .systemBackground

        fetchProfile()
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile {[weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedGetProfile()
                }
            }
        
        }
    }
    
    private func updateUI(with model: UserProfile) {
        
    }
    
    private func failedGetProfile() {
        
    }
    
}
