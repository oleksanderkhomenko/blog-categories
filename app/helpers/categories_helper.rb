module CategoriesHelper
  def draw_categories(categories, option = false)
    categories.map do |category, sub_category|
      render(category, option: option) + draw_categories(sub_category, option)
    end.join.html_safe
  end
end
