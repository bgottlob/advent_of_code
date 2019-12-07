defmodule Password do
  # Part 1 implementation
  def valid_1?(password) when is_integer(password) do
    valid_1?(Integer.to_string(password))
  end

  def valid_1?(password) do
    case six_digits?(password) && adj_digits?(password) && inc_digits?(password) do
      true -> true
      _    -> false
    end
  end

  # Part 2 implementation
  def valid?(password) when is_integer(password) do
    valid?(Integer.to_string(password))
  end

  def valid?(password) do
    case six_digits?(password) && adj_digits_no_grp?(password) && inc_digits?(password) do
      true -> true
      _    -> false
    end
  end

  defp six_digits?(str), do: String.length(str) == 6

  # Check if there are two adjacent digits
  defp adj_digits?(str) when is_binary(str) do
    adj_digits?(String.to_charlist(str))
  end

  defp adj_digits?([]), do: false
  defp adj_digits?([x, x | _ ]), do: true
  defp adj_digits?([ _ | rest ]), do: adj_digits?(rest)

  defp adj_digits_no_grp?(str) when is_binary(str) do
    adj_digits_no_grp?(String.to_charlist(str))
  end

  # Didn't find exactly two adjacent digits
  defp adj_digits_no_grp?([]), do: false
  # Found two adjacent digits at the end
  defp adj_digits_no_grp?([x, x]), do: true
  defp adj_digits_no_grp?([x, x, x | rest]) do
    # Eat the rest of the group
    adj_digits_no_grp?(Enum.drop_while(rest, &(&1 == x)))
  end
  # Found two adjacent digits in the middle that are not part of a larger group
  defp adj_digits_no_grp?([x, x, y | _ ]) when x != y, do: true
  # No match, go to the next digit
  defp adj_digits_no_grp?([ _ | rest ]), do: adj_digits_no_grp?(rest)

  def inc_digits?(str) when is_binary(str) do
    str
    |> String.split("", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> inc_digits?()
  end

  def inc_digits?([_]), do: true
  def inc_digits?(digits = [x, y | _]) when x <= y, do: inc_digits?(tl(digits))
  def inc_digits?(_), do: false
end
