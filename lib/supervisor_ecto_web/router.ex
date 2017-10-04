defmodule SupervisorEctoWeb.Router do
  use SupervisorEctoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SupervisorEctoWeb do
    pipe_through :api

    # add
    resources "/counts", CountController, except: [:new, :edit]
  end
end
