defmodule YmnTool.LlmTemplates do
  def get_list do
    load("llm_templates.txt")
    |> Enum.map(&{&1.key, &1.title})
  end

  def get(q, question_type, key) do
    question = get_question_type(question_type, "について")

    load("llm_templates.txt")
    |> Enum.filter(&(&1.key == key))
    |> List.first()
    |> Map.get(:contents)
    |> EEx.eval_string(q: q, question: question)
  end

  def load(path) do
    File.read!(path)
    |> String.split("##")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&split_header(&1))
  end

  defp split_header(data) do
    [header | [contents]] = String.split(data, "|")
    [key | [title]] = String.split(header, ",")

    %{key: key, title: title, contents: contents}
  end

  def get_question_type("", _), do: ""
  def get_question_type(question_type, statement), do: "#{question_type}#{statement}"
end
