module ApplicationHelper

  def group_category_select
    Category.all.map{|category| [category.name, category.sub_category_select]}
  end

  def rate_select
    (Settings.min_rate..Settings.max_rate).map {|i| [pluralize(i, "star"), i]}
  end

  def order_status_select
    OrderStatus.all.map {|status| [status.name, status.id]}
  end

  def classification_select
    Classification.all.map {|classification| [classification.name, classification.id]}
  end

  def statistic_select
    options = [t("statistic.top_day_product"), t("statistic.top_month_product"),
      t("statistic.top_year_product"), t("statistic.top_day_income_product"),
      t("statistic.top_month_income_product"),
      t("statistic.top_year_income_product"), t("statistic.day_income"),
      t("statistic.month_income"), t("statistic.year_income")]
    options.map.with_index {|option, index| [option, index+1]}
  end
end
