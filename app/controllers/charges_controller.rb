class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description

  def new
    @charge = Charge.new
    @order = current_order
  end

  def create
    @order = current_order
    if @order.create_charge(charge_params)
      @order.save
      redirect_to review_order_path(id: @order.charge)
    else
      render :new
    end
  end

  def review
    @charge = Charge.find(params[:id])
    @order = @charge.order
    render :review_order
  end

  def submit
    customer = StripeTool.create_customer(
      email: params[:email],
      stripe_token: params[:stripeToken]
    )

    charge = StripeTool.create_charge(
      customer_id: customer.id,
      amount: @amount,
      description: @description
    )

    redirect_to thanks_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_back fallback_location: review_order_path(id: current_order.charge)
  end

  def thanks
  end

private
  def amount_to_be_charged
    @amount = (current_order.calculate_total * 100).to_i
  end

  def set_description
    @description = "Some amazing product"
  end

  def charge_params
    params.require(:charge).permit(
      :name,
      :email,
      :phone,
      :address1,
      :address2,
      :city,
      :state,
      :zip,
      :country
    )
  end

end
