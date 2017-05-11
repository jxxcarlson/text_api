defmodule TextApi.Router do
  use TextApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

# origin: "http://localhost:5000",
  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:5000", "https://elm-docviewer.herokuapp.com"]
    plug :accepts, ["json"]
  end

  scope "/", TextApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", TextApi do
    pipe_through :api
    get "/documents", DocumentApiController, :index
    get "/documents/:id", DocumentApiController, :show
    get "/authors", AuthorApiController, :index
    get "/authors/:id", AuthorApiController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", TextApi do
  #   pipe_through :api
  # end
end
