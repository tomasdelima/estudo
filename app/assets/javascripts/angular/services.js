store.service('ProductsService', ['$http', function($http) {
  return {
    load: function() {
      var self = this
      return $http.get('/products.json').success(function(data){
        self.all = data
      })
    }
  }
}])

store.service('CartService', ['$http', function($http) {
  return {
    load: function() {
      var self = this
      return $http.get('/carts/set_cart.json').success(function(data) {
        self.cart = data
      })
    }
  }
}])