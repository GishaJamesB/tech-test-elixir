# Sales Tax Calculation

**TECH TEST in Elixir**

[Question](https://github.com/GishaJamesB/tech-test-elixir/blob/master/question.txt)

## How to test

```
git clone https://github.com/GishaJamesB/tech-test-elixir
cd tech-test-elixir
mix test
```

## How to test with new values

```
iex -S mix
product =
      [
        %{quantity: 1, name: "imported bottle of perfume", price: 27.99},
        %{quantity: 1, name: "bottle of perfume", price: 18.99},
        %{quantity: 1, name: "packet of headache pills", price: 9.75},
        %{quantity: 1, name: "imported box of chocolates", price: 11.25}
      ]
Tax.display_tax(product)
```

Currently you would be able to test these products only

```
imported box of chocolates
imported bottle of perfume
book
packet of headache pills
music cd
chocolate bar
bottle of perfume
```

But in real applications, you can save the products in a database , categorise it , update the product list etc.
