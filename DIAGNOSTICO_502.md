# 🔧 Diagnosticar Erro 502

## ❌ O Que Significa

```
{
    "status": "error",
    "code": 502,
    "message": "Application failed to respond"
}
```

A aplicação Evolution API **não está respondendo**. Ela pode estar:
- ❌ Crashando na inicialização
- ❌ Com variáveis de ambiente vazias
- ❌ Sem conexão com PostgreSQL
- ❌ Com erro interno

---

## 🔍 Passo 1: Verificar os Logs

No painel Railway:

1. Clique no serviço **agendify-evolution-api**
2. Abra a aba **"Logs"**
3. **Procure por erros** (mensagens em vermelho)
4. **Copie e cole aqui**

---

## 🔧 Passo 2: Checklist de Variáveis

No painel Railway → Serviço Evolution → Aba **"Variables"**

Verifique se **TODAS** essas variáveis estão preenchidas (nenhuma em branco):

```
☐ AUTHENTICATION_TYPE = apikey
☐ AUTHENTICATION_API_KEY = [preenchido] ⭐ IMPORTANTE
☐ DATABASE_ENABLED = true
☐ DATABASE_PROVIDER = postgresql ⭐ IMPORTANTE
☐ DATABASE_CONNECTION_URI = ${{Postgres.DATABASE_URL}} ⭐ IMPORTANTE
☐ DATABASE_SAVE_DATA_INSTANCE = true
☐ DATABASE_SAVE_DATA_NEW_MESSAGE = true
☐ DATABASE_SAVE_MESSAGE_UPDATE = true
☐ DATABASE_SAVE_DATA_CONTACTS = true
☐ DATABASE_SAVE_DATA_CHATS = true
☐ CACHE_REDIS_ENABLED = false
☐ DEL_INSTANCE = false
```

**Se alguma estiver vazia ou faltando:**
1. Adicione/complete
2. Clique em **"Redeploy"**
3. Aguarde 2-3 minutos

---

## 🆘 Causas Mais Comuns do 502

### Causa 1: Variáveis Vazias
```
❌ DATABASE_PROVIDER = [vazio]
❌ AUTHENTICATION_API_KEY = [vazio]
❌ DATABASE_CONNECTION_URI = [vazio]
```

**Solução:** Preencha todas as variáveis

---

### Causa 2: PostgreSQL Não Conectou
```
Error: failed to initialize database
Error: connection refused
```

**Solução:**
1. Verifique se PostgreSQL está **Online** (status verde)
2. Procure pela variável `DATABASE_URL` no painel PostgreSQL
3. Copie e use em `DATABASE_CONNECTION_URI`

---

### Causa 3: Versão da Imagem com Erro
```
Error: image not found
Error: cannot pull image
```

**Solução:**
- Verifique a imagem no Dockerfile: `FROM atendai/evolution-api:v2.1.1`
- Tente redeploy manual

---

### Causa 4: Porta Bloqueada
```
Error: bind: permission denied
Error: address already in use
```

**Solução:** Railway gerencia as portas automaticamente, não precisa fazer nada

---

## 📋 Passo a Passo para Resolver

1. **Abra os logs** do Railway
2. **Copie as mensagens de erro**
3. **Identifique qual erro é**
4. **Execute a solução correspondente**
5. **Faça Redeploy**
6. **Aguarde 2-3 minutos**
7. **Teste novamente:**
   ```bash
   curl -X GET "https://agendify-evolution-api-production.up.railway.app:8080/instance/fetchInstances" \
     -H "Authorization: Bearer sua-api-key"
   ```

---

## 🆘 Se Nada Funcionar

1. **Delete o serviço** e crie novo
2. **Adicione PostgreSQL PRIMEIRO**
3. **Depois configure TODAS as variáveis**
4. **Depois faça deploy**

Ordem importante! ⚠️
