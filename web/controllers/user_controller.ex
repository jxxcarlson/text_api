defmodule TextApi.UserController do

  @moduledoc """

  API.

  Register new user
  =================

  To register a new user send a POST request
  with key "user" and body like this:

     {
       "email" : "foo1@bar.com",
       "password": "s3cr3t",
       "name": "Jeremy Foobar",
       "username": "jfoobar"
     }

  """
  use TextApi.Web, :controller

  alias TextApi.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => payload}) do

    user_params = TextApi.Utility.project2map(payload)
    # { :ok, user_params} = Poison.Parser.parse json_string
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
