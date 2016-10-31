defmodule PhoenixGraphql.UserControllerTest do
  use ExUnit.Case
  use PhoenixGraphql.ConnCase

  alias PhoenixGraphql.UserController, as: Sut
  alias PhoenixGraphql.GraphQL.UserDto

  @users ~s([
    {"id":"1", "name":"name 1", "email":"1@mail.com"},
    {"id":"2", "name":"name 2", "email":"2@mail.com"},
    {"id":"3", "name":"name 3", "email":"3@mail.com"}
  ])

  describe "When getting all the users" do
    test "Index returns a list of users" do
      agent_users = Poison.decode!(@users, as: [%UserDto{}])

      user_agent = Stubr.stub!(
        [get: fn() -> agent_users end],
        [module: PhoenixGraphql.UserAgent]
      )

      #actual = Sut.index(build_conn(:get, "users"), nil, user_agent)
      #expected = "hello"

      #assert actual == expected

    end

  end

end
