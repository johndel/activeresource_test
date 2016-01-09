require 'test_helper'

class TargetsControllerTest < ActionController::TestCase
  setup do
    @target = targets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:targets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create target" do
    assert_difference('Target.count') do
      post :create, target: { comments: @target.comments, distance: @target.distance, is_active: @target.is_active, name: @target.name, rating: @target.rating, severity: @target.severity }
    end

    assert_redirected_to target_path(assigns(:target))
  end

  test "should show target" do
    get :show, id: @target
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @target
    assert_response :success
  end

  test "should update target" do
    patch :update, id: @target, target: { comments: @target.comments, distance: @target.distance, is_active: @target.is_active, name: @target.name, rating: @target.rating, severity: @target.severity }
    assert_redirected_to target_path(assigns(:target))
  end

  test "should destroy target" do
    assert_difference('Target.count', -1) do
      delete :destroy, id: @target
    end

    assert_redirected_to targets_path
  end
end
