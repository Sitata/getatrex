defmodule Getatrex.Writer do
  @moduledoc """
  Module responsible for writing translations to a file
  Usage:
    1. Start the generic server by Getatrex.Writer.start_link(filename)
      where the filename if the name of the file you are going to write data
    2. Send messages to server with payload you need to write to a file:
      Getatrex.Writer.write(payload)
      where payload could be simple string or %Getatrex.Message{} struct
  """
  use GenServer

  def start_link(filename) do
    GenServer.start_link(__MODULE__, %{filename: filename, file_pointer: File.open!(filename, [:write])}, name: __MODULE__)
  end

  def init(state) do

    {:ok, state}
  end

  @doc """
  Write translated struct to disctionary
  adds new line in the beginning of the struct
  """
  def write(%Getatrex.Message{} = message) do
    :ok = GenServer.call(__MODULE__, {:write, message})
  end

  def write(line) do
    :ok = GenServer.call(__MODULE__, {:write, line})
  end

  def handle_call({:write, %Getatrex.Message{} = message}, _from, state) do
    message = [
      "",
      message.mentions |> Enum.join("\n"),
      ~s(msgid "#{message.msgid}"),
      ~s(msgstr "#{message.msgstr}")
    ]
    |> Enum.join("\n")

    {:reply, File.write(state[:filename], message), state}
  end

  def handle_call({:write, line}, _from, state) do
    {:reply, IO.write(state[:file_pointer], "#{String.trim(line)}\n"), state}
  end

end
