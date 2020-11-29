class GetHorseInfoByJraJob < ApplicationJob
  queue_as :urgent

  def perform(url)
    get_site_info = Mechanize.new.get(url)
    elements = get_site_info.search('tr')
    base_date= url.slice("https://jra.jp/keiba/thisweek/".length..url.length).split("/")
    event_date = Date.new(base_date.first.to_i, base_date.second.slice(0..1).to_i, base_date.second.slice(2..3).to_i)
    elements.slice(1..elements.length).each do |ele|
      father = nil
      mother = nil
      ele.inner_text.split.select{ |i| (i =~ /父|母/) }.each do |i|
        array_string = i.split("")
        if array_string.first == "父" && array_string.second == "："
          father = Father.create(name: array_string.slice(2..array_string.length).join)
        elsif array_string.first == "母" && array_string.second == "："
          mother = Mother.create(name: array_string.slice(2..array_string.length).join)
        end
      end
      horse = Horse.create(name: ele.inner_text.split.second, father: father, mother: mother)
      past_result_params(ele, horse, event_date).each {|params| PastResult.create(params)}
    end
  end

  # 配列固定したけど、列によって違うためnameやclassで取ったほうが良い
  def past_result_params(ele, horse, event_date)
    [
      {
        horse: horse,
        ranking: ele.inner_text.split[19].slice(0).to_i,
        distance: ele.inner_text.split[24].gsub(/芝/, '').to_i,
        match_day: event_date,
        time: calculation_time(ele.inner_text.split[26])
      },
      {
        horse: horse,
        ranking: ele.inner_text.split[35].slice(0).to_i,
        distance: ele.inner_text.split[40].gsub(/芝/, '').to_i,
        match_day: event_date,
        time: calculation_time(ele.inner_text.split[42])
      },
      {
        horse: horse,
        ranking: ele.inner_text.split[51].slice(0).to_i,
        distance: ele.inner_text.split[56].gsub(/芝/, '').to_i,
        match_day: event_date,
        time: calculation_time(ele.inner_text.split[58])
      },
      {
        horse: horse,
        ranking: ele.inner_text.split[67].slice(0).to_i,
        distance: ele.inner_text.split[72].gsub(/芝/, '').to_i,
        match_day: event_date,
        time: calculation_time(ele.inner_text.split[74])
      }
    ]
  end

  def calculation_time(time)
    time.split(':').first.to_i * 60 + time.split(':').second.to_f
  end
end
