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
    
    weak var parentController: SearchRepositoryViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedRowIndex = parentController.selectedRowIndex {
            updateUI(selectedRowIndex)
            getImage(selectedRowIndex)
        }
    }
}

extension DetailRepositoryViewController {

    private func updateUI(_ selectedRowIndex: Int) {
        let repository = parentController.repositories[selectedRowIndex]
        repositoryTitleView.text = repository.fullName
        languageLabel.text = "Written in \(repository.language)"
        StarsCountLabel.text = "\(repository.stargazersCount) stars"
        watchersCountLabel.text = "\(repository.watchersCount) watchers"
        forksCountLabel.text = "\(repository.forksCount) forks"
        issuesCountLabel.text = "\(repository.openIssuesCount) open issues"
    }
    
    private func getImage(_ selectedRowIndex: Int){
        let repository = parentController.repositories[selectedRowIndex]
        let imageURL = repository.avatarURL
        parseImageData(imageURL)
    }

    private func parseImageData(_ imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in

            if let data = data, let image = UIImage(data: data) {
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

