alias Demo.Repo
alias Demo.Donations.Donation
donation_items = [
  {"☕️", "Coffee"},
  {"🥛", "Milk"},
  {"🥩", "Beef"},
  {"🍗", "Chicken"},
  {"🍖", "Pork"},
  {"🍗", "Turkey"},
  {"🥔", "Potatoes"},
  {"🥣", "Cereal"},
  {"🥣", "Oatmeal"},
  {"🥚", "Eggs"},
  {"🥓", "Bacon"},
  {"🧀", "Cheese"},
  {"🥬", "Lettuce"},
  {"🥒", "Cucumber"},
  {"🐠", "Smoked Salmon"},
  {"🐟", "Tuna"},
  {"🐡", "Halibut"},
  {"🥦", "Broccoli"},
  {"🧅", "Onions"},
  {"🍊", "Oranges"},
  {"🍯", "Honey"},
  {"🍞", "Sourdough Bread"},
  {"🥖", "French Bread"},
  {"🍐", "Pear"},
  {"🥜", "Nuts"},
  {"🍎", "Apples"},
  {"🥥", "Coconut"},
  {"🧈", "Butter"},
  {"🧀", "Mozzarella"},
  {"🍅", "Tomatoes"},
  {"🍄", "Mushrooms"},
  {"🍚", "Rice"},
  {"🍜", "Pasta"},
  {"🍌", "Banana"},
  {"🥕", "Carrots"},
  {"🍋", "Lemons"},
  {"🍉", "Watermelons"},
  {"🍇", "Grapes"},
  {"🍓", "Strawberries"},
  {"🍈", "Melons"},
  {"🍒", "Cherries"},
  {"🍑", "Peaches"},
  {"🍍", "Pineapples"},
  {"🥝", "Kiwis"},
  {"🍆", "Eggplants"},
  {"🥑", "Avocados"},
  {"🌶", "Peppers"},
  {"🌽", "Corn"},
  {"🍠", "Sweet Potatoes"},
  {"🥯", "Bagels"},
  {"🥫", "Soup"},
  {"🍪", "Cookies"}
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



for _i <- 1..100 do
  {emoji, item} = Enum.random(donation_items)

  %Donation{
    emoji: emoji,
    item: item,
    quantity: Enum.random(1..20),
    days_until_expires: Enum.random(1..30)
  }
  |> prepare.(now)
end
|> insert_all.(Donation)
