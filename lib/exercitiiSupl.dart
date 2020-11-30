//
//

void main() {

  final List<String> listaStringi = <String>[];
  listaStringi.add("v1");
  listaStringi.add("v2");
  listaStringi.add("v3");
  print(listaStringi);

  final List<int> listaInti = <int>[0,1,2,3,77,72,74].where((int element) => element%2== 0).toList();
  print(listaInti);

  List<int> listaInti2 = <int>[88,66,44,33];
  listaInti2.add(1);
  listaInti2.add(2);
  listaInti2.add(3);
  listaInti2.add(77);
  listaInti2.add(72);
  List<int> listaInti2Spatiu= listaInti2.where((int e) => (e%2==0)).toList();
  print(listaInti2Spatiu);



  final  List numere = <int>[1,2,3].map((e) => e+1).toList();
  print(numere);



  final numere2 = <int>[1,2,3,7].expand((int element) => <int>[if(element%2==1)  element,element]).toList();
  print(numere2);

  final numere3 = <int>[1,2,3,7,8,10,9].expand((int element) => <int>[if(element%2==1)  element,if(element%2==1) element]).toList(); /* toSet -> ca sa nu se repete*/
  print(numere3);

  final Map<String,int> map = <String,int>{'sdadsa':7, ...<String,int>{'gfd':66},};
  print(map);
  print(map.entries);
  print(map.keys);
  map['sdadsdsdas']=22;
  print(map);
  final List<dynamic> listaD = <dynamic>[10,22, ...map.keys];
  print(listaD);




}
