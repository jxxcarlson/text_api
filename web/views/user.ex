defmodule TextApi.UserView do
  use TextApi.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, TextApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end

defmodule TextApi.ChangesetView do
  use TextApi.Web, :view

  @doc """
  Traverses and translates changeset errors.
  See `Ecto.Changeset.traverse_errors/2` and
  `TodoApi.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: translate_errors(changeset)}
  end
end
