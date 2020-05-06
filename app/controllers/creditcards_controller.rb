class CreditcardsController < ApplicationController
  require "payjp"

  def new
    @card = Creditcard.new
    card = Creditcard.where(user_id: current_user.id)
    if card.exists?
      redirect_to root_path
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    token = Payjp::Token.create({
      card: {
        number:     params[:creditcard][:number],
        cvc:        params[:creditcard][:cvc],
        exp_month:  params[:creditcard][:exp_month],
        exp_year:   params[:creditcard][:exp_year]
        }},
        {'X-Payjp-Direct-Token-Generate': 'true'} 
      )
    if token.blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(card: token)
      card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      card.save!
      if card.save!
        redirect_to root_path
      else
        redirect_to new_card_path
      end
    end

    def show
      card = Creditcard.find_by(user_id: current_user.id)
      if card.blank?
        redirect_to action:new
      else
        Payjp.api_key = Rails.cssapplication.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
        customer = Payjp::Customer.retrieve(card.customer_id)
        @default_card_information = customer.card.retrieve(card.card_id)
        # @default_card_information = Payjp::Customer.retrieve(card.customer_id).card.data[0]
      end
    end
  end
end