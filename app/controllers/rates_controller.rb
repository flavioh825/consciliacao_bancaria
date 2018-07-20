class RatesController < ApplicationController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]

  # GET /rates
  # GET /rates.json
  def index
    @rates = load_rates
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        format.html { redirect_to @rate, notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to @rate, notice: 'Rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: 'Rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calcular
    render "calculo"
  end

  def calculo
    @rates = load_rates
    total = params[:total].to_f
    @arr = find_rates(total)
    if @arr.blank?
      respond_to do |format|
        format.html { redirect_to calcula_taxa_path, notice: 'Não foram encontrados resultados para esse valor.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to calcula_taxa_path, notice: "Taxa(s) para o valor #{@arr}" }
      end
    end
  end

  private

    def find_rates(total)
      arr = []
      @rates.each do |r|
        @result = total % r.value.to_f
        if @result.zero?
          arr << r.value.to_f
        end
      end
      arr
    end

    def load_rates
      Rate.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:description, :value)
    end
end
