module ApplicationHelper
# 検索フォームにて"prefectures_for_select.map"として呼び出し
  def prefectures_for_select
    ['北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県', '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', 
     '神奈川県', '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県', '三重県', '滋賀県', '京都府',
     '大阪府', '兵庫県', '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県', '高知県', 
     '福岡県', '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県'
    ]
  end

  def default_meta_tags
    {
      site: 'FindLibrary',
      title: 'FindLibrary',
      reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るためのテキスト
      description: '自習室のある図書館を検索できるサービスです',
      keywords: '自習室,図書館',   #キーワードを「,」区切りで設定
      canonical: request.original_url,   #優先するurlを指定
      icon: [                    #画像はapp/assets/imagesディレクトリに保存
        { href: image_url('OGP.png') },
        { href: image_url('OGP.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: request.original_url,
        image: image_url('OGP.png'),# 配置するパスやフォルダ名によって変更
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@rntq_75',
        image: image_url('OGP.png')
      }
    }
  end
end
