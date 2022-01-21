import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/registros/registro%20aliado/primerRegistroAliado.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/consultarClienteAdministrador/consultarClienteAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/crear/categorias.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/crear/crear.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/perfilAdministrador/editarPerfilAdministrador/EditarPerfilAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearAliadoAdmin/CrearAliadoAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearAliadoAdmin/primerRegistroAliadoAdmin.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/seleccionCrear/seleccionCrear.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/publicarAliado/publicarAliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/misOrdenes/mis_ordenes_aliado.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAsistente/mis_ordenes_asistente.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editarUsuario.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/A%C3%B1adirProductos.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/Existencias.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/CategoriaSucursal/menuSucursal.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAsistente/sucursal_asistente.dart';
import 'package:traelo_app/src/pages/vistasAliado/usuariosAliado/crearUsuariosAliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/usuariosAliado/escojerSucursal.dart';
import 'package:traelo_app/src/pages/vistasAliado/usuariosAliado/usuariosAliado.dart';
import 'package:traelo_app/src/pages/vistasCliente/mostrarProveedor/ordenar/ordenar.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/detallesDeLaOrden/detallesDeLaOrdenRepartidor.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/perfilRepartidor/editarPerfilRepartidor/Documentos.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/perfilRepartidor/editarPerfilRepartidor/editar_perfil_repartidor.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/mapa_page.dart';
import 'package:traelo_app/src/utils/Widgets/cardBlancaScroll/prueba.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/adjuntar_SOAT.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/adjuntar_documento_ID.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/adjuntar_fotos_del_vehiculo.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/adjuntar_targeta_de_propiedad.dart';
import 'package:traelo_app/src/pages/registros/registroCliente/registrar_cliente_page.dart';
import 'package:traelo_app/src/pages/registros/registro%20aliado/registro_aliado_page.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/registro_repartidor.dart';
import 'package:traelo_app/src/pages/registros/seleccion_registro.dart';
import 'package:traelo_app/src/pages/registros/registroRepartidor/siguiente_registro_repartidor.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/Estadisticas/EstadisticasPage.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/InicioAdministrador/inicioAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/actualizarRepartidorGeneral/actualizarRepartidor.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/consultarRepartidorAdministrador/consultarRepartidorAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/crearRepartidor/SiguientePagCrearRepartidor/siguientePagRepartidor.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/crearRepartidor/crearRepartidor.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/general/repartidoresAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/RapartidoresAdministrador/principal/repartidoresAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/aliadosAdministrador/actualizarAliado/actualizarAliado.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/aliadosAdministrador/consultar/consultarAliadosAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/aliadosAdministrador/crearAliadoAdmin/CrearAliadoAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/aliadosAdministrador/principal/aliadosAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/actualizar/actualizarClienteGeneral.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/actualizarCliente/actCliente/ActualizarCliente.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/actualizarCliente/general/actualizarClienteGeneral.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/consultarClienteAdministrador%20copy/consultarClienteAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/general/general.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/clientesAdministrador/crearCliente/registrar_cliente_page.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/consultasAdministrador/consultasAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/editarPerfilAdministrador/EditarPerfilAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/ordenes/detallesDeLaOrdenAdmin.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/ordenes/ordenesAdminPage.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/perfilAdministrador/perfilAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearAliadoAdmin/CrearAliadoAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearCliente/registrar_cliente_page.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/ActualizarUsuarioAdministrador/ActualizarUsuario.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/actualizarUsuariosAdministradorGeneral/ActualizarUsuariosGeneral.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/consultarUsuariosAdministrador/consultarUsuarioAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearNuevoUsuarioAdministrador/CrearNuevoUsuarioAdministrador.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearRepartidor/SiguientePagCrearRepartidor/siguientePagRepartidor.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/crearRepartidor/crearRepartidor.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/usuariosAdministrador/general/usuariosAdministrador.dart';
// import 'package:traelo_app/src/pages/vistasAliado/misOrdenesAliado/mis_ordenes_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/FormularioProductosAliado/FormularioProductoAliado.dart';
import 'package:traelo_app/src/pages/vistasCliente/antojos/antojos_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/contactanos/contactanos_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/detalles%20de%20la%20orden/detalles_de_la_orden_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/direccion/direccion_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/direccion/nuevaDireccion.dart';
import 'package:traelo_app/src/pages/vistasCliente/perfil/editar_perfil.dart';
import 'package:traelo_app/src/pages/login/iniciarsesion_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/inicio/inicio_pages.dart';
import 'package:traelo_app/src/pages/vistasCliente/misOrdenes/mis_ordenes.dart';
import 'package:traelo_app/src/pages/vistasCliente/mostrarProveedor/mostrar_proveedor.dart';
import 'package:traelo_app/src/pages/vistasCliente/ordenAntojos/orden_antojos_pages.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/ordenar.dart';
import 'package:traelo_app/src/pages/vistasCliente/direccion/mis_direcciones_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/perfil/perfil_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/populares/populares_page.dart';
import 'package:traelo_app/src/pages/vistasCliente/traelooFavor/traeelofavor_page.dart';
import 'package:traelo_app/src/pages/vistasAliado/balanceAliado/balance_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/detallesDeLaOrdenAliado/detalles_de_la_orden_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editar_perfil_Aliado.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/editarProductosAliado/FormularioProductoAliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAliado/inicio_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAsistente/inicio_asistente.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/nueva_sucursal_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAsistente/editar_sucursal_asistente.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/NuevoProductoAliado/nuevo_producto_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/perfil_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/productos_aliado.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/sucursal_aliado.dart';
// import 'package:traelo_app/src/pages/vistasRepartidor/detallesDeLaOrden/detallesDeLaOrdenRepartidor.dart';
// import 'package:traelo_app/src/pages/vistasRepartidor/Estadisticas/EstadisticasPage.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/GeneraUnTicket/GeneraUnTIcket.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/Ordenes/ordenes_Repartidor.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/Wallet/SolicitudDeDineroWallet.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/Wallet/WalletRepartidor.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/balanceRepartidor/balanceRepartidor.dart';
// import 'package:traelo_app/src/pages/vistasRepartidor/detallesDeLaOrden/detallesDeLaOrdenRepartidor.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/soporte_page.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/perfilRepartidor/perfil_repartidor.dart';
import '../pages/vistasCliente/mostrarProveedor/mostrar_proveedor.dart';
// import 'package:traelo_app/src/pages/vistasRepartidor/editarPerfilRepartidor/editar_perfil_repartidor.dart';
import 'package:traelo_app/src/pages/vistasRepartidor/homeRepartidor/homePageRepartidor.dart';

