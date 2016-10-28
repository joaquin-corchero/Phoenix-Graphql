defmodule PhoenixGraphql.GraphQL.PostDtoTest do
  use ExUnit.Case

  alias PhoenixGraphql.GraphQL.PostDto, as: Sut

  describe "When getting all the posts" do
    @postsUrl "http://localhost:4000/posts"

    test "dtos are returned when there are any" do
      json = ~s({"data":[{"title":"1","id":"1","body":"1"},{"title":"2","id":"2","body":"2"}]})

      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: json, headers: nil, status_code: 200} end],
        [module: HTTPoison]
      )

      expected = json
      |> Poison.decode!(as: %{"data" => [%Sut{}]})
      |> Map.fetch!("data")
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == {:ok, expected}
    end

    test "empty list is returned when no posts are found" do
      json = ~s({"data":[]})

      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: json, headers: nil, status_code: 200} end],
        [module: HTTPoison]
      )

      expected = []
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == {:ok, expected}
    end

    test "not found is returned if the url is wrong" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: nil, headers: nil, status_code: 404} end],
        [module: HTTPoison]
      )

      expected = {:error, "Not found"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end

    test "internal server error is returned with 500" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "some error", headers: nil, status_code: 500} end],
        [module: HTTPoison]
      )

      expected = {:error, "Internal server error: some error"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end

    test "error description is returned with any other status code" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "another error", headers: nil, status_code: 501} end],
        [module: HTTPoison]
      )

      expected = {:error, "Something wrong happened: another error"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end
  end

  describe "When finding a post by id" do
    @postsUrl "http://localhost:4000/posts/1"

    test "post is returned when found" do
      json = ~s({"data":{"title":"1","id":"1","body":"1"}})

      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: json, headers: nil, status_code: 200} end],
        [module: HTTPoison]
      )

      expected = json
      |> Poison.decode!(as: %{"data" => %Sut{}})
      |> Map.fetch!("data")
      actual = Sut.find(%{id: "1"}, %{}, http_client)

      assert actual == {:ok, expected}
    end

    test "nil is returned when post not found" do
      json = ~s({"data":null})

      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: json, headers: nil, status_code: 200} end],
        [module: HTTPoison]
      )

      expected = nil
      actual = Sut.find(%{id: "1"}, %{}, http_client)

      assert actual == {:ok, expected}
    end

    test "error with not found when the url is not found" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: nil, headers: nil, status_code: 404} end],
        [module: HTTPoison]
      )

      expected = {:error, "Not found"}
      actual = Sut.find(%{id: "1"}, %{}, http_client)

      assert actual == expected
    end

    test "error with description is returned when internal server error occurs" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "some error", headers: nil, status_code: 500} end],
        [module: HTTPoison]
      )

      expected = {:error, "Internal server error: some error"}
      actual = Sut.find(%{id: "1"}, %{}, http_client)

      assert actual == expected
    end

    test "the error is returned with any other status code" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "another error", headers: nil, status_code: 501} end],
        [module: HTTPoison]
      )

      expected = {:error, "Something wrong happened: another error"}
      actual = Sut.find(%{id: "1"}, %{}, http_client)

      assert actual == expected
    end
  end
end
