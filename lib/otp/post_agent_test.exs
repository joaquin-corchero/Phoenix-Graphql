defmodule PhoenixGraphql.PostAgentTest do
  use ExUnit.Case, async: true

  alias PhoenixGraphql.PostAgent, as: Sut
  alias PhoenixGraphql.GraphQL.PostDto

  setup do
    {:ok, agent} = Sut.start_link
    {:ok, agent: agent}
  end

  #test "initializes with 3 values" do
  #  expected = 3
  #  actual = Enum.count(Sut.get)

  #  assert actual == expected
  #end

  #test "a new post can be added" do
  #  expected = Enum.count(Sut.get) + 1
  #  Sut.put(%PostDto{id: 100, title: "the title", body: "This is a very long body"} )
  #  actual = Enum.count(Sut.get)

  #  assert actual == expected
  #end

  #test "agent can be stopped" do
  #  stop
  #  assert Sut.get == :error
  #end

  defp stop do
    Sut.stop
  end
end
