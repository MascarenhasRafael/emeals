class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show json_ld update destroy ]

  has_scope :ordered_by_name, type: :boolean, default: false
  has_scope :ordered_by_date_edited, type: :boolean, default: false

  # GET /recipes
  def index
    @recipes = apply_scopes(Recipe).all

    render json: @recipes, each_serializer: RecipeSerializer
  end

  # GET /recipes/1
  def show
    render json: @recipe, serializer: RecipeSerializer
  end

  # GET /recipes/1/json_ld
  def json_ld
    json_ld_data = JsonLd::RecipeSerializer.new(@recipe).to_json

    send_data(
      json_ld_data,
      filename: "recipe_#{@recipe.id}_json_ld.json",
      type: 'application/json',
      disposition: 'attachment'
    )
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, serializer: RecipeSerializer, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe, serializer: RecipeSerializer
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(
        :name,
        :image_path,
        :cook_time_in_seconds,
        :prep_time_in_seconds,
        instructions_attributes: [:id, :content, :_destroy],
        ingredients_attributes: [:id, :item, :quantity, :measurement_unit, :_destroy]
      )
    end
end
