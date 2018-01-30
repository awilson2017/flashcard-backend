require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  let(:user) { users :one }

  it "gets index" do
    get users_url
    value(response).must_be :success?
  end

  it "creates user" do
    expect {
      post users_url, params: { user: { name: user.name, password: user.password, username: user.username } }
    }.must_change "User.count"

    value(response.status).must_equal 201
  end

  it "shows user" do
    get user_url(user)
    value(response).must_be :success?
  end

  it "updates user" do
    patch user_url(user), params: { user: { name: user.name, password: user.password, username: user.username } }
    value(response.status).must_equal 200
  end

  it "destroys user" do
    expect {
      delete user_url(user)
    }.must_change "User.count", -1

    value(response.status).must_equal 204
  end
end
