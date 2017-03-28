module Admin::StatisticsHelper
  def render_chart chart_type
    case chart_type
    when Settings.chart_type.number_of_product_day
      column_chart OrderDetail.by_day(@day).number_of_product_chart_data
    when Settings.chart_type.number_of_product_month
      column_chart OrderDetail.by_month(@day).number_of_product_chart_data
    when Settings.chart_type.number_of_product_year
      column_chart OrderDetail.by_year(@day).number_of_product_chart_data
    when Settings.chart_type.income_of_product_day
      column_chart OrderDetail.by_day(@day).income_of_product_chart_data
    when Settings.chart_type.income_of_product_month
      column_chart OrderDetail.by_month(@day).income_of_product_chart_data
    when Settings.chart_type.income_of_product_year
      column_chart OrderDetail.by_year(@day).income_of_product_chart_data
    when Settings.chart_type.income_daily
      line_chart OrderDetail.income_daily
    when Settings.chart_type.income_monthy
      line_chart OrderDetail.income_monthy
    else
      line_chart OrderDetail.income_yearly
    end
  end
end
