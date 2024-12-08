alias Demo.PizzaOrders.PizzaOrder
alias Demo.Repo
pizza_toppings = [
  "🍗 Chicken",
  "🌿 Basil",
  "🧄 Garlic",
  "🥓 Bacon",
  "🧀 Cheese",
  "🐠 Salmon",
  "🍤 Shrimp",
  "🥦 Broccoli",
  "🧅 Onions",
  "🍅 Tomatoes",
  "🍄 Mushrooms",
  "🍍 Pineapples",
  "🍆 Eggplants",
  "🥑 Avocados",
  "🌶 Peppers",
  "🍕 Pepperonis"
]

now = DateTime.utc_now() |> DateTime.truncate(:second)

prepare = fn struct, now ->
  struct
  |> Map.from_struct()
  |> Map.drop([:__meta__, :id])
  |> Map.merge(%{inserted_at: now, updated_at: now})
end


insert_all = fn entries, schema ->
  entries
  |> Enum.chunk_every(100)
  |> Enum.map(&(Repo.insert_all(schema, &1) |> elem(0)))
  |> Enum.sum()
end


for _i <- 1..1000 do
  [topping1, topping2] =
    pizza_toppings
    |> Enum.shuffle()
    |> Enum.take(2)

  pizza = "#{Faker.Pizza.size()} #{Faker.Pizza.style()} with
     #{topping1} and #{topping2}"

  %PizzaOrder{
    username: Faker.Internet.user_name(),
    pizza: pizza
  }
  |>prepare.(now)
end
|> insert_all.(PizzaOrder)
