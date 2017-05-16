# web/views/session_view.ex
defmodule TextApi.SessionView do
  use TextApi.Web, :view

  def render("show.json", %{session: session}) do
    # %{data: render_one(session, TextApi.SessionView, "session.json")}
    render_one(session, TextApi.SessionView, "session.json")   
  end

  def render("session.json", %{session: session}) do
    %{token: session.token}
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("error.json", %{message: message}) do
    IO.puts "ERROR 1234, message = #{message}"
    %{error: message}
  end
end
