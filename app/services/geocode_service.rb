# 必要なライブラリをrequire文で読み込む
# net/http: HTTPリクエストを送信するため
# uri: URIを解析し、HTTPリクエストのために使用する
# json: JSON形式のレスポンスをパースするため
# cgi: URLに含めるパラメータをエスケープするため
require 'net/http'
require 'uri'
require 'json'
require 'cgi'

class GeocodeService
  # ユーザーの都道府県と市町村から緯度経度を取得するメソッド
  def self.get_user_geocode(user_prefecture, user_city)
    # 環境変数からGoogle Maps APIキーを取得
    user_api_key = ENV['GOOGLE_MAPS_API_KEY']
    
    # ユーザーが提供した都道府県と市町村を結合して住所を作成
    user_address = "#{user_prefecture} #{user_city}"
    
    # Geocoding APIのリクエストURIを構築（住所はURLエンコードが必要）
    user_uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(user_address)}&key=#{user_api_key}")
    
    # 構築したURIを使用してHTTP GETリクエストを送信し、レスポンスを受け取る
    user_response = Net::HTTP.get(user_uri)
    
    # 受け取ったJSON形式のレスポンスをパースしてRubyのハッシュに変換
    user_json_response = JSON.parse(user_response)

    # APIからのレスポンスがOKの場合、緯度経度を抽出して返す
    if user_json_response['status'] == 'OK'
      user_latitude = user_json_response['results'][0]['geometry']['location']['lat']
      user_longitude = user_json_response['results'][0]['geometry']['location']['lng']
      
      # 緯度経度を含むハッシュを返却
      { user_latitude: user_latitude, user_longitude: user_longitude }
    else
      # エラーが発生した場合は、エラーステータスを含むハッシュを返却
      { user_error: user_json_response['status'] }
    end
  end

  # 半径5km以内にある図書館を検索し、図書館の名前の配列を返すメソッド
  def self.find_libraries_nearby(latitude, longitude)
    # 環境変数からGoogle Maps APIキーを取得
    api_key = ENV['GOOGLE_MAPS_API_KEY']
    
    # 緯度経度と検索半径を指定して検索条件を設定
    location = "#{latitude},#{longitude}"
    radius = 100000 # 半径10km
    type = 'library' # 検索タイプを図書館に指定

    # Places APIのnearbysearchエンドポイントにリクエストを送信
    uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{location}&radius=#{radius}&type=#{type}&key=#{api_key}")
    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)

    # APIからのレスポンスがOKの場合、検索結果を処理
    if json_response['status'] == 'OK'
      # 図書館の名前と場所を含むハッシュの配列を返す
      # 各図書館の情報を{name: 名前, location: 場所}の形式でマッピング
      libraries = json_response['results'].map do |library|
        { name: library['name'], location: library['vicinity'] }
      end
      return libraries
    else
      # エラーがあればそのステータスをコンソールに出力し、空の配列を返す
      puts "Error: #{json_response['status']}"
      return []
    end
  end
end
