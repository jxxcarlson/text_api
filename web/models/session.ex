defmodule TextApi.Session do
  use TextApi.Web, :model

  alias TextApi.User
  alias TextApi.Repo


  schema "sessions" do
    field :token, :string
    belongs_to :user, TextApi.User

    timestamps
  end

  @required_fields ~w(user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  def find_by_token(query, token) do
    from u in query,
      where: u.token == ^token
  end

  def get_by_token(token) do
    hits = TextApi.Session |> find_by_token(token) |> TextApi.Repo.all
    if hits == [] do
      nil
    else
      hd(hits)
    end
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> validate_required([:user_id])
    # |> cast(params, @required_fields, @optional_fields)
  end

  def create_changeset(model, params \\ :empty) do
    user_id = params.user_id
    user = TextApi.Repo.get!(TextApi.User, user_id)
    if user != nil do
      username = user.username
    else
      username = ""
    end
    model
    |> changeset(params)
    |> put_change(:token, TextApi.Token.get(user_id, username))
  end

  def create_changeset(model, params, token) do
    model
    |> changeset(params)
    |> put_change(:token, token)
  end

 def create_changeset2(model, token) do
    model
    |> changeset(%{})
    |> put_change(:token, token)
  end

  def create_session(user) do
    session_changeset = create_changeset(user, %{user_id: user.id})
    Repo.insert(session_changeset)
  end
end
