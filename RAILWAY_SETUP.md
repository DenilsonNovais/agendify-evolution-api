# 🚀 Deploy Evolution API no Railway - Guia Prático

## ✅ Próximos Passos

### PASSO 1: Acesse Railway
1. Vá para https://railway.app
2. Clique em **"Start Project"**
3. Selecione **"Deploy from GitHub"**

### PASSO 2: Conecte GitHub
1. Clique em **"Connect GitHub"**
2. Autorize Railway a acessar seus repositórios
3. Selecione: **agendify-evolution-api**
4. Clique em **"Deploy"**

Railway detectará o `Dockerfile` automaticamente ✅

---

## 🗄️ PASSO 3: Adicionar PostgreSQL

No painel Railway:
1. Clique em **"Add Service"** (+ ícone)
2. Procure por **"PostgreSQL"**
3. Clique em **"Add"**

Railway cria e conecta automaticamente!

---

## ⚙️ PASSO 4: Configurar Variáveis de Ambiente

### No painel do Railway:

**Serviço Evolution** → Abra a aba **"Variables"** → Adicione:

```
AUTHENTICATION_TYPE = apikey
```

**Gere uma chave forte:**
```bash
openssl rand -hex 32
```

**Adicione:**
```
AUTHENTICATION_API_KEY = [cole-aqui-a-chave-gerada]
```

**Database - Tipo:**
```
DATABASE_ENABLED = true
DATABASE_PROVIDER = postgresql
```

**Database - Connection (Railway detecta automaticamente):**
```
DATABASE_CONNECTION_URI = ${{Postgres.DATABASE_URL}}
```

**Database - Dados:**
```
DATABASE_SAVE_DATA_INSTANCE = true
DATABASE_SAVE_DATA_NEW_MESSAGE = true
DATABASE_SAVE_MESSAGE_UPDATE = true
DATABASE_SAVE_DATA_CONTACTS = true
DATABASE_SAVE_DATA_CHATS = true
```

**Cache:**
```
CACHE_REDIS_ENABLED = false
DEL_INSTANCE = false
```

### Depois: Clique em **"Redeploy"** ⏳

---

## 🧪 PASSO 5: Testar Conexão

1. Pegue a URL do Railway (tipo: `https://agendify-evolution-xxxxx.up.railway.app`)

2. No terminal:
```bash
EVOLUTION_URL="sua-url-railway"
API_KEY="sua-api-key"

curl -X GET "$EVOLUTION_URL/instance/fetchInstances" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json"
```

Deve retornar: `{"success": true, "data": []}`

---

## 📝 PASSO 6: Atualizar Backend Agendify

Quando o Evolution estiver rodando, volte ao repo agenda-whatsapp e:

```bash
cd /home/denilson/Projetos/agenda-whatsapp

cat > .env.evolution << 'EOF'
# Evolution API em Produção (Railway)
AI_EVOLUTION_API_URL=https://sua-url-railway-aqui.up.railway.app
AI_EVOLUTION_API_KEY=sua-api-key-aqui
AI_WEBHOOK_URL=http://agendify-api:8080/ai/webhook
AI_WEBHOOK_SECRET=$(openssl rand -hex 32)
EOF
```

---

## 📊 Checklist

```
☐ Repositório GitHub enviado
☐ Railway conectado ao repo
☐ Dockerfile detectado
☐ PostgreSQL adicionado
☐ Todas as variáveis adicionadas
☐ Deploy completado
☐ URL do Railway acessível
☐ Teste de conectividade passou
```

---

**Próximo: Acesse https://railway.app e comece! 🎉**
