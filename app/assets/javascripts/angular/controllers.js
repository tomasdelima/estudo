store.controller('ProductsController', ['$scope', '$http', 'ProductsService', function ($scope, $http, ProductsService) {
  ProductsService.load().success(function () {
    $scope.products = ProductsService.all
    $.each($scope.products, function(a, b) {
      b = b || {quantity: 0, price: 0}
      if(!b.quantity) { b.quantity = 0 }
    })

    $scope.totalCount = 0
    $scope.total = 0

    $.each($scope.products, function(a, b) {
      $scope.totalCount += b.quantity
      $scope.total += b.quantity * b.price
    })
  })

  $scope.add = function(id) {
    $http.get("/plus_quantity/" + id).success( function() {
      var cartProduct = _($scope.products).findWhere({id: id})

      if (!cartProduct) {
        cartProduct = {quantity: 0}
      }

      cartProduct.quantity += 1
      cartProduct.total += cartProduct.price
      $scope.totalCount += 1
      $scope.total += cartProduct.price
    })
  }

  $scope.remove = function(id) {
    $http.get("/minus_quantity/" + id).success( function() {
      var cartProduct = _($scope.products).findWhere({id: id})

      if (cartProduct && cartProduct.quantity > 0) {
        cartProduct.quantity -= 1
        cartProduct.total -= cartProduct.price
        $scope.totalCount -= 1
        $scope.total -= cartProduct.price
      }

      if (cartProduct && cartProduct.quantity < 0) {
        cartProduct.total = 0
      }
    })
  }
}])