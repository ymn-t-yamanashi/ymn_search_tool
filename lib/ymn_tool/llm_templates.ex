defmodule YmnTool.LlmTemplates do
  def get_list do
    [
      {"question", "質問"},
      {"study", "勉強方法"},
      {"intention", "意図"}
    ]
  end

  def get(q, question_type, "question") do
    question = get_question_type(question_type, "について")

    """
    <%= question %>質問。下記を日本語で教えて
    フォーマットは
    1) 概要
    2) 例
    3) 参考になるサイト
    4) 検索キーワード

    知りたいことは下記

    <%= q %>
    """
    |> EEx.eval_string(q: q, question: question)
  end

  def get(q, question_type, "study") do
    """
    #{get_question_type(question_type, "の")}勉強方法を教えて
    フォーマットは
    1) 最短で勉強する方法
    2) 参考になるサイト
    3) 検索キーワード

    知りたいことは下記

    #{q}
    """
  end

  def get(q, _question_type, "intention") do
    """
    私の会社システム会社である

    上長が私に「#{q}」ついて勉強してと言っている
    「#{q}」とはどんな意図で言っている？

    """
  end

  def load(path) do
    File.read!(path)
    |> String.split("##")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&split_header(&1))
    |> IO.inspect()
  end

  defp split_header(data) do
    [header | [contents]] = String.split(data, "|")
    [key | [title]] = String.split(header, ",")

    %{key: key, title: title, contents: contents}
  end

  def get_question_type("", _), do: ""
  def get_question_type(question_type, statement), do: "#{question_type}#{statement}"
end
