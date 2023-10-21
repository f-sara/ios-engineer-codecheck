//
//  DetailRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 藤井紗良 on 2023/10/20.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailRepositoryPresenterInput {
    func viewDidLoad()
}

protocol DetailRepositoryPresenterOutput: AnyObject {
    func displayRepositoryDetails(model: RepositoryModel)
}

final class DetailRepositoryPresenter {
    private weak var output: DetailRepositoryPresenterOutput!
    private let model: RepositoryModel

    init(output: DetailRepositoryPresenterOutput, model: RepositoryModel) {
        self.output = output
        self.model = model
    }
}

extension DetailRepositoryPresenter: DetailRepositoryPresenterInput {
    func viewDidLoad() {
        output.displayRepositoryDetails(model: model)
    }
}
