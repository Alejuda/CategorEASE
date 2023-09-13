class PurchasesController < ApplicationController
  # before_action :set_purchase, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /purchases or /purchases.json
  def index
    @group = Group.includes(:purchases).find(params[:group_id])
    @purchases = @group.purchases.order(created_at: :desc)
  end

  # # GET /purchases/1 or /purchases/1.json
  # def show
  # end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @group = Group.find(params[:group_id])
    @purchase.author = current_user
    @available_groups = current_user.groups
  end

  # # GET /purchases/1/edit
  # def edit
  # end

  # POST /purchases or /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    @groups = current_user.groups

    if params[:purchase][:group_ids].nil?
      redirect_to new_group_purchase_path(params[:group_id]), alert: 'You should select at least one group.'
      return
    end

    params[:purchase][:group_ids].each do |group|
      @purchase.groups << @groups.find { |g| g.id == group.to_i }
    end

    respond_to do |format|
      if @purchase.save
        format.html do
          redirect_to group_purchases_path(params[:group_id]), notice: 'Purchase was successfully created.'
        end
        format.json { render :index, status: :created, location: @purchase }
      else
        format.html { redirect_to new_group_purchase_path(params[:group_id]), alert: 'Please, insert valid values.' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /purchases/1 or /purchases/1.json
  # def update
  #   respond_to do |format|
  #     if @purchase.update(purchase_params)
  #       format.html { redirect_to purchase_url(@purchase), notice: "Purchase was successfully updated." }
  #       format.json { render :show, status: :ok, location: @purchase }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @purchase.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /purchases/1 or /purchases/1.json
  # def destroy
  #   @purchase.destroy

  #   respond_to do |format|
  #     format.html { redirect_to purchases_url, notice: "Purchase was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_purchase
  #   @purchase = Purchase.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def purchase_params
    params.require(:purchase).permit(:name, :amount, :author_id)
  end
end
