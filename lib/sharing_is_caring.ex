defmodule SharingIsCaring do
  @moduledoc false

  @doc """
  Shares the total_value between the number_of_people as fair as possible
  by only using Int. It should return an [Int] in ascending order.

  ## Examples

      iex> SharingIsCaring.share(4, 0)
      []

      iex> SharingIsCaring.share(0, 4)
      [0, 0, 0, 0]

      iex> SharingIsCaring.share(100, 4)
      [25, 25, 25, 25]

      iex> SharingIsCaring.share(106, 4)
      [26, 26, 27, 27]
  """
  def share(_total_value, number_of_people) when number_of_people <= 0, do: []
  def share(total_value, number_of_people) when total_value <= 0 do
    Enum.map(1..number_of_people, fn _ -> 0 end)
  end
  def share(total_value, number_of_people) do
    val = div(total_value, number_of_people)
    rest = rem(total_value, number_of_people)

    ppl = Enum.reduce(1..number_of_people, [], fn
      _i, acc ->
        [val | acc]
    end)

    if rest > 0 do
      share_rest(ppl, rest)
    else
      ppl
    end
  end

  defp share_rest(people, amount) do
    length = Enum.count(people)

    {_index, ppl} = Enum.reduce(1..amount, {0, people}, fn
      _i, {idx, acc} when idx == length ->
        {0, acc}

      _i, {idx, acc} ->
        new_acc = List.update_at(acc, idx, & &1+1)
        {idx + 1, new_acc}
    end)

    ppl |> Enum.reverse
  end
end
