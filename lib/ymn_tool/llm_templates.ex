defmodule YmnTool.LlmTemplates do
  def get_list do
    [
      {"question", "質問"},
      {"study", "勉強方法"}
    ]
  end

  def get(q, question_type, "question") do
    """
    #{get_question_type(question_type, "について")}質問。下記を日本語で教えて
    フォーマットは
    1) 概要
    2) 例
    3) 参考になるサイト
    4) 検索キーワード

    知りたいことは下記

    #{q}
    """
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

  def get_question_type("", _), do: ""
  def get_question_type(question_type, statement), do: "#{question_type}#{statement}"
end
