defmodule BankAccount do
  use Agent

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Task.start_link(fn -> loop(%{balance: 0, closed: false}) end)
    account
  end

  @spec loop(map()) :: no_return()
  defp loop(account) when account.closed do
    receive do
      {_, caller} ->
        send(caller, {:error, :account_closed})
        loop(account)

      {_, _, caller} ->
        send(caller, {:error, :account_closed})
        loop(account)
    end
  end

  defp loop(account) do
    receive do
      {:balance, caller} ->
        send(caller, {:ok, account.balance})
        loop(account)

      {:update, amount, caller} ->
        send(caller, {:ok})
        loop(Map.put(account, :balance, account.balance + amount))

      {:close} ->
        loop(Map.put(account, :closed, true))
    end
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: any
  def close_bank(account) do
    send(account, {:close})
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    send(account, {:balance, self()})

    receive do
      {:ok, balance} -> balance
      {:error, message} -> {:error, message}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    send(account, {:update, amount, self()})

    receive do
      {:ok} -> :ok
      {:error, message} -> {:error, message}
    end
  end
end
