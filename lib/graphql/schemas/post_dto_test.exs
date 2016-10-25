defmodule PhoenixGraphql.GraphQL.Schemas.PostDtoTest do
  use ExUnit.Case

  alias PhoenixGraphql.GraphQL.Schemas.PostDto, as: Sut

  describe "PostDto.resolve/2" do
    test "Returns dtos struct with default request" do
      expected = {:ok, %Sut{}}
      actual = Sut.resolve(%{}, %{})
      assert actual == expected
    end
  end
end
