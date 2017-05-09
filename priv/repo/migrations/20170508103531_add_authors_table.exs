

defmodule TextApi.Repo.Migrations.AddAuthorsTable do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :author, :string
      add :identifier, :string
      add :url, :string
      add :phot_url, :string
      add :blurb, :text

      timestamps
  end

    create unique_index(:authors, [:identifier])
  end

end
