require 'test_helper'

class SponsorQuestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsor_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsor_question" do
    assert_difference('SponsorQuestion.count') do
      post :create, :sponsor_question => { }
    end

    assert_redirected_to sponsor_question_path(assigns(:sponsor_question))
  end

  test "should show sponsor_question" do
    get :show, :id => sponsor_questions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sponsor_questions(:one).to_param
    assert_response :success
  end

  test "should update sponsor_question" do
    put :update, :id => sponsor_questions(:one).to_param, :sponsor_question => { }
    assert_redirected_to sponsor_question_path(assigns(:sponsor_question))
  end

  test "should destroy sponsor_question" do
    assert_difference('SponsorQuestion.count', -1) do
      delete :destroy, :id => sponsor_questions(:one).to_param
    end

    assert_redirected_to sponsor_questions_path
  end
end
