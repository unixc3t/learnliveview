defmodule DemoWeb.TopSecretLive do
  use DemoWeb, :live_view


  def mount(_params, session, socket)do
    {:ok, assign_current_user(socket, session)}
  end


end
