store.controller('ProductsController', ['$scope', '$http', 'ProductsService', 'CartService', function ($scope, $http, ProductsService, CartService) {
  ProductsService.load().success(function () {
    $scope.products = ProductsService.all
    $.each($scope.products, function(a, b) {
      b = b || {quantity: 0, price: 0}
    })
  })
}])

store.controller('CartController', ['$scope', '$http', 'ProductsService', 'CartService', function ($scope, $http, ProductsService, CartService) {
  CartService.load().success(function() {
    $scope.cart = CartService.cart
    $scope.totalCount = 0
    $scope.total = 0
    $.each($scope.cart, function(a, b) {
      $scope.totalCount += b.quantity
      $scope.total += b.quantity * b.price
    })
  })

  $scope.add = function(id, index) {
    $http.get("/plus_quantity/" + id).success( function() {
      if (!$scope.cart[index]) {
        $scope.cart[index] = {quantity: 0}
      }

      $scope.cart[index].quantity += 1
      $scope.cart[index].total += $scope.cart[index].price
      $scope.totalCount += 1
      $scope.total += $scope.cart[index].price
    })
  }

  $scope.remove = function(id, index) {
    $http.get("/minus_quantity/" + id).success( function() {
      if ($scope.cart[index] && $scope.cart[index].quantity > 0) {
        $scope.cart[index].quantity -= 1
        $scope.cart[index].total -= $scope.cart[index].price
        $scope.totalCount -= 1
        $scope.total -= $scope.cart[index].price
      }

      if ($scope.cart[index] && $scope.cart[index].quantity < 0) {
        $scope.cart[index].total = 0
      }
    })
  }
}])