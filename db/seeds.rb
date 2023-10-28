Car.delete_all

Car.create([
    {
      id: 1,
      name: "Car 1",
      description: "This is a description for Car 1",
      deposit: 1000,
      finance_fee: 200,
      option_to_purchase_fee: 300,
      total_amount_payable: 1500,
      duration: 12,
      removed: false,
      image: "image_url_1"
    },
    {
        id: 2,
        name: "Car 2",
        description: "This is a description for Car 2",
        deposit: 2000,
        finance_fee: 200,
        option_to_purchase_fee: 300,
        total_amount_payable: 1500,
        duration: 12,
        removed: false,
        image: "image_url_2"
      },
])