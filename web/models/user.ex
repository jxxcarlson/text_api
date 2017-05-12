

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
      field :password_hash, :string
      field :password, :string, virtual: true
      field :admin, :boolean
      field :blurb, :string

      timestamps()
    end

    def changeset(model, params \\ :empty) do
        model
        |> cast(params, ~w(email), [])
        |> validate_length(:email, min: 1, max: 255)
        |> validate_format(:email, ~r/@/)
      end

      def registration_changeset(model, params \\ :empty) do
        model
        |> changeset(params)
        |> cast(params, ~w(password), [])
        |> validate_length(:password, min: 6)
        |> put_password_hash
      end

      defp put_password_hash(changeset) do
        case changeset do
          %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
            put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
          _ ->
            changeset
        end
      end

  # def change_password(user, password) do
  #   password_hash = Comeonin.Bcrypt.hashpwsalt(password)
  #   params = %{"password_hash" => password_hash}
  #   changeset = password_changeset(user, params)
  #   Repo.update(changeset)
  # end
  #
  # def find_by_username(username) do
  #   Repo.one(from u in User, where: u.username == ^username)
  #  end
  #
  # def update_user(user,params) do
  #    changeset = User.running_changeset(user, params)
  #     Repo.update(changeset)
  # end
  #
  # def set_admin(user, value) do
  #    params = %{"admin" => value}
  #    changeset = User.admin_changeset(user, params)
  #    Repo.update(changeset)
  # end
  #
  # def set_name(user, value) do
  #   params = %{"name" => value}
  #   changeset = User.changeset(user, params)
  #   Repo.update(changeset)
  # end
  #
  # def delete_by_id(id) do
  #   user = User |> Repo.get(id)
  #   Repo.delete!(user)
  # end



   # def apply_to_users(ff) do
   #  User |> Repo.all |> Enum.map(fn(user) -> ff(user) end)
   # end

  end