Map<String, WidgetBuilder> rutas() {
  return <String, WidgetBuilder>{
    //*aqui empiezan las vistas cliente_____________________________________________________

    'IniciarSesion': (_) => IniciarSesionPage(),
    'RegistroCliente': (_) => RegistrarClientePage(),
    "SeleccionRegistro": (_) => RegistroPage(),
    "RegistroAliado": (_) => RegistroAliado(),
    "RegistroRepartidor": (_) => RegistroRepartidorPage(),
    'SiguienteRegistroRepartidor': (_) => SiguienteRegistroRepartidor(),
    'MisDirecciones': (_) => MisDirecciones(),
    'Direccion': (_) => Direccion(),
    'iniciocliente': (_) => Inicio(),
    'Perfil': (_) => PerfilPage(),
    'EditarPerfil': (_) => EditarPerfirlPage(),
    'AdjuntarId': (_) => AdjuntarDocumentoDeIdentidad(),
    'AdjuntarTargetaDePropiedad': (_) => AdjuntarTargetaDePropiedadPage(),
    'AdjuntarSoat': (_) => AdjuntarSOATPage(),
    'AdjuntarFotosDeVehiculo': (_) => AdjuntarFotoDeVehiculoPage(),
    'Contactanos': (_) => Contactanos(),
    'Populares': (_) => Populares(),
    'Ordenar': (_) => Ordenar(),
    'MisOrdenes': (_) => MisOrdenes(),
    'DetallesDeLaOrden': (context) => DetallesDeLaOrden(),
    'OrdenAntojos': (_) => OrdenAntojos(), //*tarjeta
    'proovedor': (_) => Mostrarproveedor(),
    'Antojos': (_) => Antojos(),
    'Traeelofavor': (_) => Traeelofavor(),
    //*aqui terminan las vistas cliente_____________________________________________________

    //*aqui empiezan las vistas aliado_____________________________________________________
    'PerfilAliado': (context) => PerfilAliado(),
    'EditarPerfilAliado': (_) => EditarPerfilAliado(),
    'EditarUsuarioAliado': (_) => EditarUsuarioAliado(),
    'ProductosAliados': (_) => ProductosAliados(),
    'inicioaliado': (_) => InicioAliado(),
    'inicioasistente': (_) => InicioEmpleado(),
    'MisOrdenesAliado': (_) => MisOrdenesAliado(),
    // 'MisOrdenesAsistente':(_)=>MisOrdenesAsistente(),
    'detallesDeOrdenAliado': (_) => DetallesDeOrdenAliado(),
    'NuevaSucursal': (_) => NuevaSucursal(),
    'SucursalAliado': (_) => SucursalAliado(),
    'MenuSucursal': (_) => MenuSucursal(),
    'FormularioMenu': (_) => FormularioMenu(),
    // 'NuevaSucursal': (_) => NuevaSucursal(),zzp
    'BalanceAlliado': (_) => BalanceAlliado(),
    'EditarProductoAliado': (_) => EditarProductoAliado(),
    'PrimerRegistroAliado': (_) => PrimerRegistroAliado(),
    'FormularioAnadirProducto': (_) => FormularioAnadirProducto(),
    'PublicarAliado': (_) => PublicarAliado(),
    'UsuariosAliado': (_) => UsuariosAliado(),
    "SucursalAsistente":(_)=>SucursalAsistente(),
    'SucursalesCrearUsuarioAliado': (_) => SucursalesCrearUsuarioAliado(),
    "EditarSucursalAsistente":(_)=>EditarSucursalAsistente(),
    'CrearUsuariosAliado': (_) => CrearUsuariosAliado(),
    //*aqui terminan las vistas aliado_____________________________________________________

    //*aqui empiezan las vistas repartidor_____________________________________________________
    'PerfilRepartidor': (_) => InterfazPage(),
    'editarPerfilRepartidor': (_) => EditarPerfilRepartidor(),
    'DocumentosPageRepartidor': (_) => DocumentosPageRepartidor(),
    'iniciorepartidor': (_) => HomeRepartidor(),
    'OrdenesRepartidor': (_) => OrdenesRepartidor(),
    'BalanceRepartidor': (_) => BalanceRepartidor(),
    'detallesDeOrdenRepartidor': (_) => DetallesDeOrdenRepartidor(),
    'GeneraUnTicketRepartidor': (_) => GeneraUnTicketRepartidor(),
    'WalletPage': (_) => WalletPage(),
    'solicitudDeDineroWallet': (_) => SolicitudDeDineroWallet(),
    'soporte': (_) => PagesSoporte(),
    //*aqui terminan las vistas repartidor_____________________________________________________

    //*aqui empiezan las vistas administrador_____________________________________________________
    'UsuariosAdministrador': (_) => UsuariosAdministrador(),
    'SeleccionCrearUsuario': (_) => SeleccionCrearUsuario(),
    'inicioadministrador': (_) => IniciAdministrador(),
    'PerfilAdministrador': (_) => PerfilAdministrador(),
    'EditarPerfilAdministrador': (_) => EditarPerfilAdministrador(),
    // 'CrearNuevoUsuarioAdministrador': (_) => CrearNuevoUsuarioAdministrador(),

    // 'ConsultarUsuarioAdministrador': (_) => ConsultarUsuarioAdministrador(),
    // 'ActualizarUsuariosAdministradorGeneral': (_) {
    //   return ActualizarUsuariosAdministradorGeneral();
    // },
    // 'ActualizarUsuarioAdministrador': (_) => ActualizarUsuarioAdministrador(),
    'RepartidoresAdministradores': (_) => RepartidoresAdministradores(),
    'CrearRepartidor': (_) => CrearRepartidor(),
    'SiguientePagCrearRepartidor': (_) => SiguientePagCrearRepartidor(),
    'PrimerRegistroAliadoAdmin':(_)=>PrimerRegistroAliadoAdmin(),
    'SegundaPaginaCrearAliadoAdmin':(_)=>SegundaPaginaCrearAliadoAdmin(),
    'ConsultarRepartidorAdministrador': (_) { return ConsultarRepartidorAdministrador(); },
    'ActualizarRepartidorGeneral': (_) => ActualizarRepartidorGeneral(),

    'AliadosAdministrador': (_) => AliadosAdministrador(),
    'ordenesAdminPage': (_) => OrdenesAdminPage(),
    'detallesDeLaOrdenAdmin': (_) => DetallesDeLaOrdenAdmin(),

    'ClientesAdministrador': (_) => ClientesAdministrador(),
    'RegistrarClienteAdminPage': (_) => RegistrarClienteAdminPage(),
    'ConsultarClienteAdministrador': (_) => ConsultarClienteAdministrador(),
    'ActualizarClienteAdministrador': (_) => ActualizarClienteGeneral(),
    'NuevaDireccionPage': (_) => NuevaDireccionPage(),
    // 'MapaPage': (_) =>  MapaPage(),
    // 'ActualizarCliente':(_)=>ActualizarCliente(),
    // 'CearAliadoAdmin': (_) => CearAliadoAdmin(),
    // 'CearAliadoAdmin': (_) => CearAliadoAdmin (),
    'ConsultarAliadoAdmin': (_) => ConsultarAliadoAdmin(),
    'ActualizarAliadoAdmin': (_) => ActualizarAliado(),
    'Crear': (_) => Crear(),
    'Categorias': (_) => Categorias(),
    'PruebaWidget': (_) => PruebaWidget(),
    'Estadisticas': (_) => Estadiscas(),
    'ConsultasAdministrador': (_) => ConsultasAdministrador(),
  };
}
