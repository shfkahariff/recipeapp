class LeaveBalancesController < ApplicationController
  before_action :set_leave_balance, only: %i[ show edit update destroy ]

  # GET /leave_balances or /leave_balances.json
  def index
    @leave_balances = LeaveBalance.all
    @leave_balance = LeaveBalance.new
  end

  # GET /leave_balances/1 or /leave_balances/1.json
  def show
  end

  # GET /leave_balances/new
  def new
    @leave_balance = LeaveBalance.new
  end

  # GET /leave_balances/1/edit
  def edit
  end

  # POST /leave_balances or /leave_balances.json
  def create
    @leave_balance = LeaveBalance.new(leave_balance_params)

    respond_to do |format|
      if @leave_balance.save
        format.html { redirect_to leave_balances_url, notice: "Leave balance was successfully created." }
        format.json { render :index, status: :created, location: @leave_balance }
      else
        Rails.logger.debug @leave_balance.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leave_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leave_balances/1 or /leave_balances/1.json
  def update
    respond_to do |format|
      if @leave_balance.update(leave_balance_params)
        format.html { redirect_to leave_balance_url(@leave_balance), notice: "Leave balance was successfully updated." }
        format.json { render :show, status: :ok, location: @leave_balance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leave_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_balances/1 or /leave_balances/1.json
  def destroy
    @leave_balance.destroy

    respond_to do |format|
      format.html { redirect_to leave_balances_url, notice: "Leave balance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_balance
      @leave_balance = LeaveBalance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_balance_params
      params.require(:leave_balance).permit(:leavetype, :balance, :user_id)
    end
end
