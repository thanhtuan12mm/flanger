class InstrumentsController < ApplicationController
  before_action :set_instrument, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :main]

  def main
    @instruments = Instrument.all
  end

  def index
    @instruments = Instrument.all.order('created_at desc')
  end

  def show
  end

  def new
    @instrument = current_user.instruments.build
  end

  def edit
  end

  def create
    @instrument = current_user.instruments.build(instrument_params)
    if @instrument.save
      redirect_to instrument_url(@instrument), notice: "Instrument was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instrument.update(instrument_params)
      redirect_to instrument_url(@instrument), notice: "Instrument was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instrument.destroy
    redirect_to instruments_url, notice: "Instrument was successfully destroyed."
  end

  private
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition, :finish, :title, :price, :image)
    end
end
