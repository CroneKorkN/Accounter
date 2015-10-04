class AccountTemplatesController < ApplicationController
  before_action :set_account_template, only: [:show, :edit, :update, :destroy]

  # GET /account_templates
  # GET /account_templates.json
  def index
    @account_templates = AccountTemplate.all.order(:order)
  end

  # GET /account_templates/1
  # GET /account_templates/1.json
  def show
  end

  # GET /account_templates/new
  def new
    @account_template = AccountTemplate.new
  end

  # GET /account_templates/1/edit
  def edit
  end

  # POST /account_templates
  # POST /account_templates.json
  def create
    @account_template = AccountTemplate.new(account_template_params)

    respond_to do |format|
      if @account_template.save
        format.html { redirect_to @account_template, notice: 'Account template was successfully created.' }
        format.json { render :show, status: :created, location: @account_template }
      else
        format.html { render :new }
        format.json { render json: @account_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_templates/1
  # PATCH/PUT /account_templates/1.json
  def update
    respond_to do |format|
      if @account_template.update(account_template_params)
        format.html { redirect_to @account_template, notice: 'Account template was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_template }
      else
        format.html { render :edit }
        format.json { render json: @account_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params["account"].each_index do |i|
      AccountTemplate.find(params["account"][i]).update(order: i)
    end
    render inline: "OK"
  end

  # DELETE /account_templates/1
  # DELETE /account_templates/1.json
  def destroy
    @account_template.destroy
    respond_to do |format|
      format.html { redirect_to account_templates_url, notice: 'Account template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_template
      @account_template = AccountTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_template_params
      params.require(:account_template)
            .permit(:number, :name, :close_via_number, :has_initial, :order)
    end
end
