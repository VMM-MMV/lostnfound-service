
defmodule MyappWeb.Token do
  use Joken.Config

  def token_config do
    default_claims()
  end
end
