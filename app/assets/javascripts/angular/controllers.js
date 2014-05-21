store.controller('ProductsController', ['$scope', '$http', 'ProductsService', 'CartService', function ($scope, $http, ProductsService, CartService) {
  $scope.products = ProductsService
  $scope.products.load()

  $scope.cart = CartService
  $scope.cart.load()
  .success(function() {
    $scope.total = $scope.cart.cart.reduce(function(a, b) {return a + b})
  })

  $scope.add = function(id, index) {
    $http.get("/plus_quantity/" + id)
    .success(
      function() {$scope.cart.cart[index] += 1
      $scope.total += 1
    })
  }

  $scope.remove = function(id, index) {
    $http.get("/minus_quantity/" + id)
    .success(
      function() {
        if ($scope.cart.cart[index] > 0) {
          $scope.cart.cart[index] -= 1
          $scope.total -= 1
        }
    })
  }
}])