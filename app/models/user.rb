class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # MEMO: アソシエーションのルール
  # アソシエーションはモデルとモデルの関連付けのこと。
  # 今回だったらUserモデルとBookモデルを紐付けたい。
  # ユーザはたくさんbookを投稿できる、bookは必ず一人のユーザに紐づいている
  # なので、ユーザとbookは一対多の関係
  # つまり、User has many books.
  # これをrailsの言葉で書くと、以下のようになる
  has_many :books

  # MEMO: refileの記述。カラム_idってなってるのの、_idを抜いたのをかく。
  attachment :profile_image

  # MEMO: データに間することはモデルに定義。
  # Userにモデルにvalidationを定義すれば、sign_upとかsign_inとか、Userにまつわるフォームでエラー文を出せる。
  # name：一意性を持たせ、かつ2～20文字の範囲で設定してください。
  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  # introduction：最大50文字までに設定してください。
  validates :introduction, length: {maximum: 50}
end
