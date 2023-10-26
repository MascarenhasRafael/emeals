class RecipesControllerTest < ActionController::TestCase
  before do
    @recipe = recipes(:one)
  end

  after do
    Recipe.destroy_all
  end

  describe 'GET #index' do
    it 'responds successfully' do
      get :index, format: :json
      assert_response :success
    end
  end

  describe 'POST #create' do
    it 'creates a recipe successfully' do
      assert_difference('Recipe.count') do
        post :create, params: {
          recipe: {
            name: @recipe.name,
            image_path: @recipe.image_path,
            cook_time_in_seconds: @recipe.cook_time_in_seconds,
            prep_time_in_seconds: @recipe.prep_time_in_seconds,
            instructions_attributes: [
              { id: nil, content: 'add milk to a clean pan', _destroy: false }
            ],
            ingredients_attributes: [
                { id: nil, item: 'milk', quantity: 1, measurement_unit: 'liter', _destroy: false },
                { id: nil, item: 'chocolate', quantity: 2, measurement_unit: 'spoons', _destroy: false }
            ]
          }
        }, format: :json
      end

      assert_response :created
    end

    it 'does not create a recipe without name' do
      post :create, params: {
        recipe: {
          cook_time_in_seconds: @recipe.cook_time_in_seconds,
          prep_time_in_seconds: @recipe.prep_time_in_seconds
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['name']
      assert_includes parsed_body['name'], "can't be blank"
    end

    it 'does not create a recipe without cook_time_in_seconds' do
      post :create, params: {
        recipe: {
          name: @recipe.name,
          prep_time_in_seconds: @recipe.prep_time_in_seconds
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['cook_time_in_seconds']
      assert_includes parsed_body['cook_time_in_seconds'], "can't be blank"
    end

    it 'does not create a recipe without prep_time_in_seconds' do
      post :create, params: {
        recipe: {
          name: @recipe.name,
          cook_time_in_seconds: @recipe.cook_time_in_seconds
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['prep_time_in_seconds']
      assert_includes parsed_body['prep_time_in_seconds'], "can't be blank"
    end
  end

  describe 'GET #show' do
    it 'responds successfully' do
      get :show, params: { id: @recipe }, format: :json
      assert_response :success
    end
  end

  describe 'PATCH #update' do
    it 'updates a recipe successfully' do
      patch :update, params: {
        id: @recipe,
        recipe: {
          name: @recipe.name,
          image_path: @recipe.image_path,
          cook_time_in_seconds: @recipe.cook_time_in_seconds,
          prep_time_in_seconds: @recipe.prep_time_in_seconds,
          instructions_attributes: [
              { id: nil, content: 'add milk to a clean pan', _destroy: false }
            ],
            ingredients_attributes: [
                { id: nil, item: 'milk', quantity: 1, measurement_unit: 'liter', _destroy: false },
                { id: nil, item: 'chocolate', quantity: 2, measurement_unit: 'spoons', _destroy: false }
            ]
        }
      }, format: :json

      assert_response :success
    end

    it 'does not update a recipe without name' do
      patch :update, params: {
        id: @recipe,
        recipe: {
          name: nil,
          image_path: @recipe.image_path,
          cook_time_in_seconds: @recipe.cook_time_in_seconds,
          prep_time_in_seconds: @recipe.prep_time_in_seconds
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['name']
      assert_includes parsed_body['name'], "can't be blank"
    end

    it 'does not update a recipe without cook_time_in_seconds' do
      patch :update, params: {
        id: @recipe,
        recipe: {
          name: @recipe.name,
          image_path: @recipe.image_path,
          cook_time_in_seconds: nil,
          prep_time_in_seconds: @recipe.prep_time_in_seconds
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['cook_time_in_seconds']
      assert_includes parsed_body['cook_time_in_seconds'], "can't be blank"
    end

    it 'does not update a recipe without prep_time_in_seconds' do
      patch :update, params: {
        id: @recipe,
        recipe: {
          name: @recipe.name,
          image_path: @recipe.image_path,
          cook_time_in_seconds: @recipe.cook_time_in_seconds,
          prep_time_in_seconds: nil
        }
      }, format: :json

      assert_response :unprocessable_entity
      parsed_body = JSON.parse(response.body)
      assert_not_nil parsed_body['prep_time_in_seconds']
      assert_includes parsed_body['prep_time_in_seconds'], "can't be blank"
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a recipe successfully' do
      assert_difference('Recipe.count', -1) do
        delete :destroy, params: { id: @recipe }, format: :json
      end

      assert_response :no_content
    end
  end
end
