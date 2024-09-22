defmodule YmnToolWeb.ParlanceComponents do
  @moduledoc """
  用語リストコンポーネント
  """
  use Phoenix.Component

  attr :word_list, :list, required: true
  attr :q, :string, required: true

  def parlance(assigns) do
    ~H"""
    <%= for word <- @word_list do %>
      <% bg = if word == @q, do: "bg-cyan-500", else: "bg-cyan-800" %>
      <a
        href="#"
        phx-value-word={word}
        phx-click="word"
        class={"w-80 text-sm rounded-lg " <>  bg  <> " px-2 m-1
          text-white"}
      >
        <%= word %>
      </a>
      <br />
    <% end %>
    """
  end
end
