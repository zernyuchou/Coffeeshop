# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @items = Item.all
  end

  def calculate
    items_h = params[:items].select{|k,v| v.present?}.to_enum.to_h
    item_ids = items_h.keys

    @orders = Hash[items_h.map{ |id, quantity| [Item.find_by(id: id), quantity.to_i] }]

    @sub_total = @orders.map{|item, quantity| item.price * quantity}.sum

    discounts = Discount.with_items(item_ids).sort_by(&:applied_price).reverse
    @available_discounts = {}

    discounts.each do |discount|
      next if @orders[discount.discountable_from].to_i == 0
      next if @orders[discount.discountable_to].to_i == 0

      loop do
        break if @orders[discount.discountable_from].to_i == 0 || @orders[discount.discountable_to].to_i == 0

        @orders[discount.discountable_from] -= 1
        @orders[discount.discountable_to] -= 1

        @available_discounts[discount] ||= 0
        @available_discounts[discount] += 1
      end
    end

    @total = @sub_total - @available_discounts.map{|discount, quantity| discount.applied_price * quantity}.sum

    respond_to do |format|
      format.turbo_stream
    end
  end

  def order
  end

  private

  def order_params
    params.permit(:items)
  end
end
