//
//  RepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 藤井紗良 on 2023/10/20.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryModel: Codable {
    let fullName: String
    let language: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let avatarURL: URL
}


