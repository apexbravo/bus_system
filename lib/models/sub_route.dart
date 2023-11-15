class SubRoute {
  String routeId;
  String pointA;
  String pointB;
  double? fee;
  bool flexPricing;
  double? maxFee;
  double? minFee;

  SubRoute({
    required this.routeId,
    required this.pointA,
    required this.pointB,
    this.fee,
    this.flexPricing = false,
    this.maxFee,
    this.minFee,
  });
}
