defmodule TextApi.Document do

  alias TextApi.Document
  alias TextApi.Repo

  use TextApi.Web, :model

  schema "documents" do

    field :author, :string
    field :title, :string
    field :text, :string
    field :identifier, :string
    field :author_identifier, :string

    timestamps
  end

  def with_author(query, author_identifier) do
    from n in query,
      where: n.author_identifier == ^author_identifier
  end

  def with_identifier(query, identifier) do
    from n in query,
      where: n.identifier == ^identifier
  end

  def find_by_query_string(query_string) do
    [cmd|args] = String.split(query_string, "=")
    cond do
      cmd == "author" && args != [] ->
        author_identifier = hd(args)
        Document
        |> with_author(author_identifier)
        |> Repo.all
    true ->
        []
    end
  end

  def get(id) do
        IO.puts "1. HERE I AM!"
    cond do
      Regex.match?(~r/[1-9][0-9]*/, id) == true ->
        Repo.get(TextApi.Document, String.to_integer(id))
      true ->
        Document |> with_identifier(id) |> Repo.one
    end
  end


end
