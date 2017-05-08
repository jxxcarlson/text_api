defmodule TextApi.Repo.Migrations.AddAuthorIdentifier do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :author_identifier, :string
    end
  end
end
