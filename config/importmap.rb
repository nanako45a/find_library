# Pin npm packages by running ./bin/importmap
# importmapを使用し、jsライブラリ（@hotwired/turbo-railsなど）をpackage.json,node_modulesを介さず直接アプリに組み込む

# TurboとStimulusコントローラをフロントエンドで利用可能にする
pin "application", preload: true

# turbo,stimulus,追加のStimulusライブラリをピンし、プリロードされるよう設定
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# app/javascript/controllers内のjsファイルを自動的にロードし、controllers名前空間下で利用可能にする
pin_all_from "app/javascript/controllers", under: "controllers"
