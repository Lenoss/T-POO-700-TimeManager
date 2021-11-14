defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router
  alias Timemanager.Guardian
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TimemanagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  pipeline :GeneralManager do
    plug Timemanager.EnsureRolePlug, :GeneralManager
  end

  scope "/", TimemanagerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", TimemanagerWeb do
    pipe_through :api

    post "/sign_in", UserController, :sign_in
    # post "/log_in"
    scope "/users" do
      post("/", UserController, :create)
    end
  end

  # scope "/api", TimemanagerWeb do
  #   pipe_through [:api, :jwt_authenticated, :GeneralManager]
  #   put("/users/:userID/promote", UserController, :promote)
  # end

  # Other scopes may use custom stacks.
  scope "/api", TimemanagerWeb do
    pipe_through [:api, :jwt_authenticated]
    # resources "/users", UserController
    scope "/users" do
      get("/", UserController, :index)
      get("/:userID", UserController, :show)
      delete("/:userID", UserController, :delete)
      put("/:userID", UserController, :update)
      put("/:userID/promote", UserController, :promote)
    end

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
      put "/:userID", ClockController, :update
    end

    scope "/workingtimes" do
      get "/:user_id", WorkingtimeController, :show
      get "/:user_id/:id", WorkingtimeController, :show
      post "/:user_id", WorkingtimeController, :create
      put "/:id", WorkingtimeController, :update
      delete "/:id", WorkingtimeController, :delete
    end

    scope "/managing" do
      get "/team/:teamId", ManagingController, :show_team
      get "/:userID", ManagingController, :show
    end
    # resources("/workingtimes", WorkingtimeController, only: [:show])
    # resources("/workingtimes/:userID", WorkingtimeController, only: [:create])
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
