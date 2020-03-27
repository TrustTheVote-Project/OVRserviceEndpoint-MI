class ResponseTemplatesController < ApplicationController
  before_action :set_response_template, only: [:show, :edit, :update, :destroy]

  # GET /response_templates
  # GET /response_templates.json
  def index
    @response_templates = ResponseTemplate.all
  end

  # GET /response_templates/1
  # GET /response_templates/1.json
  def show
  end

  # GET /response_templates/new
  def new
    @response_template = ResponseTemplate.new
  end

  # GET /response_templates/1/edit
  def edit
  end

  # POST /response_templates
  # POST /response_templates.json
  def create
    @response_template = ResponseTemplate.new(response_template_params)

    respond_to do |format|
      if @response_template.save
        format.html { redirect_to @response_template, notice: 'Response template was successfully created.' }
        format.json { render :show, status: :created, location: @response_template }
      else
        format.html { render :new }
        format.json { render json: @response_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /response_templates/1
  # PATCH/PUT /response_templates/1.json
  def update
    respond_to do |format|
      if @response_template.update(response_template_params)
        format.html { redirect_to @response_template, notice: 'Response template was successfully updated.' }
        format.json { render :show, status: :ok, location: @response_template }
      else
        format.html { render :edit }
        format.json { render json: @response_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_templates/1
  # DELETE /response_templates/1.json
  def destroy
    @response_template.destroy
    respond_to do |format|
      format.html { redirect_to response_templates_url, notice: 'Response template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_template
      @response_template = ResponseTemplate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_template_params
      params.require(:response_template).permit(:name, :body, :code)
    end
end
