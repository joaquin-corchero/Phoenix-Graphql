defmodule PhoenixGraphql.GraphQL.PostDtoTest do
  use ExUnit.Case

  alias PhoenixGraphql.GraphQL.PostDto, as: Sut

  describe "PostDto.resolve/2" do
    test "Returns dtos struct from source" do
      json = ~s({"data":[{"title":"1","id":"1","body":"1"},{"title":"2","id":"2","body":"2"},{"title":"3","id":"3","body":"3"}]})

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
