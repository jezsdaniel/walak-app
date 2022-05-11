String getUserTypeName(int userType) {
  switch (userType) {
    case 1:
      return 'Administrador';
    case 2:
      return 'Revendedor';
    case 3:
      return 'Proveedor';
    case 5:
      return 'Gestor de servicios';
    case 6:
      return 'Broker';
    default:
      return 'Usuario';
  }
}
