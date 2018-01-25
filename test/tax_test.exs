defmodule TaxTest do
  use ExUnit.Case
  doctest Tax

  test "calculate tax" do
    products_1 = [%{quantity: 1, name: "book", price: 12.49}, %{quantity: 1, name: "music cd", price: 14.99}, %{quantity: 1, name: "chocolate bar", price: 0.85}]
    Tax.display_tax(products_1)

    products_1 = [%{quantity: 1, name: "imported box of chocolates", price: 10}, %{quantity: 1, name: "imported bottle of perfume", price: 47.50}]
    Tax.display_tax(products_1)

    product_3 =
      [
        %{quantity: 1, name: "imported bottle of perfume", price: 27.99},
        %{quantity: 1, name: "bottle of perfume", price: 18.99},
        %{quantity: 1, name: "packet of headache pills", price: 9.75},
        %{quantity: 1, name: "imported box of chocolates", price: 11.25}
      ]
    Tax.display_tax(product_3)
  end
end
