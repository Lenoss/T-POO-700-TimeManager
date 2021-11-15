defmodule Timemanager.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Timemanager,
  module: Timemanager.Guardian,
  error_handler: Timemanager.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
