
store.controller('ProductsController', ['$scope', '$http', 'ProductsService', 'CartService', function ($scope, $http, ProductsService, CartService) {
  ProductsService.load().success(function () {
    $scope.products = ProductsService.all
  })
}])

store.controller('CartController', ['$scope', '$http', 'ProductsService', 'CartService', function ($scope, $http, ProductsService, CartService) {
  CartService.load().success(function() {
    $scope.cart = CartService.cart
    $scope.total = $scope.cart.reduce(function(a, b) {return a + b})
  })

  $scope.add = function(id, index) {
    $http.get("/plus_quantity/" + id).success( function() {
      $scope.cart[index] += 1
      $scope.total += 1
    })
  }

  $scope.remove = function(id, index) {
    $http.get("/minus_quantity/" + id).success( function() {
      if ($scope.cart[index] > 0) {
        $scope.cart[index] -= 1
        $scope.total -= 1
      }
    })
  }
}])