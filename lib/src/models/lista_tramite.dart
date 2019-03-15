class TramiteDetalleList {
  final List<TramiteDetalle> tramiteDetalles;

  TramiteDetalleList({
    this.tramiteDetalles,
  });

  factory TramiteDetalleList.fromJson(List<dynamic> parsedJson) {
    List<TramiteDetalle> tramiteDetalles = new List<TramiteDetalle>();
    tramiteDetalles =
        parsedJson.map((i) => TramiteDetalle.fromJson(i)).toList();

    return TramiteDetalleList(tramiteDetalles: tramiteDetalles);
  }
}

class TramiteDetalle {
  final String idTramiteDetalle,
      fecha,
      tipoDocumento,
      nrodocumento,
      oficinaOrigen,
      oficinaDestino,
      asunto,
      nroFolios,
      adjuntoOtros,
      estado,
      primerHijo;

  TramiteDetalle({
    this.idTramiteDetalle,
    this.fecha,
    this.tipoDocumento,
    this.nrodocumento,
    this.oficinaOrigen,
    this.oficinaDestino,
    this.asunto,
    this.nroFolios,
    this.adjuntoOtros,
    this.estado,
    this.primerHijo,
  });

  factory TramiteDetalle.fromJson(Map<String, dynamic> json) {
    return TramiteDetalle(
      idTramiteDetalle: json["IdTramiteDetalle"],
      fecha:json["Fecha"],
      tipoDocumento:json["TipoDocumento"],
      nrodocumento: json["Nrodocumento"],
      oficinaOrigen:json["OficinaOrigen"],
      oficinaDestino: json["OficinaDestino"],
      asunto: json["Asunto"],
      nroFolios: json["NroFolios"],
      adjuntoOtros: json["Adjunto_Otros"],
      estado: json["Estado"],
      primerHijo: json["PrimerHijo"],
    );
  }
}
