defmodule TextApi.Author do

  alias TextApi.Author
  alias TextApi.Repo

  use TextApi.Web, :model

  schema "authors" do

    field :name, :string
    field :identifier, :string
    field :blurb, :string
    field :url, :string
    field :photo_url, :string

    timestamps
  end

  def with_identifier(query, identifier) do
    from n in query,
      # where: n.identifier == ^identifier
      where: ilike(n.identifier, ^"%#{identifier}%")
  end

  def find_by_query_string(query_string) do
    [cmd|args] = String.split(query_string, "=")
    cond do
      cmd == "author" && args != [] ->
        author_identifier = hd(args)
        TextApi.Author
        |> with_identifier(author_identifier)
        |> Repo.all
    true ->
        []
    end
  end

  def get(id) do
    cond do
      Regex.match?(~r/[1-9][0-9]*/, id) == true ->
        Repo.get(TextApi.Author, String.to_integer(id))
      true ->
        Author |> with_identifier(id) |> Repo.one
    end
  end


end
