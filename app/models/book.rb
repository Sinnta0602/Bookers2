class Book < ApplicationRecord
    # MEMO: book belongs to a user.
    # 子供の方には親のidをカラムとして定義する。user_id
    belongs_to :user

    # MEMO: データに間することはモデルに定義。
    # Bookモデルに定義すれば、New Bookとか、Bookにまつわるところでエラー文を表示できる。
    # 何にまつわるのか？っていうのは、form_forとかform_withの引数(model: book)とかで判定する。
    validates :title,  presence: :true
    validates :body,  presence: :true
end
