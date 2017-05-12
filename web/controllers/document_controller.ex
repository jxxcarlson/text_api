defmodule TextApi.DocumentController do
  use TextApi.Web, :controller

  alias TextApi.Document
  alias TextApi.Repo



  def index(conn, _params) do
    query_string = conn.query_string
    if query_string == "" do
      documents = Repo.all(Document)
    else
      documents = Document.find_by_query_string(query_string)
    end
    document_count = Enum.count(documents)
    json conn, %{"documents": documents}
  end

  def show(conn, %{"id" => id}) do
    document = Document.get(id)
    json conn, %{"document": document}
  end

  def create(conn, %{"document" => payload}) do
    document_params = TextApi.Utility.project2map(payload)
    IO.puts "============="
    IO.inspect document_params
    IO.puts "============="
    changeset = Document.create_document_changeset(Document, document_params)
    case Repo.insert(changeset) do
      {:ok, document} ->
        conn
        |> put_status(:created)
        |> render("show.json", document: document)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TextApi.ChangesetView, "error.json", changeset: changeset)
    end
  end


end
