defmodule TextApi.AuthorController do
  use TextApi.Web, :controller

  alias TextApi.Author
  alias TextApi.Repo


  def index(conn, _params) do
    query_string = conn.query_string
    if query_string == "" || query_string == "author=all" do
      authors = Repo.all(Author)
    else
      authors = Author.find_by_query_string(query_string)
    end
    json conn, %{authors: authors}
  end

  def show(conn, %{"id" => id}) do
    author = Author.get(id)
    json conn, %{author: author}
  end

end
