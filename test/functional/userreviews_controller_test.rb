require 'test_helper'

class UserreviewsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:userreviews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_userreview
    assert_difference('Userreview.count') do
      post :create, :userreview => { }
    end

    assert_redirected_to userreview_path(assigns(:userreview))
  end

  def test_should_show_userreview
    get :show, :id => userreviews(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => userreviews(:one).id
    assert_response :success
  end

  def test_should_update_userreview
    put :update, :id => userreviews(:one).id, :userreview => { }
    assert_redirected_to userreview_path(assigns(:userreview))
  end

  def test_should_destroy_userreview
    assert_difference('Userreview.count', -1) do
      delete :destroy, :id => userreviews(:one).id
    end

    assert_redirected_to userreviews_path
  end
end
