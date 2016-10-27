defmodule PhoenixGraphql.PostAgentTest do
  use ExUnit.Case

  alias PhoenixGraphql.PostAgent, as: Sut
  alias PhoenixGraphql.GraphQL.PostDto

  test "agent works" do
    expected = 3
    actual = Enum.count(Sut.get)

    assert actual == expected

    expected = Enum.count(Sut.get) + 1
    Sut.put(%PostDto{id: 100, title: "the title", body: "This is a very long body"} )
    actual = Enum.count(Sut.get)

    assert actual == expected
  end

end
