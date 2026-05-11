# 🔧 Solução: Database Provider Invalid

## ❌ Problema
```
Error: Database provider  invalid.
```

Isso significa que `DATABASE_PROVIDER` está vazio ou com valor errado no Railway.

---

## ✅ Solução: Configurar Variáveis Corretamente

### No painel Railway - Serviço Evolution

Acesse: **Variables** → Verifique/Adicione as variáveis abaixo:

#### 1. **AUTHENTICATION_TYPE**
```
AUTHENTICATION_TYPE = apikey
```

#### 2. **AUTHENTICATION_API_KEY** (gere uma chave segura)
```bash
# No terminal, execute:
openssl rand -hex 32
```

Copie a saída (exemplo):
```
AUTHENTICATION_API_KEY = a3f8c9d2e1b7f4c6a9d3e8f1b4c7a0d3e6f9a2b5c8d1e4f7a0b3c6d9e2f5a8
```

#### 3. **DATABASE_ENABLED** ⭐ IMPORTANTE
```
DATABASE_ENABLED = true
```

#### 4. **DATABASE_PROVIDER** ⭐ IMPORTANTE (este é o erro!)
```
DATABASE_PROVIDER = postgresql
```

**Não deixe em branco!** Deve ser `postgresql` (minúsculas)

#### 5. **DATABASE_CONNECTION_URI**

No painel do Railway, abra o serviço **PostgreSQL** e copie a connection string.

OU use a variável Railway predefinida:
```
DATABASE_CONNECTION_URI = ${{Postgres.DATABASE_URL}}
```

#### 6. **DATABASE_SAVE_DATA_*** (Dados)
```
DATABASE_SAVE_DATA_INSTANCE = true
DATABASE_SAVE_DATA_NEW_MESSAGE = true
DATABASE_SAVE_MESSAGE_UPDATE = true
DATABASE_SAVE_DATA_CONTACTS = true
DATABASE_SAVE_DATA_CHATS = true
```

#### 7. **CACHE_REDIS_ENABLED**
```
CACHE_REDIS_ENABLED = false
```

#### 8. **DEL_INSTANCE**
```
DEL_INSTANCE = false
```

---

## 🔄 Após Adicionar as Variáveis

1. Clique em **"Redeploy"**
2. Aguarde o container reiniciar (2-3 minutos)
3. Verifique os logs

---

## 🧪 Teste de Conectividade

Quando estiver rodando:

```bash
EVOLUTION_URL="https://sua-url-railway.up.railway.app"
API_KEY="sua-chave-aqui"

curl -X GET "$EVOLUTION_URL/instance/fetchInstances" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json"
```

Deve retornar:
```json
{"success": true, "data": []}
```

---

## 📋 Checklist de Variáveis

```
☐ AUTHENTICATION_TYPE = apikey
☐ AUTHENTICATION_API_KEY = [preenchido com chave segura]
☐ DATABASE_ENABLED = true
☐ DATABASE_PROVIDER = postgresql (NÃO DEIXAR EM BRANCO!)
☐ DATABASE_CONNECTION_URI = [preenchido ou ${{Postgres.DATABASE_URL}}]
☐ DATABASE_SAVE_DATA_INSTANCE = true
☐ DATABASE_SAVE_DATA_NEW_MESSAGE = true
☐ DATABASE_SAVE_MESSAGE_UPDATE = true
☐ DATABASE_SAVE_DATA_CONTACTS = true
☐ DATABASE_SAVE_DATA_CHATS = true
☐ CACHE_REDIS_ENABLED = false
☐ DEL_INSTANCE = false
```

---

## 🆘 Se o Erro Persistir

1. **Verifique os logs do Railway:**
   - Serviço Evolution → **Logs**
   - Procure por "DATABASE_PROVIDER" ou "database provider"

2. **Tente redeployed manualmente:**
   - Clique em **"Redeploy"** novamente

3. **Verifique PostgreSQL:**
   - O serviço PostgreSQL está online?
   - Teste a connection string manualmente

4. **Se nada funcionar:**
   - Remova todas as variáveis
   - Adicione uma de cada vez
   - Faça redeploy após cada adição
