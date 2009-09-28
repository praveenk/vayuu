require 'test_helper'

class MiscreviewsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:miscreviews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_miscreviews
    assert_difference('Miscreviews.count') do
      post :create, :miscreviews => { }
    end

    assert_redirected_to miscreviews_path(assigns(:miscreviews))
  end

  def test_should_show_miscreviews
    get :show, :id => miscreviews(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => miscreviews(:one).id
    assert_response :success
  end

  def test_should_update_miscreviews
    put :update, :id => miscreviews(:one).id, :miscreviews => { }
    assert_redirected_to miscreviews_path(assigns(:miscreviews))
  end

  def test_should_destroy_miscreviews
    assert_difference('Miscreviews.count', -1) do
      delete :destroy, :id => miscreviews(:one).id
    end

    assert_redirected_to miscreviews_path
  end
end
