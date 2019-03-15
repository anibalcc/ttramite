import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:apktramite2019/src/models/lista_tramite.dart';

import 'package:http/http.dart' as http;

Future<List<TramiteDetalle>> fetchDetalles(
    http.Client client, String idTramiteDetalle) async {
  final _body = "IdTramiteDetalle=" + idTramiteDetalle;
  final response = await client.post(
      'http://190.108.89.83/TramiteDocumentario2019/tramites/listar_historial',
      body: _body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      encoding: Encoding.getByName("utf-8"));

  final results = json.decode(response.body);
  print("===>2 ${results}");

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDetalles, response.body);
}

// A function that converts a response body into a List<Photo>
List<TramiteDetalle> parseDetalles(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<TramiteDetalle>((json) => TramiteDetalle.fromJson(json))
      .toList();
}

class ListaTramiteDetallePage extends StatefulWidget {
  final String _idTramiteDetalle;

  ListaTramiteDetallePage(this._idTramiteDetalle);

  @override
  _ListaTramiteDetalle createState() => _ListaTramiteDetalle();
}

class _ListaTramiteDetalle extends State<ListaTramiteDetallePage> {
  static const String _baseDetalleTramite =
      "http://190.108.89.83/TramiteDocumentario2019/tramites/listar_historial";
  @override
  void initState() {
    super.initState();
    //_get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEGUIMIENTO TRAMITE"),
      ),
      body: FutureBuilder<List<TramiteDetalle>>(
        future: fetchDetalles(http.Client(), widget._idTramiteDetalle),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? DetalleList(detalles: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DetalleList extends StatelessWidget {
  final List<TramiteDetalle> detalles;

  DetalleList({Key key, this.detalles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: detalles.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          color: Color.fromRGBO(240, 240, 240, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2, // 20%
                    child: Text('Fecha : ',style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(166, 34, 46, 1),
                      )),
                  ),
                  Expanded(
                    flex: 8, // 20%
                    child: Text(detalles[index].fecha, style: TextStyle(fontSize: 13.0)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Origen : ',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(166, 34, 46, 1),
                      )),
                  Text(
                    detalles[index].oficinaOrigen,
                    style: TextStyle(fontSize: 13.0),
                    maxLines: 10,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Destino : ',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(166, 34, 46, 1),
                      )),
                  Text(detalles[index].oficinaDestino,
                      style: TextStyle(fontSize: 13.0)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
