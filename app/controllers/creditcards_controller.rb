class CreditcardsController < ApplicationController
  require "payjp"

  def new
    @card = Creditcard.new
    card = Creditcard.where(user_id: current_user.id)
    if card.exists?
      redirect_to creditcard_path(current_user.id)
      flash[:notice] = "カード情報は既に登録されています"
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if params[:creditcard][:number].blank? || params[:creditcard][:cvc].blank?
      redirect_to action: "new"
      flash[:alert] = "全ての項目を正しく入力して下さい"
    else
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
        flash[alert] = "カード情報が無効です"
      else
        customer = Payjp::Customer.create(card: token)
        card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        card.save!
        if card.save!
          redirect_to done_create_creditcards_path
        else
          redirect_to new_card_path
          flash[:alert] = "カード情報登録に失敗しました"
        end
      end
    end
  end

  def show
    card = Creditcard.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new"
      flash[:notice] = "カード情報が未登録です"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.data[0]
    end
  end

  def destroy
    card = Creditcard.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    if card.destroy
      # redirect_to user_show_path(current_user.id)
      redirect_to done_destroy_creditcards_path
    else
      redirect_to creditcard_path(current_user.id)
      flash[:alert] = "カード情報削除に失敗しました"
    end
  end

end