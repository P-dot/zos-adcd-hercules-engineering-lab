# CICS - CEDA / CEMT

## Definir DB2CONN

```text
CEDA DEFINE DB2CONN(CICSDB2) GROUP(ALL4) DB2ID(DB9G)
```

## Instalar solo DB2CONN

```text
CEDA INSTALL DB2CONN(CICSDB2) GROUP(ALL4)
```

## Comprobar conexión

```text
CEMT I DB2CONN
```

Resultado conseguido:

```text
CONNECTED
```

## Persistencia

```text
CEDA ADD GROUP(ALL4) LIST(XYZLIST)
CEDA EXPAND LIST(XYZLIST)
```

Resultado esperado:

```text
ALL4
```
