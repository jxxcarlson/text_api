defmodule TextApi.DocumentView do
  use TextApi.Web, :view

  def render("show.json", %{document: document}) do
    render_one(document, TextApi.DocumentView, "document.json")
  end

  def render("document.json", %{document: document}) do
    %{document: document}
  end

  def render("error.json", _anything) do
    %{errors: "Something happened"}
  end
end
