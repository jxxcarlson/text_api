defmodule TextApi.UserController do
  use TextApi.Web, :controller

  alias TextApi.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => json_string}) do
    IO.puts "json_string"
    IO.inspect(json_string)
    IO.puts "-----------"
    {:ok, user_params} = Poison.Parser.parse json_string
    IO.inspect user_params
    IO.puts "-----------"
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TextApi.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
