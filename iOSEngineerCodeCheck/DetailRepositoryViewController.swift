//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var repositoryTitleView: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var StarsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    var parentController: SearchRepositoryViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedRowIndex = parentController.selectedRowIndex {
            let repository = parentController.repositories[selectedRowIndex]
            languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
            StarsCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
            watchersCountLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
            forksCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
            issuesCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
            getImage()
        }
        
    }

    func getImage(){
        if let selectedRowIndex = parentController.selectedRowIndex {
            let repository = parentController.repositories[selectedRowIndex]

            if let owner = repository["owner"] as? [String: Any],
               let stringImageURL = owner["avatar_url"] as? String,
               let imageURL = URL(string: stringImageURL) {
                repositoryTitleView.text = repository["full_name"] as? String
                URLSession.shared.dataTask(with: imageURL) { (data, _, error) in

                    if let data = data,
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.repositoryImageView.image = image
                        }
                    } else {
                        print("画像取得エラー")
                    }

                    if let error = error {
                        print("画像取得エラー: \(error.localizedDescription)")
                    }
                }.resume()
            }
        }
    }
}
