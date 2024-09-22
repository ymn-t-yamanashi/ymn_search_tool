defmodule YmnToolWeb.ParlanceComponents do
  @moduledoc """
  用語リストコンポーネント
  """
  use Phoenix.Component

  attr :parlance_list, :list, required: true
  attr :q, :string, required: true

  def parlance(assigns) do
    ~H"""
    <%= for parlance <- @parlance_list do %>
      <% bg = if parlance == @q, do: "bg-cyan-500", else: "bg-cyan-800" %>
      <a
        href="#"
        phx-value-parlance={parlance}
        phx-click="parlance"
        class={"w-80 text-sm rounded-lg " <>  bg  <> " px-2 m-1
          text-white"}
      >
        <%= parlance %>
      </a>
      <br />
    <% end %>
    """
  end
end
