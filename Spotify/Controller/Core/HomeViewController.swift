//
//  ViewController.swift
//  Spotify
//
//  Created by miguel tomairo on 3/12/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
    }

    @objc func didTapSettings() {
        let vc = SettingViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

