require 'test_helper'

class AccountTemplatesControllerTest < ActionController::TestCase
  setup do
    @account_template = account_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_template" do
    assert_difference('AccountTemplate.count') do
      post :create, account_template: { has_inital: @account_template.has_inital, name: @account_template.name, number: @account_template.number, order: @account_template.order }
    end

    assert_redirected_to account_template_path(assigns(:account_template))
  end

  test "should show account_template" do
    get :show, id: @account_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_template
    assert_response :success
  end

  test "should update account_template" do
    patch :update, id: @account_template, account_template: { has_inital: @account_template.has_inital, name: @account_template.name, number: @account_template.number, order: @account_template.order }
    assert_redirected_to account_template_path(assigns(:account_template))
  end

  test "should destroy account_template" do
    assert_difference('AccountTemplate.count', -1) do
      delete :destroy, id: @account_template
    end

    assert_redirected_to account_templates_path
  end
end
