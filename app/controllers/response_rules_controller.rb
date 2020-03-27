class ResponseRulesController < ApplicationController
  before_action :set_response_rule, only: [:show, :edit, :update, :destroy]

  # GET /response_rules
  # GET /response_rules.json
  def index
    @response_rules = ResponseRule.all
  end

  # GET /response_rules/1
  # GET /response_rules/1.json
  def show
  end

  # GET /response_rules/new
  def new
    @response_rule = ResponseRule.new
  end

  # GET /response_rules/1/edit
  def edit
  end

  # POST /response_rules
  # POST /response_rules.json
  def create
    @response_rule = ResponseRule.new(response_rule_params)

    respond_to do |format|
      if @response_rule.save
        format.html { redirect_to @response_rule, notice: 'Response rule was successfully created.' }
        format.json { render :show, status: :created, location: @response_rule }
      else
        format.html { render :new }
        format.json { render json: @response_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /response_rules/1
  # PATCH/PUT /response_rules/1.json
  def update
    respond_to do |format|
      if @response_rule.update(response_rule_params)
        format.html { redirect_to @response_rule, notice: 'Response rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @response_rule }
      else
        format.html { render :edit }
        format.json { render json: @response_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_rules/1
  # DELETE /response_rules/1.json
  def destroy
    @response_rule.destroy
    respond_to do |format|
      format.html { redirect_to response_rules_url, notice: 'Response rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_rule
      @response_rule = ResponseRule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_rule_params
      params.require(:response_rule).permit(:name, :path, :response_template_id, :response_code, :conditions, :sleep, :raise_error)
    end
end
