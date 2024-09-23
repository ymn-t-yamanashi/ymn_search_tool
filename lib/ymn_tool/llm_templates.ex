defmodule YmnTool.LlmTemplates do
  def get_list(llm_templates) do
    llm_templates
    |> Enum.map(&{&1.key, &1.title})
  end

  def get(llm_templates, q, question_type, key) do
    question = get_question_type(question_type, "について")

    llm_templates
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

  defp get_question_type("", _), do: ""
  defp get_question_type(question_type, statement), do: "#{question_type}#{statement}"
end
