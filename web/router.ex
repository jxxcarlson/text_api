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
    plug :accepts, ["json"]
  end

  scope "/", TextApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", TextApi do
    pipe_through :api

    resources "/documents", DocumentController
    resources "/authors", AuthorController

    resources "/sessions", SessionController, only: [:create]
    resources "/users", UserController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TextApi do
  #   pipe_through :api
  # end
end
