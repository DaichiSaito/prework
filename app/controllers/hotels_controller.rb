
class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all
  end

  def get_average_price
    yad_id = params[:id]
    plan_url_array = plans(yad_id: yad_id)
    total = 0
    plan_url_array.each do |plan_url|
      sleep 0.1
      total += avarage_price(plan_url: plan_url)
    end
    hotel = Hotel.find_by(hotel_id: params[:id])
    render json: { hotel: hotel, average_price: total / plan_url_array.size }
  end

  private

  def plans(yad_id: yad_id)
    base_url = 'https://www.jalan.net'
    url = "#{ base_url }/#{ yad_id }/plan/?adultNum=1&roomSingle=1&mealType=0"
    html = open(url)
    doc = Nokogiri::HTML.parse(html)
    plan_url_array = doc.css(".detailPlanName").map do |node|
      "https://www.jalan.net#{ node.attribute("href").text }&calYear=2019&calMonth=04"
    end
    plan_url_array
  end

  def avarage_price(plan_url: plan_url)
    # なぜかこれだとうまく動かない...
    # html = open(plan_url)
    html = open(plan_url) do |f|
      f.read # htmlを読み込んで変数htmlに渡す
    end
    doc = Nokogiri::HTML.parse(html)
    priceArray = doc.css('.cal_p').map do |node|
      # "\n¥12,800" みたいなものをただの数値に変換
      node.text.gsub(/\n￥/, "").gsub(",", "").to_i
    end

    # 合計額
    sum = priceArray.reduce {|sum, n| sum + n }
    # 平均額
    avarage = sum / priceArray.size
    avarage
  end
end
