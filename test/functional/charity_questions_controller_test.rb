require 'test_helper'

class CharityQuestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charity_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charity_question" do
    assert_difference('CharityQuestion.count') do
      post :create, :charity_question => { }
    end

    assert_redirected_to charity_question_path(assigns(:charity_question))
  end

  test "should show charity_question" do
    get :show, :id => charity_questions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => charity_questions(:one).to_param
    assert_response :success
  end

  test "should update charity_question" do
    put :update, :id => charity_questions(:one).to_param, :charity_question => { }
    assert_redirected_to charity_question_path(assigns(:charity_question))
  end

  test "should destroy charity_question" do
    assert_difference('CharityQuestion.count', -1) do
      delete :destroy, :id => charity_questions(:one).to_param
    end

    assert_redirected_to charity_questions_path
  end
end
