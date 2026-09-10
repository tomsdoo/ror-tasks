class Api::V1::HelloController < ApplicationController
  def index
    # ハッシュや配列を渡すと、Railsが自動でJSONに変換します
    render json: {
      message: "Hello from Rails API!",
      status: "success",
      timestamp: Time.current
    }
  end
end
