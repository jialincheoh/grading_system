require 'test_helper'

class GradersControllerTest < ActionController::TestCase
  setup do
    @grader = graders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:graders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grader" do
    assert_difference('Grader.count') do
      post :create, grader: { email: @grader.email, grader_type: @grader.grader_type, name: @grader.name }
    end

    assert_redirected_to grader_path(assigns(:grader))
  end

  test "should show grader" do
    get :show, id: @grader
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grader
    assert_response :success
  end

  test "should update grader" do
    patch :update, id: @grader, grader: { email: @grader.email, grader_type: @grader.grader_type, name: @grader.name }
    assert_redirected_to grader_path(assigns(:grader))
  end

  test "should destroy grader" do
    assert_difference('Grader.count', -1) do
      delete :destroy, id: @grader
    end

    assert_redirected_to graders_path
  end
end
