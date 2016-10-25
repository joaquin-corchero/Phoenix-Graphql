defmodule PhoenixGraphql.GraphQL.PostDtoTest do
  use ExUnit.Case

  alias PhoenixGraphql.GraphQL.PostDto, as: Sut

  describe "PostDto.resolve/2" do
    test "Returns dtos struct from source" do
      json = ~s([
        {"id":"1","title":"1", "body":"1"},
        {"id":"2","title":"2", "body":"2"},
        {"id":"3","title":"3", "body":"3"}
      ])

      url = "http://localhost:4000/posts"
      http_client = Stubr.stub!(
        [get!: fn(url) -> json end],
        [module: HTTPoison]
      )
      expected = {:ok, Poison.decode!(json, as: [%Sut{}])}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end
  end
end
