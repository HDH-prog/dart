import 'dart:io';

// 상품 클래스
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// 쇼핑몰 클래스
class ShoppingMall {
  List<Product> products = [];
  Map<String, int> cart = {};
  int totalPrice = 0;

  ShoppingMall() {
    products = [
      Product('셔츠', 45000),
      Product('원피스', 30000),
      Product('반팔티', 35000),
      Product('반바지', 38000),
      Product('양말', 5000),
    ];
  }

  void showProducts() {
    print('\n--- 판매중인 상품 목록 ---');
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart(String name, int quantity) {
    // 1. 상품 찾기
    Product? foundProduct;
    for (var product in products) {
      if (product.name == name) {
        foundProduct = product;
        break;
      }
    }

    // 2. 유효성 검사
    if (foundProduct == null) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    if (quantity <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      return;
    }

    // 3. 장바구니에 담기
    if (cart.containsKey(name)) {
      cart[name] = cart[name]! + quantity;
    } else {
      cart[name] = quantity;
    }

    // 4. 총 가격 누적
    totalPrice += foundProduct.price * quantity;
    print('장바구니에 상품이 담겼어요!');
  }

  void showTotal() {
    print('장바구니에 ${totalPrice}원 어치를 담으셨네요!');
  }
}

// main 함수
void main() {
  ShoppingMall mall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print('\n무엇을 하시겠습니까?');
    print('1: 상품 목록 보기');
    print('2: 상품 장바구니에 담기');
    print('3: 장바구니 총 가격 보기');
    print('4: 종료');
    stdout.write('번호 입력: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProducts();
        break;

      case '2':
        stdout.write('상품 이름 입력: ');
        String? name = stdin.readLineSync();

        stdout.write('수량 입력: ');
        String? quantityInput = stdin.readLineSync();
        int? quantity = int.tryParse(quantityInput ?? '');

        if (name == null || quantity == null) {
          print('입력값이 올바르지 않아요!');
        } else {
          mall.addToCart(name, quantity);
        }
        break;

      case '3':
        mall.showTotal();
        break;

      case '4':
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
        isRunning = false;
        break;

      default:
        print('지원하지 않는 기능입니다! 다시 시도해 주세요.');
    }
  }
}
