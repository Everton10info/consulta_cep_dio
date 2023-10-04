class Cep {
  final String? cep;
  final String? logradouro;
  final String? bairro;
  final String? localidade;
  final String? uf;

  Cep({
    this.cep,
    this.logradouro,
    this.bairro,
    this.localidade,
    this.uf,
  });
  static Map<String, dynamic> toJson(Cep cep) {
    return {
      'code': cep.cep,
      'logradour': cep.logradouro,
      'bairro': cep.bairro,
      'localidade': cep.localidade,
      'uf': cep.uf
    };
  }

  static Cep fromJson(Map<String, dynamic> json) {
    return Cep(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
    );
  }
}
