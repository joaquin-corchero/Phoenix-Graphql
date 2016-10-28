defmodule PhoenixGraphql.GraphQL.PostDtoTest do
  use ExUnit.Case

  alias PhoenixGraphql.GraphQL.PostDto, as: Sut

  describe "Getting all the posts" do
    @postsUrl "http://localhost:4000/posts"

    test "Returns dtos struct from source when 200 returned" do
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

    test "Returns error when 404 status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: nil, headers: nil, status_code: 404} end],
        [module: HTTPoison]
      )

      expected = {:error, "Not found"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end

    test "Returns error when 500 status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "some error", headers: nil, status_code: 500} end],
        [module: HTTPoison]
      )

      expected = {:error, "Internal server error: some error"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end

    test "Returns error when other status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "another error", headers: nil, status_code: 501} end],
        [module: HTTPoison]
      )

      expected = {:error, "Something wrong happened: another error"}
      actual = Sut.resolve(%{}, %{}, http_client)

      assert actual == expected
    end
  end

  describe "Finding a post by id" do
    @postsUrl "http://localhost:4000/posts/1"

    test "Returns dto struct from source when 200 returned" do
      json = ~s({"data":{"title":"1","id":"1","body":"1"}})

      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: json, headers: nil, status_code: 200} end],
        [module: HTTPoison]
      )

      expected = json
      |> Poison.decode!(as: %{"data" => %Sut{}})
      |> Map.fetch!("data")
      actual = Sut.find("1", http_client)

      assert actual == {:ok, expected}
    end

    test "Returns error when 404 status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: nil, headers: nil, status_code: 404} end],
        [module: HTTPoison]
      )

      expected = {:error, "Not found"}
      actual = Sut.find("1", http_client)

      assert actual == expected
    end

    test "Returns error when 500 status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "some error", headers: nil, status_code: 500} end],
        [module: HTTPoison]
      )

      expected = {:error, "Internal server error: some error"}
      actual = Sut.find("1", http_client)

      assert actual == expected
    end

    test "Returns error when other status returned" do
      http_client = Stubr.stub!(
        [get!: fn(@postsUrl) -> %{body: "another error", headers: nil, status_code: 501} end],
        [module: HTTPoison]
      )

      expected = {:error, "Something wrong happened: another error"}
      actual = Sut.find("1", http_client)

      assert actual == expected
    end
  end
end
