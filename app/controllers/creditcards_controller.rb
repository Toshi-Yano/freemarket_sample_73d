class CreditcardsController < ApplicationController
  before_action :set_secret_key, except:[:new]
  before_action :set_user_card, only:[:show, :destroy]
  before_action :set_customer, only:[:show, :destroy]
  
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
    if @card.blank?
      redirect_to action: "new"
      flash[:notice] = "カード情報が未登録です"
    else
      @default_card_information = @customer.cards.data[0]
    end
  end

  def destroy
    @customer.delete
    @card.delete
    if @card.destroy
      # redirect_to user_show_path(current_user.id)
      redirect_to done_destroy_creditcards_path
    else
      redirect_to creditcard_path(current_user.id)
      flash[:alert] = "カード情報削除に失敗しました"
    end
  end

  private

  def set_secret_key
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
  end

  def set_user_card
    @card = Creditcard.find_by(user_id: current_user.id)
  end

  def set_customer
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

end