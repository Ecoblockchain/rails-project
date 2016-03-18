require 'test_helper'

class SealsControllerTest < ActionController::TestCase
  setup do
    @seal = seals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seal" do
    assert_difference('Seal.count') do
      post :create, seal: {  }
    end

    assert_redirected_to seal_path(assigns(:seal))
  end

  test "should show seal" do
    get :show, id: @seal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seal
    assert_response :success
  end

  test "should update seal" do
    patch :update, id: @seal, seal: {  }
    assert_redirected_to seal_path(assigns(:seal))
  end

  test "should destroy seal" do
    assert_difference('Seal.count', -1) do
      delete :destroy, id: @seal
    end

    assert_redirected_to seals_path
  end
end
