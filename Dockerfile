# ESTÁGIO 1: Construção
FROM node:18-alpine AS builder
WORKDIR /app

# Copia os arquivos de configuração
COPY package*.json ./

# Instala TUDO (incluindo o vite)
RUN npm install

# Copia o resto dos arquivos
COPY . .

# Executa o build usando o caminho direto do binário para não ter erro
RUN ./node_modules/.bin/vite build

# ESTÁGIO 2: Produção (NGINX)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
