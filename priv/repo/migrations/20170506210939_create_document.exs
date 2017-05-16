defmodule TextApi.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string
      add :author, :string
      add :text, :text
      add :identifier, :string

      timestamps
  end

    create unique_index(:documents, [:identifier])
  end

end
