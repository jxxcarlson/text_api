

defmodule TextApi.User do
  use TextApi.Web, :model

  use Ecto.Schema
  import Ecto.Query

  alias TextApi.Repo
  alias TextApi.User

  schema "users" do
      field :name, :string
      field :username, :string
      field :email, :string
      field :password, :string
      field :password_hash, :string
      field :admin, :boolean
      field :blurb, :string

      timestamps()
    end

  def running_changeset(model, params \\ :empty) do
      model
      |> cast(params, ~w(public blurb tags public_tags read_only number_of_searches search_filter channel), [] )
  end

  def password_changeset(model, params \\ :empty) do
        model
        |> cast(params, ~w(password_hash), [] )
    end

  def admin_changeset(model, params \\ :empty) do
        model
        |> cast(params, ~w(admin), [] )
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username email password registration_code channel), [] )
    |> validate_length(:username, min: 1, max: 20)
    |> validate_inclusion(:registration_code, ["student", "ladidah", "uahs"])
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
    |> erase_password()
    # |> set_read_only(false)
  end

  def change_password(user, password) do
    password_hash = Comeonin.Bcrypt.hashpwsalt(password)
    params = %{"password_hash" => password_hash}
    changeset = password_changeset(user, params)
    Repo.update(changeset)
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  def erase_password(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
          put_change(changeset, :password, "")
        _ ->
          changeset
      end
  end

  def find_by_username(username) do
    Repo.one(from u in User, where: u.username == ^username)
   end

  def update_user(user,params) do
     changeset = User.running_changeset(user, params)
      Repo.update(changeset)
  end

  def set_admin(user, value) do
     params = %{"admin" => value}
     changeset = User.admin_changeset(user, params)
     Repo.update(changeset)
  end

  def set_name(user, value) do
    params = %{"name" => value}
    changeset = User.changeset(user, params)
    Repo.update(changeset)
  end

  def delete_by_id(id) do
    user = User |> Repo.get(id)
    Repo.delete!(user)
  end



   # def apply_to_users(ff) do
   #  User |> Repo.all |> Enum.map(fn(user) -> ff(user) end)
   # end

  end
