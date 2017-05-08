defmodule TextApi.ApiController do
  use TextApi.Web, :controller

  alias TextApi.Document
  alias TextApi.Repo



  def index(conn, _params) do
    IO.puts "INDEX"
    IO.puts "conn.query_string #{conn.query_string}"
    query_string = conn.query_string
    if query_string == "" do
      documents = Repo.all(Document)
    else
      documents = Document.find_by_query_string(query_string)
    end
    json conn, documents
  end

  def show(conn, %{"id" => id}) do
    IO.puts "SHOW"
    document = Document.get(id)
    json conn, document
  end

end
