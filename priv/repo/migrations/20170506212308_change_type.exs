defmodule TextApi.Repo.Migrations.ChangeType do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      modify :text, :text
    end
  end
end
