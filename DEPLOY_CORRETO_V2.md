# 🚀 Deploy Evolution API no Railway - Guia Correto (Versão 2)

## ⚠️ O que Deu Errado Antes

❌ A variável `DATABASE_PROVIDER` foi deixada vazia no Railway
❌ Nem todas as variáveis foram preenchidas
❌ PostgreSQL pode não ter sido conectado corretamente

---

## ✅ PASSO 1: Criar Novo Projeto no Railway

1. Vá para https://railway.app
2. Clique em **"+ New Project"**
3. Selecione **"Deploy from GitHub"**
4. Autorize o Railway a acessar GitHub (se não tiver feito)
5. Selecione o repositório: **agendify-evolution-api**
6. Selecione a branch: **main**
7. Clique em **"Deploy"**

Aguarde 5-10 minutos o build do Docker ⏳

---

## ✅ PASSO 2: Adicionar PostgreSQL (IMPORTANTE!)

No painel Railway do seu projeto:

1. Clique em **"+ Add"** (botão com +)
2. Procure por **"PostgreSQL"**
3. Clique em **"Add PostgreSQL"**
4. Railroad cria automaticamente! ✅

**Espere 1-2 minutos pelo banco ser criado**

---

## ✅ PASSO 3: Configurar Variáveis de Ambiente (SEM DEIXAR VAZIAS!)

### 3.1 Gere uma Chave Segura

No seu terminal:
```bash
openssl rand -hex 32
```

Salve a saída em um bloco de notas. Exemplo:
```
a3f8c9d2e1b7f4c6a9d3e8f1b4c7a0d3e6f9a2b5c8d1e4f7a0b3c6d9e2f5a8
```

### 3.2 No Painel Railway - Serviço Evolution

1. Clique no serviço **Evolution** (não no PostgreSQL)
2. Abra a aba **"Variables"**
3. **Adicione TODAS as variáveis abaixo** (nenhuma em branco!)

#### Variável 1
```
Nome:  AUTHENTICATION_TYPE
Valor: apikey
```

#### Variável 2
```
Nome:  AUTHENTICATION_API_KEY
Valor: [cole-aqui-sua-chave-gerada]
```

Exemplo:
```
AUTHENTICATION_API_KEY = a3f8c9d2e1b7f4c6a9d3e8f1b4c7a0d3e6f9a2b5c8d1e4f7a0b3c6d9e2f5a8
```

#### Variável 3
```
Nome:  DATABASE_ENABLED
Valor: true
```

#### Variável 4 ⭐ (ESTE ERA O PROBLEMA!)
```
Nome:  DATABASE_PROVIDER
Valor: postgresql
```

**⚠️ NÃO DEIXE EM BRANCO! DEVE SER: `postgresql`**

#### Variável 5
```
Nome:  DATABASE_CONNECTION_URI
Valor: ${{Postgres.DATABASE_URL}}
```

**Railway substitui automaticamente pela connection string do PostgreSQL**

#### Variável 6
```
Nome:  DATABASE_SAVE_DATA_INSTANCE
Valor: true
```

#### Variável 7
```
Nome:  DATABASE_SAVE_DATA_NEW_MESSAGE
Valor: true
```

#### Variável 8
```
Nome:  DATABASE_SAVE_MESSAGE_UPDATE
Valor: true
```

#### Variável 9
```
Nome:  DATABASE_SAVE_DATA_CONTACTS
Valor: true
```

#### Variável 10
```
Nome:  DATABASE_SAVE_DATA_CHATS
Valor: true
```

#### Variável 11
```
Nome:  CACHE_REDIS_ENABLED
Valor: false
```

#### Variável 12
```
Nome:  DEL_INSTANCE
Valor: false
```

---

## ✅ PASSO 4: Redeploy (IMPORTANTE!)

Depois de adicionar TODAS as variáveis:

1. Clique em **"Redeploy"** (botão ao lado do nome do serviço)
2. Aguarde 2-3 minutos ⏳
3. O container vai reiniciar com as novas variáveis

---

## 🧪 PASSO 5: Testar Conexão

### 5.1 Pegue a URL do Railway

No painel Railway, você verá algo como:
```
https://agendify-evolution-xxxxx.up.railway.app
```

Copie essa URL!

### 5.2 Teste no Terminal

```bash
# Substitua os valores
EVOLUTION_URL="https://agendify-evolution-xxxxx.up.railway.app"
API_KEY="a3f8c9d2e1b7f4c6a9d3e8f1b4c7a0d3e6f9a2b5c8d1e4f7a0b3c6d9e2f5a8"

# Teste 1: Fetch Instances
curl -X GET "$EVOLUTION_URL/instance/fetchInstances" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json"

# Resposta esperada:
# {"success": true, "data": []}
```

### 5.3 Teste via Navegador

Acesse (você deve ver a documentação da Evolution):
```
https://agendify-evolution-xxxxx.up.railway.app/api/doc
```

---

## 🔍 PASSO 6: Verificar Logs se Tiver Erro

No painel Railway:

1. Clique no serviço **Evolution**
2. Abra a aba **"Logs"**
3. Procure por erros como "DATABASE_PROVIDER", "database", etc.

Se houver erro, volte ao **PASSO 3** e verifique se ALL variáveis estão preenchidas!

---

## 📋 Checklist Final (NÃO PULE!)

```
VARIÁVEIS DO EVOLUTION:
☐ AUTHENTICATION_TYPE = apikey
☐ AUTHENTICATION_API_KEY = [preenchido]
☐ DATABASE_ENABLED = true
☐ DATABASE_PROVIDER = postgresql ⭐ (NADA DE VAZIO!)
☐ DATABASE_CONNECTION_URI = ${{Postgres.DATABASE_URL}}
☐ DATABASE_SAVE_DATA_INSTANCE = true
☐ DATABASE_SAVE_DATA_NEW_MESSAGE = true
☐ DATABASE_SAVE_MESSAGE_UPDATE = true
☐ DATABASE_SAVE_DATA_CONTACTS = true
☐ DATABASE_SAVE_DATA_CHATS = true
☐ CACHE_REDIS_ENABLED = false
☐ DEL_INSTANCE = false

DEPLOYMENT:
☐ PostgreSQL foi adicionado?
☐ Todas as 12 variáveis foram adicionadas?
☐ Fez o Redeploy?
☐ Container está rodando (status verde)?
☐ Teste de conectividade passou?
```

---

## 💡 Dicas Importantes

✅ **Guarde a URL do Railway** em lugar seguro
✅ **Guarde a API Key** (não dá pra recuperar depois)
✅ **NÃO DEIXE VARIÁVEIS VAZIAS** - preencha todas!
✅ **Se tiver erro, verifique os logs** (80% dos problemas aparecem lá)
✅ **Espere o Redeploy terminar** antes de testar

---

## 🚀 Quando Estiver Funcionando

Volte ao repo agenda-whatsapp e:

```bash
cd /home/denilson/Projetos/agenda-whatsapp

cat > .env.evolution << 'EOF'
# Evolution API em Produção (Railway)
AI_EVOLUTION_API_URL=https://sua-url-railway-aqui.up.railway.app
AI_EVOLUTION_API_KEY=sua-api-key-aqui
AI_WEBHOOK_URL=http://agendify-api:8080/ai/webhook
AI_WEBHOOK_SECRET=gere-com-openssl-rand-hex-32
EOF
```

---

**Começar agora? Vá para https://railway.app** 🎉
