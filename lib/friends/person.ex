defmodule Friends.Person do
  use Ecto.Schema

  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :age, :integer, default: 0
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name,:age])
    |> validate_required([:name])
    |> validate_length(:nane, min: 2)
    |> validate_fictional_name()
  end

  def validate_fictional_name(changeset) do
    name = get_field(changeset, :name)
    if name in ["hoge"] do
      changeset
    else
      add_error(changeset, :name, "is not a hoge")
    end
  end

  def set_name_if_anonymous(changeset) do
    name = get_field(changeset, :name)

    if is_nil(name) do
      put_change(changeset, :name, "Anonymous")
    else
      changeset
    end
  end

  def registration_changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> set_name_if_anonymous()
  end
end
