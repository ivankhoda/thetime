require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'login with invalid information' do
    get login_path
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not render.empty?
  end
end
