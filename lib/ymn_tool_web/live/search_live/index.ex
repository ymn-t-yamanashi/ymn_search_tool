defmodule YmnToolWeb.SearchLive.Index do
  use YmnToolWeb, :live_view
  alias YmnTool.SearchLink
  alias YmnTool.LlmTemplates

  @question_types [
    {"", "指定なし"},
    {"Elixir", "Elixir"},
    {"JavaScript", "JavaScript"},
    {"tailwindcss", "tailwindcss"}
  ]

  @impl true
  def mount(params, _session, socket) do
    word_list =
      File.read!("q_list.txt")
      |> String.split("\n")

    q = Map.get(params, "q", "")
    question_type = Map.get(params, "question_type", "Elixir")

    socket
    |> assign(q: q)
    |> assign(word_list: word_list)
    |> assign(llm_types: LlmTemplates.get_list())
    |> assign(llm_type: "question")
    |> assign(question_types: @question_types)
    |> assign(question_type: question_type)
    |> assign_links(q, question_type)
    |> assign_prompt(q, question_type, "question")
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_event(
        "change",
        %{"q" => q, "question_type" => question_type, "llm_type" => llm_type},
        socket
      ),
      do: update_links(socket, q, question_type, llm_type)

  def handle_event(
        "submit",
        %{"q" => q, "question_type" => question_type, "llm_type" => llm_type},
        socket
      ),
      do: update_links(socket, q, question_type, llm_type)

  def handle_event("clear-click", _, socket), do: update_links(socket, "", "", "question")

  def handle_event("word", %{"word" => word}, socket),
    do: update_links(socket, word, socket.assigns.question_type, socket.assigns.llm_type)

  defp update_links(socket, q, question_type, llm_type) do
    socket
    |> assign(q: q)
    |> assign(question_type: question_type)
    |> assign_links(q, question_type)
    |> assign_prompt(q, question_type, llm_type)
    |> then(&{:noreply, &1})
  end

  defp assign_links(socket, q, question_type) do
    SearchLink.get(q, question_type)
    |> then(&assign(socket, links: &1))
  end

  defp assign_prompt(socket, q, question_type, llm) do
    LlmTemplates.get(q, question_type, llm)
    |> then(&assign(socket, prompt: &1))
  end
end
