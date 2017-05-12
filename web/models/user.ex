

defmodule TextApi.User do
  use TextApi.Web, :model

  use Ecto.Schema

  # https://blog.codeship.com/ridiculously-fast-api-authentication-with-phoenix/
  # https://blog.codeship.com/refactoring-faster-can-spell-phoenix/

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
        |> cast(params, ~w(email name username))
        |> validate_required([:email, :name, :username])
        |> validate_length(:email, min: 1, max: 255)
        |> validate_format(:email, ~r/@/)
      end

      def registration_changeset(model, params \\ :empty) do
        model
        |> changeset(params)
        |> cast(params, ~w(password))
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

  end
