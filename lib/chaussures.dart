import 'package:flutter/material.dart';

class Chaussure {
  final String asset;
  final String name;
  final String completeName;
  final Color color;
  final int price;

  const Chaussure({
    required this.asset,
    required this.name,
    required this.completeName,
    required this.color,
    required this.price,
  });
}

const List<Chaussure> chaussures = [
  Chaussure(
    asset: "images/chaussure_de_running_zoomx_invincible_run_flyknit.png",
    name: "ZoomX Invincible",
    completeName: "Nike ZoomX Invincible run flyknit",
    color: Color(0xffe0f890),
    price: 180,
  ),
  Chaussure(
    asset: "images/chaussure_air_max_90.png",
    name: "Air Max 90",
    completeName: "Nike Air Max 90",
    color: Colors.white,
    price: 120,
  ),
  Chaussure(
    asset: "images/chaussure_de_basketball_cosmic_unity_green_glow.png",
    name: "Cosmic Unity",
    completeName: "Nike Cosmic Unity green glow",
    color: Colors.black,
    price: 150,
  ),
  Chaussure(
    asset: "images/chaussure_crater_impact.png",
    name: "Crater Impact",
    completeName: "Nike Crater Impact",
    color: Color(0xffd4d2b9),
    price: 100,
  ),
];
