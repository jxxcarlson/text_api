defmodule TextApi.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :admin, :boolean
      add :blurb, :string

      timestamps()
  end

    create unique_index(:users, [:email])
  end
end
