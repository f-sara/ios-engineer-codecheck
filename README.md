# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の説明を詳しく読んだ上で課題を取り組んでください。

新卒／未経験者エンジニアの場合、本リファクタリングの通常課題の代わりに、[新規アプリ作成の特別課題](https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud)も選択できますので、ご自身が得意と感じる方を選んでください。特別課題を選んだ場合、通常課題の取り組みは不要です。新規アプリ作成の課題の説明を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 14.1）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.7）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.1）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示


##  課題の進行状況
* issue #6 まで終了
* issue #9 のテストを追加については完全な実装となっていない（PRに詳細記載済み）

|  issue  |  Pull requests  |
| ---- | ---- |
|  ソースコードの可読性の向上 #1  |  [Refactor/improve readability #1](https://github.com/f-sara/ios-engineer-codecheck/pull/10)  |
|  ソースコードの安全性の向上 #2  |  [Refactor/improve security #2](https://github.com/f-sara/ios-engineer-codecheck/pull/11)  |
|  バグを修正 #3  |  [Fix/bug fixes #3](https://github.com/f-sara/ios-engineer-codecheck/pull/13)  |
|  Fat VC の回避 #4  |  [Refactor/improve fat vc #4, #6](https://github.com/f-sara/ios-engineer-codecheck/pull/14)  |
|  プログラム構造をリファクタリング #5  |  [Refactor/code refactoring #5](https://github.com/f-sara/ios-engineer-codecheck/pull/15)  |
|  アーキテクチャを適用 #6  |  [Refactor/improve fat vc #4, #6](https://github.com/f-sara/ios-engineer-codecheck/pull/14)  |
|  テストを追加 #9  |  [Test/add test #9](https://github.com/f-sara/ios-engineer-codecheck/pull/16)  |
