defmodule Timemanager.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Data` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        country: "some country",
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        role: "some role",
        zipcode: "some zipcode"
      })
      |> Timemanager.Data.create_user()

    user
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-11-02 14:12:00],
        start: ~N[2021-11-02 14:12:00]
      })
      |> Timemanager.Data.create_workingtime()

    workingtime
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-11-02 14:13:00]
      })
      |> Timemanager.Data.create_clock()

    clock
  end
end
