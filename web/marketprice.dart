import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

/**
 * Display market price element.
 */
@CustomTag('market-price')
class MarketPrice extends PolymerElement {
  final double TROY_OUNCE = 31.1034768; // 1 troy ounce = 31.1034768 grams
  final String JSON_LBMA = 'price_lbma.json';
  final String JSON_TANAKA = 'price_tanaka.json';
//  @published String lbma, tanaka;

  MarketPrice.created() : super.created() {
    retrivePriceFromJSON(JSON_LBMA);
    retrivePriceFromJSON(JSON_TANAKA);
  }

  Future retrivePriceFromJSON(String path) {
    return HttpRequest.getString(path).then(createPriceList);
  }
  
  void createPriceList(String jsonString) {
    Map price = JSON.decode(jsonString);
    String htmlString;
 
    htmlString = '<strong>' + price['source'] + '</strong><table><thead><tr><th>' + price['date'] + '</th><th>' 
        + price['currency'] + ' / ' + price['unit'] + '</th></tr></thead><tbody>';
     for (var metal in price['metals']) {
       htmlString += '<tr><td>' + metal['name'] + '</td><td>' + metal['price'] + '</td></tr>';
     }
     htmlString += '</tbody></table>';
     appendPriceTable(htmlString);
  }
  
  void appendPriceTable(String s) {
    shadowRoot.querySelector("#price-list").appendHtml(s);    
  }
}

