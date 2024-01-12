import 'dart:io';
import 'dart:math';

void main() {
  List<Map<String, dynamic>> hardwareStore = [
    {'name': 'RAM', 'price': 50, 'quantity': 10},
    {'name': 'SSD', 'price': 120, 'quantity': 5},
    {'name': 'GraphicsCard', 'price': 200, 'quantity': 8},
    {'name': 'Motherboard', 'price': 80, 'quantity': 12},
    {'name': 'PowerSupply', 'price': 60, 'quantity': 15},
  ];

  Random rannum = Random();
  num money = (rannum.nextInt(5) + 5) * 10000;

  // Calculate the initial sum of quantities
  num sum =
      hardwareStore.map((item) => item['quantity']).reduce((a, b) => a + b);
  List<Map<String, dynamic>> boughtItems = [];

  while (sum > 0) {
    print('\nCOMPUTER SHOP\n');
    print('\nAvailable Items:');

    for (var item in hardwareStore) {
      print(
          "${item['name'].padRight(20)} - \$${item['price'].toString().padLeft(4)} -  Available Quantity ${item['quantity']}");
    }

    stdout.writeln("\nEnter 'exit' to exit.");
    print('\nBalance: \$$money');
    stdout.writeln('Enter the name of the item that you want to buy');
    String itemName = stdin.readLineSync()!.toLowerCase();

    if (itemName == 'exit') {
      if (boughtItems.isEmpty) {
          print("You didn't make any purchases");
      } else {
        print('\nYou bought:');
        num totalSpent = 0;
        for (var item in boughtItems) {
          String name1 = item['name'];
          String quan1 = item['quantity'].toString();
          String itemString = " $quan1 $name1";
          itemString += item['quantity'] > 1 ? 's' : '';
          print(itemString);
          totalSpent += item['totalprice'];
        }
        print("Total spent: $totalSpent");
      }
      print("Remaining Balance: $money");
      break;
    }

    var selectedItem = hardwareStore.firstWhere(
      (element) => element['name'].toString().toLowerCase() == itemName,
      orElse: () =>
          Map<String, dynamic>.from({'name': '', 'price': 0, 'quantity': 0}),
    );

    if (itemName == selectedItem['name'].toString().toLowerCase()) {
      if (selectedItem['quantity'] <= 0) {
        print("\nSorry we're out of ${selectedItem['name']}");
      } else {
        if (selectedItem['price'] <= money) {
          stdout
              .writeln("Enter the quantity (max ${selectedItem['quantity']})");
          String num1 = stdin.readLineSync()!;
          num quantity = int.tryParse(num1) ?? 0;
          if (quantity > 0 && quantity <= selectedItem['quantity']) {
            num totalPrice = selectedItem['price'] * quantity;
            if (totalPrice <= money) {
              money -= totalPrice;
              if (selectedItem['quantity'] <= 0) {
                print("Sorry we're out of ${selectedItem['name']}");
              }
              selectedItem['quantity'] -= quantity;
              sum -= quantity;
              print(sum);
              boughtItems.add({
                'name': itemName,
                'quantity': quantity,
                'totalprice': totalPrice,
              });
              print(
                  "You bought: $quantity ${selectedItem['name']} for \$$totalPrice");
            } else {
              print("You don't have enough money to buy this quantity");
            }
          } else {
            print(
                '\nWe only got ${selectedItem['quantity']} ${selectedItem['name']}');
          }
        } else {
          print('\nInsufficient balance\n');
        }
      }
    } else {
      print("\nItem not available\n");
    }
  }
  if (sum > 0) {
    print('Thanks for shopping');
  } else {

  print("\nSorry, we're out of items");
  print("Come again later");
  print('\nYou bought:');
  num totalSpent = 0;
  for (var item in boughtItems) {
    String name1 = item['name'];
    String quan1 = item['quantity'].toString();
    String itemString = " $quan1 $name1";
    itemString += item['quantity'] > 1 ? 's' : '';
    print(itemString);
    totalSpent += item['totalprice'];
  }
  print("Total spent: $totalSpent");
  print("Remaining Balance: $money");
  }
}
