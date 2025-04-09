enum ApiType {
  home(0),
  signIn(1),
  qrScan(1),
  signUp(2),
  forgotPassword(3),
  checkScannedCode(4),
  newsCategories(11),
  newsDetail(12),
  changePassword(10),
  signUpScan(17),
  updateProfile(9),
  //Customer
  customerList(13),
  shopDetail(14),
  notificationList(7),
  updateNotification(8),
  //PRODUCTS
  productsList(15),
  productCategory(19),
  productDetail(18),

  // ACCOUNT BALANCE
  depositHistories(5),
  paymentHistories(6),
  addShoppingCart(21),
  removeShoppingCart(23),
  shoppingCart(22),
  accountSettingItem(16);

  const ApiType(this.type);

  final int type;
}
