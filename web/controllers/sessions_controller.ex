# web/controllers/session_controller.ex
defmodule TextApi.SessionController do
  use TextApi.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias TextApi.User
  alias TextApi.Session

  def create(conn, %{"user" => payload}) do
    user_params = TextApi.Utility.project2map(payload)
    user = Repo.get_by(User, email: user_params["email"])
    IO.puts "USER_ID for #{user.username} = #{user.id}"
    cond do
      user && checkpw(user_params["password"], user.password_hash) ->
        session_changeset = Session.create_changeset(%Session{}, %{user_id: user.id})
        {:ok, session} = Repo.insert(session_changeset)
        conn
        |> put_status(:created)
        |> render("show.json", session: session)
      user ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
      true ->
        dummy_checkpw()
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
    end
  end
end
