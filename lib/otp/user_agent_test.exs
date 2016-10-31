defmodule PhoenixGraphql.UserAgentTest do
  use ExUnit.Case

  alias PhoenixGraphql.UserAgent, as: Sut
  alias PhoenixGraphql.GraphQL.PostDto

  describe "PhoenixGraphql.UserAgent starts" do
    test "Has default users" do
      expected = 3
      actual = Enum.count(Sut.get)

      assert actual == expected
    end
  end

  describe "UserAgent when finding a user" do

    test "An existing user can be returned" do
      expected = "2"

      actual = Sut.find(expected)

      assert actual.id == expected
    end

    test "If the id can't be found nil is returned" do
      actual = Sut.find("something")

      assert actual == nil
    end
  end

end
