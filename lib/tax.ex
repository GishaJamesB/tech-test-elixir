defmodule Tax do

  def products do
    # This should be in database in practical case
    status = %{imported: 0, unimported: 1}
    [
      %{category: "food", status: status.imported, name: "imported box of chocolates"},
      %{category: "taxable", status: status.imported, name: "imported bottle of perfume"},
      %{category: "book", status: status.unimported, name: "book"},
      %{category: "medical", status: status.unimported, name: "packet of headache pills"},
      %{category: "taxable", status: status.unimported, name: "music cd"},
      %{category: "food", status: status.unimported, name: "chocolate bar"},
      %{category: "taxable", status: status.unimported, name: "bottle of perfume"}
    ]
  end

  def get_details(name) do
    Enum.filter(Tax.products, fn(product) ->
      Map.get(product, :name) == name
    end)
    |> List.first()
  end

  def calculate_tax(products) do
    tax_exempted = ["food", "book", "medical"]
    tax_rate = 0.1
    import_duty_rate = 0.05

    Enum.map(products, fn(product) ->
      name = Map.get(product, :name)
      product_details = get_details(name)

      if not is_nil(product_details) do
        tax =
          if Enum.member?(tax_exempted, product_details.category) do
            0
          else
            tax_rate * Map.get(product, :price) * Map.get(product, :quantity)
          end

        import_duty =
          if product_details.status == 0 do
            import_duty_rate * Map.get(product, :price) * Map.get(product, :quantity)
          else
            0
          end
          tax = if (is_float(tax + import_duty)), do: Float.round(tax + import_duty, 2), else: tax + import_duty
          %{
            quantity: Map.get(product, :quantity),
            name: Map.get(product, :name),
            price: Map.get(product, :price) * Map.get(product, :quantity),
            final_price: Float.round(Map.get(product, :price) + tax, 2),
            sales_tax: tax
          }
        else
          %{
            quantity: Map.get(product, :quantity),
            name: Map.get(product, :name),
            price: Map.get(product, :price) * Map.get(product, :quantity),
            final_price: Float.round(Map.get(product, :price) * Map.get(product, :quantity), 2),
            sales_tax: 0
          }
      end
    end)
  end

  def display_tax(products) do
    IO.inspect("Input")
    IO.inspect("==============")
    IO.inspect("Quantity, Product, Price")
    Enum.map(products, fn(product) ->
      IO.inspect(to_string(Map.get(product, :quantity)) <> ", " <> Map.get(product, :name) <> ", " <> to_string(Map.get(product, :price)))
    end)
    IO.inspect("==============")
    IO.inspect("Output")
    tax_details = calculate_tax(products)
    Enum.map(tax_details, fn(x) ->
      IO.inspect(to_string(Map.get(x, :quantity)) <> ", " <> Map.get(x, :name) <> ", " <> to_string(Map.get(x, :final_price)))
    end)

    {_any, sales_tax} =
      Enum.map_reduce(tax_details, 0, fn(tx, acc) ->
        {Map.get(tx, :name), Map.get(tx, :sales_tax) + acc}
      end)

    {_any, total} =
      Enum.map_reduce(tax_details, 0, fn(tx, acc) ->
        {Map.get(tx, :name), Map.get(tx, :final_price) + acc}
      end)

    IO.inspect("Sales Taxes " <> to_string(Float.round(sales_tax,2)))
    IO.inspect("Total " <> to_string(Float.round(total, 2)))
  end
end
