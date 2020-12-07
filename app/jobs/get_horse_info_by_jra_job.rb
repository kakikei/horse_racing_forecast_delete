class GetHorseInfoByJraJob < ApplicationJob
  queue_as :urgent

  def perform(url)
    get_site_info = Mechanize.new.get(url)
    elements = get_site_info.search('tr')
    base_date = url.slice("https://jra.jp/keiba/thisweek/".length..url.length).split("/")
    event_date = Date.new(base_date.first.to_i, base_date.second.slice(0..1).to_i, base_date.second.slice(2..3).to_i)
    elements.slice(1..elements.length).each do |ele|
      father = nil
      mother = nil
      ele.inner_text.split.select { |i| (i =~ /父|母/) }.each do |i|
        array_string = i.split("")
        if array_string.first == "父" && array_string.second == "："
          father = Father.find_or_create_by(name: array_string.slice(2..array_string.length).join)
        elsif array_string.first == "母" && array_string.second == "："
          mother = Mother.find_or_create_by(name: array_string.slice(2..array_string.length).join)
        end
      end
      # ele.children[5].children[1].children[1].children[0].text.split.firstでも馬の名前取れるっぽい
      horse = Horse.find_or_create_by(name: ele.inner_text.split.second, father: father, mother: mother)
      past_result_params(ele, horse, event_date).each { |params| PastResult.create(params) }
    end
  end

  # 配列固定したけど、列によって違うためnameやclassで取ったほうが良い
  # 名前の最後に"芝"か"ダ"が来たらアウト
  def past_result_params(ele, horse, event_date)
    rankings = ele.inner_text.split.select { |i| i.include?("着") }
    distances = ele.inner_text.split.select { |i| ["芝", "ダ"].include?(i.split("").last) }
    times = ele.inner_text.split.select { |i| i.include?(":") && i.include?(".") }
    params = rankings.map.with_index do |ranking, index|
      {
        horse: horse,
        ranking: ranking.slice(0).to_i,
        distance: distances[index].gsub(/芝|ダ/, '').to_i,
        match_day: event_date,
        time: calculation_time(times[index])
      }
    end
    params
  end

  def calculation_time(time)
    time.split(':').first.to_i * 60 + time.split(':').second.to_f
  end
end
