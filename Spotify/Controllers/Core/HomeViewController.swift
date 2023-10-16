//
//  HomeViewController.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 25-09-23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), 
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        
        fetchData()

    }
    
    private func fetchData() {
        
//        APICaller.shared.getFeaturedPlaylists { result in
//            switch result{
//            case .success(let string): break
//            case .failure(let error): break
//            }
//        }
        
//        APICaller.shared.getCurrentUserProfile { _ in
//            
//        }
        
        APICaller.shared.getRecomendationsGenres { result in
            
            switch result{
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecomendations(genres: seeds) { result in
                    
                }
                
            case .failure(let error): break
            }
            
        }
    }

    @objc func didTapSettings() {
        let vc = SettingViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

