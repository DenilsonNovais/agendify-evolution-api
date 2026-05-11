# 🚀 Evolution API para Agendify

Evolution API hospedada no Railway para integração com Agendify.

## 📋 Variáveis de Ambiente Necessárias

```env
AUTHENTICATION_TYPE=apikey
AUTHENTICATION_API_KEY=<sua-chave-segura>
DATABASE_ENABLED=true
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=<postgresql-connection-string>
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
CACHE_REDIS_ENABLED=false
DEL_INSTANCE=false
```

## 🧪 Teste de Conectividade

```bash
EVOLUTION_URL="https://seu-railway-url"
API_KEY="sua-chave-aqui"

curl -X GET "$EVOLUTION_URL/instance/fetchInstances" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json"
```

## 📖 Documentação

- [Evolution API Docs](https://doc.evolution-api.com/v2/)
- [Railway Docs](https://docs.railway.app/)
