module HomeHelper
  def item_discounts(item, discounts)
    return unless discounts[item]

    discounts[item]&.collect do |discount|
      discountable = discount.discountable(item)
      content_tag(:small, "#{number_to_currency((item.price - discount.price)/100.0, :unit => '$')} (with a #{discountable.name})", class: 'block')
    end.join.html_safe
  end

  def discount_price(discount, quantity)
    -discount.price * quantity/100.0
  end

  def discount_detail(discount, quantity)
    "#{discount.amount}%(#{discount.discountable_from.name},#{discount.discountable_to.name}) x #{quantity}"
  end
end
