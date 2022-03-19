class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: %i[ show edit update destroy ]
  before_action :set_cart, only: [:create]

  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    instrument = Instrument.find(params[:instrument_id])
    @line_item = @cart.add_instrument(instrument)
    if @line_item.save
      redirect_to @line_item.cart, notice: "Item added to cart."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to line_item_url(@line_item), notice: "Line item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy
    redirect_to cart_path(@cart), notice: "Line item was successfully destroyed."
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:instrument_id, :cart_id)
    end
end
