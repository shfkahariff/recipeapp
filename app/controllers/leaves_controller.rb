class LeavesController < ApplicationController
  before_action :set_leafe, only: %i[ show edit update destroy ]

  # GET /leaves or /leaves.json
  def index
    @leaves = Leafe.all
    @leafe = Leafe.new
  end

  # GET /leaves/1 or /leaves/1.json
  def show
    mark_as_read
  end

  # GET /leaves/new
  def new
    @leafe = Leafe.new
  end

  # GET /leaves/1/edit
  def edit
  end

  # POST /leaves or /leaves.json
  def create
    @leafe = Leafe.new(leafe_params)

    @leafe.name = current_user.name
    @leafe.status = "Pending"
    @leafe.attachment = params[:leafe][:attachment]
    @leafe.duration = (@leafe.endDate.to_date - @leafe.startDate.to_date).to_i + 1

    respond_to do |format|
      if @leafe.save
        format.html { redirect_to leaves_url, notice: "Leafe was successfully created." }
        format.json { render :index, status: :created, location: @leafe }
      else
        Rails.logger.debug @leafe.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaves/1 or /leaves/1.json
  def update
    respond_to do |format|
      if @leafe.update(leafe_params)
        format.html { redirect_to leafe_url(@leafe), notice: "Leafe was successfully updated." }
        format.json { render :show, status: :ok, location: @leafe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @leafe = Leafe.find(params[:id])
    @leafe.update(status: "Cancelled")
    redirect_to leaves_path, notice: "Leave cancelled."
  end

  def approve
    @leafe = Leafe.find(params[:leafe_id])
    @leafe.update(comment: params[:comment], status: 'Approved')
    redirect_to admin_dashboard_path, notice: "Leave approved."
  end
  
  def decline
    @leafe = Leafe.find(params[:leafe_id])
    @leafe.update(comment: params[:comment], status: 'Declined')
    redirect_to admin_dashboard_path, notice: "Leave declined."
  end

  # DELETE /leaves/1 or /leaves/1.json
  def destroy
    @leafe.destroy

    respond_to do |format|
      format.html { redirect_to leaves_url, notice: "Leafe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leafe
      @leafe = Leafe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leafe_params
      params.require(:leafe).permit(:startDate, :endDate, :duration, :status, :notes, :attachment, :name, :comment, :leave_balance_id)
    end

    def mark_as_read
      if current_user.admin? || @leafe.notifications_as_leafe.where(recipient: current_user).exists?
        notifications_to_mark_as_read = @leafe.notifications_as_leafe.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
      end
    end
end
